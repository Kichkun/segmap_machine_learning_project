
# ==========================================================================================
# verify Generator with CNN =============================================================

import numpy as np
import pandas as pd
from mpl_toolkits.mplot3d import Axes3D
import matplotlib.pyplot as plt
import os
# from dataset import Dataset
# from generator import Generator
# from classifiertools import get_default_preprocessor
# from preprocessor import Preprocessor

from segment_encoder.core.generator import EncoderGenerator, EncoderSemanticsGenerator
import tensorflow as tf
from sklearn.model_selection import GroupShuffleSplit
from sklearn.pipeline import Pipeline
from segment_encoder.tools.segment_tools import EigenAligner, CoordinatesRescaler
from segment_encoder.tools.voxel_tools import Voxelizer
from segment_encoder.tools.plot_tools import plot_segment_voxelbox

# import keras
# from keras import layers,models,callbacks
# from layers import Input, Dense, Conv3D, MaxPooling3D, UpSampling3D, Dropout, Flatten, Reshape,normalization
# # from tensorflow import keras.models
# from models import Model
# from callbacks import EarlyStopping
# from keras import backend as K
# from callbacks import EarlyStopping
# from normalization import BatchNormalization

# importing manually ==========================================================================
from tensorflow import keras
# reduce_mean = tf.keras.backend.mean
Activation = tf.keras.layers.Activation
reduce_mean = tf.reduce_mean
layers = tf.keras.layers
Concatenate = tf.keras.layers.Concatenate
models = tf.keras.models
Model = tf.keras.models.Model
callbacks = tf.keras.callbacks
EarlyStopping = tf.keras.callbacks.EarlyStopping
BatchNormalization = tf.keras.layers.BatchNormalization
K = tf.keras.backend
Input, Dense, Conv3D, MaxPooling3D, UpSampling3D, Dropout, Flatten, Reshape = tf.keras.layers.Input, \
																			  tf.keras.layers.Dense, \
																			tf.keras.layers.Conv3D, \
																			tf.keras.layers.MaxPooling3D, \
																			tf.keras.layers.UpSampling3D, \
																			tf.keras.layers.Dropout, \
																			tf.keras.layers.Flatten, \
																			tf.keras.layers.Reshape

# define data paths ==========================================================================


# DATASET_PATH = './datasets_npy/'
# LABELS_PATH = './dataset'+str(DATASET)+'/labels_database.csv'

# labels_database27_3_classes
DATASET = 18
DATASET_PATH = './datasets_npy/'
LABELS_PATH = './dataset'+str(DATASET)+'/labels_database.csv'
N_CLASSES = 3
VOXEL_SHAPE = np.array((32, 32, 16))
BATCH_SIZE = 16
EPOCHS = 1
log_dir = "./logs_keras_tb"

# labels_database27_3_classes

# load data ==========================================================================
segments = np.load(os.path.join(DATASET_PATH, 'segments'+str(DATASET)+'.npy'))
ids = np.load(os.path.join(DATASET_PATH, 'ids'+str(DATASET)+'.npy'))
n_classes=np.unique(ids).size
total = np.loadtxt(LABELS_PATH)
labels = total[:, 1].astype(int)
lids = total[:, 0]
labels_dict = dict(zip(lids, labels))
labels=np.array([labels_dict[i] for i in ids])
# print('labels.size', labels.size)

# choose cars only
cars = ids[np.where(labels==1)]
chosen_segments = segments[np.where(labels==1)]
chosen_ids = ids[np.where(labels==1)]
# print('chosen_segments.size', chosen_segments.size)

# create pipeline ==========================================================================
preprocessing_pipeline = Pipeline([
	('EigenAligner', EigenAligner()),
	('CoordinatesRescaler', CoordinatesRescaler(scale_method="fit",
												center_method="mean",
												voxel_shape=VOXEL_SHAPE)),
	('Voxelizer', Voxelizer(voxel_shape = VOXEL_SHAPE)),
	# ('VoxelNormalizer', VoxelNormalizer(train_ids=train_ids))
])


# split data ============================================================================

train_part=0.7
unique_ids = np.unique(ids)
# np.random.shuffle(unique_ids)
train_n=int(0.7*unique_ids.size)
train_unique_ids=unique_ids[:train_n]
test_unique_ids=unique_ids[train_n:]
train_ids=[i for i, id in enumerate(ids) if id in train_unique_ids]
train_ids = []

shuf = GroupShuffleSplit(n_splits=1, test_size=0.3, train_size=0.7)

for train_index, test_index in shuf.split(segments, labels, ids):
	pass
   # print("TRAIN:", train_index, "TEST:", test_index)
   # print('train_index.size', train_index.size)
   # print('test_index.size', test_index.size)

partition = {}
partition['train'] = train_index
partition['test'] = test_index

labels_dict = dict(zip(range(len(segments)), labels))
# print(labels_dict)

n_classes=np.unique(ids).size
training_generator=EncoderSemanticsGenerator(nums=partition['train'],
						  segments=segments,
						  ids=ids,
						  pipeline=preprocessing_pipeline,
						  batch_size=BATCH_SIZE, # BATCH_SIZE
						  n_classes=N_CLASSES,
                          labels=labels)


test_generator=EncoderSemanticsGenerator(nums=partition['test'],
						  segments=segments,
						  ids=ids,
						  pipeline=preprocessing_pipeline,
						  batch_size=BATCH_SIZE, # BATCH_SIZE
						  n_classes=N_CLASSES,
                          labels=labels)


#==========================================================================================
# NeuralNet ============================================================================

input_voxel = Input(shape=(32, 32, 16, 1))
scales = Input(shape=(1, 3))

# Convolution
x = Conv3D(32, (3, 3, 3), activation='relu', padding='same')(input_voxel)
x = MaxPooling3D((2, 2, 2), padding='same')(x)
x = Conv3D(64, (3, 3 ,3), activation='relu', padding='same')(x)
x = MaxPooling3D((2, 2, 2), padding='same')(x)
x = Conv3D(64, (3, 3, 3), activation='relu', padding='same')(x)

x = Flatten()(x)
x = Reshape((1, 16384))(x)
x = Concatenate()([x, scales])


x = Dense(512)(x)
x = BatchNormalization()(x)
x = Dropout(0.5)(x)

# Descriptor
description = Dense(64)(x)

# Deconvolution
x = Dense(8192)(description)
x = Reshape((8, 8, 4, 32))(x)
x = Conv3D(32, (3, 3, 3), activation='relu', padding='same')(x)
x = UpSampling3D((2, 2, 2))(x)
x = Conv3D(32, (3, 3, 3), activation='relu', padding='same')(x)
x = UpSampling3D((2, 2, 2))(x)
reconstructed = Conv3D(1, (3, 3, 3), activation='sigmoid', padding='same', name='reconstruction_output')(x)

#Classificator
y = BatchNormalization()(description)
y = Dropout(0.5)(y)
y = Dense(N_CLASSES)(y)
classified = Activation('softmax', name='classification_output')(y)

def reconstruction_loss(voxels, reconstructed):
    FN_TO_FP_WEIGHT = 0.9
    loss_r = - tf.reduce_mean(FN_TO_FP_WEIGHT * voxels * keras.backend.log(reconstructed + 1e-10) + (1 - FN_TO_FP_WEIGHT) * \
                            (1 - voxels) * keras.backend.log(1 - reconstructed + 1e-10))
    return loss_r

def classification_loss(classes, classified):
    loss_c = -tf.reduce_mean(keras.losses.binary_crossentropy(classes, classified))
    return loss_c

losses = {
	"reconstruction_output": reconstruction_loss,
	"classification_output": classification_loss
}
loss_weights = {"reconstruction_output": 200, "classification_output": 1}

autoencoder = Model(inputs=[input_voxel, scales], outputs=[reconstructed, classified])
autoencoder.compile(optimizer='adadelta', loss=losses, loss_weights=loss_weights)

e_stopping = EarlyStopping(monitor='val_loss', mode='min', verbose=1, patience = 5)


# NeuralNet ============================================================================
#==========================================================================================

#==========================================================================================
# Gen check ============================================================================

# inputs, y = training_generator.__getitem__(index=0)
# voxelbox_segments_batch, last_scales_batch = inputs

history_train = autoencoder.fit_generator(generator=training_generator, validation_data=test_generator, epochs=100, callbacks=[e_stopping])

# Kostya check
# history = autoencoder.fit(x=[np.zeros((1, 32, 32, 16, 1)), np.zeros((1, 1, 3))],
#                           y=[np.zeros((1, 32, 32, 16, 1)), np.zeros((1, 1, 4))],
#                           epochs=50, batch_size=1)

# history = autoencoder.fit([voxelbox_segments_batch, last_scales_batch], y, epochs=EPOCHS, batch_size=1)

# autoencoder.save("./model_data27_epochs50.h5")
autoencoder.save(log_dir+"/model_data"+str(DATASET)+"_epochs50.h5")

# decoded = autoencoder.predict(x=[voxelbox_segments_batch, last_scales_batch])
	# autoencoder.layers.index(len(autoencoder.layers)-1)
# print(decoded.shape)
# print(voxelbox_segments_batch.shape)
# plot_segment_voxelbox(voxelbox_segments_batch[0])
# plot_segment_voxelbox(decoded[0])

# Gen check ============================================================================
#==========================================================================================

# save losses

pd.DataFrame(history_train.history).to_csv(log_dir+"/history_train.csv")