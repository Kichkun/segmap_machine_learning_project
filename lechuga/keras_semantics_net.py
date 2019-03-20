from __future__ import print_function
from tensorflow import keras
import numpy as np
import tensorflow as tf
from segment_encoder.core.generator import EncoderGenerator, EncoderSemanticsGenerator
from sklearn.model_selection import GroupShuffleSplit
from sklearn.pipeline import Pipeline
from segment_encoder.tools.segment_tools import EigenAligner, CoordinatesRescaler
from segment_encoder.tools.voxel_tools import Voxelizer
from segment_encoder.tools.plot_tools import plot_segment_voxelbox
import pandas as pd
from segment_encoder.core.generator import EncoderGenerator, EncoderSemanticsGenerator
from sklearn.pipeline import Pipeline
from segment_encoder.tools.segment_tools import EigenAligner, CoordinatesRescaler
from segment_encoder.tools.voxel_tools import Voxelizer
from segment_encoder.tools.plot_tools import plot_segment_voxelbox

from plot_roc import get_roc_pairs, get_roc_curve
from dataset import Dataset
from generator import Generator
from preprocessor import Preprocessor
import matplotlib.pyplot as plt
import os
Input, Dense, Dropout = tf.keras.layers.Input,tf.keras.layers.Dense,tf.keras.layers.Dropout
Activation = tf.keras.layers.Activation
models = tf.keras.models
Model = tf.keras.models.Model


N_CLASSES = 3
EPOCHS = 1
DATASET_PATH = "./datasets_npy/"
DATASET = 18
LOG_PATH = './semantic_logs/'
LABELS_PATH = './dataset'+str(DATASET)+'/labels_database.csv'
VOXEL_SHAPE = np.array((32,32,16))
batch_size = 1
BATCH_SIZE = 16
segments = np.load(os.path.join(DATASET_PATH, 'segments'+str(DATASET)+'.npy'))
ids = np.load(os.path.join(DATASET_PATH, 'ids'+str(DATASET)+'.npy'))
n_ids=np.unique(ids).size
unique_ids=np.unique(ids)
labels = np.array(pd.read_csv(LABELS_PATH).values)
total = np.loadtxt(LABELS_PATH)
labels = total[:, 1].astype(int)
lids = total[:, 0]
labels_dict = dict(zip(lids, labels))
labels=np.array([labels_dict[i] for i in ids])

model = models.load_model("./logs_keras_tb/model_data18_epochs50.h5", compile = False)
encoder = Model([model.layers[0].input, model.layers[8].input], model.layers[13].output)
encoder.set_weights(model.get_weights())

preprocessing_pipeline = Pipeline([
	('EigenAligner', EigenAligner()),
	('CoordinatesRescaler', CoordinatesRescaler(scale_method="fit",
												center_method="mean",
												voxel_shape=VOXEL_SHAPE)),
	('Voxelizer', Voxelizer(voxel_shape = VOXEL_SHAPE)),
	# ('VoxelNormalizer', VoxelNormalizer(train_ids=train_ids))
])

batch_generator=EncoderGenerator(nums=np.arange(segments.size),
segments=segments,
ids=ids,
pipeline=preprocessing_pipeline,
batch_size=batch_size, # BATCH_SIZE
n_classes=unique_ids.size, shuffle=False)
batch_descriptor = encoder.predict_generator(batch_generator)
batch_descriptor=np.array(batch_descriptor).reshape(-1,64)


class SemanticsGenerator(tf.keras.utils.Sequence):

    def __init__(self, nums, descriptors, labels,batch_size=32,
                 n_classes=3, shuffle=True):

        self.batch_size = batch_size
        self.nums = nums
        self.n_classes = n_classes
        self.shuffle = shuffle
        self.descriptors = descriptors
        self.on_epoch_end()
        self.labels=labels

    def __len__(self):

        '''Denotes the number of batches per epoch'''

        return int(self.nums.size // self.batch_size)

    def __getitem__(self, index):

        '''Generate one batch of data'''

        # Generate indexes of the batch
        indexes = self.indexes[index*self.batch_size : (index+1)*self.batch_size]

        # Find list of IDs
        nums_temp=self.nums[indexes] # to change

        # Generate data
        X, y = self.__data_generation(nums_temp)
        print(X.shape)
        X = X.reshape(X.shape[0],1,X.shape[1],1)
        return X, y

    def on_epoch_end(self):

        '''Updates indexes after each epoch'''

        self.indexes = np.arange(self.nums.size)
        if self.shuffle == True:
            np.random.shuffle(self.indexes)

    def __data_generation(self, nums_temp):

        '''Generates data containing batch_size samples'''

        # Initialization
        X = self.descriptors[nums_temp]
        y = self.labels[nums_temp]
        y=tf.keras.utils.to_categorical(y, num_classes=self.n_classes)
        y = y.reshape(y.shape[0], 1, self.n_classes)
        # Generate data

        # output batch with onehot labels
        return X, y

input_descriptor = Input(shape=(1,64))
y = Dense(64)(input_descriptor)
y = Dropout(0.5)(y)
y = Dense(N_CLASSES)(y)
classified = Activation('softmax', name='classification_output')(y)

semantics = Model(inputs=input_descriptor, outputs=classified)

semantics.compile(optimizer='adamax', loss='categorical_crossentropy')

# split data ============================================================================

train_part=0.7
train_n=int(0.7*unique_ids.size)
train_unique_ids=unique_ids[:train_n]
test_unique_ids=unique_ids[train_n:]
train_ids=[i for i, id in enumerate(ids) if id in train_unique_ids]
train_ids = []

shuf = GroupShuffleSplit(n_splits=1, test_size=0.3, train_size=0.7)

for train_index, test_index in shuf.split(segments, labels, ids):
    pass

partition = {}
partition['train'] = train_index
partition['test'] = test_index

training_generator=SemanticsGenerator(nums=partition['train'],descriptors = batch_descriptor,batch_size=BATCH_SIZE,n_classes=N_CLASSES,labels=labels)

test_generator=SemanticsGenerator(nums=partition['test'],descriptors = batch_descriptor,batch_size=BATCH_SIZE,n_classes=N_CLASSES,labels=labels)


history_train = semantics.fit_generator(generator=training_generator, validation_data=test_generator, epochs=EPOCHS)
pd.DataFrame(history_train.history).to_csv(LOG_PATH+"history_train.csv")