# import pandas as pd
import numpy as np
from mpl_toolkits.mplot3d import Axes3D
import matplotlib.pyplot as plt
import os
from dataset import Dataset
from generator import Generator
from classifiertools import get_default_preprocessor
from preprocessor import Preprocessor
import keras
from keras.layers import Input, Dense, Conv3D, MaxPooling3D, UpSampling3D, Dropout, Flatten, Reshape
from keras.models import Model
from keras import backend as K
from keras.callbacks import EarlyStopping
from keras.layers.normalization import BatchNormalization


folder='dataset18'
data18=Dataset(folder=folder)
preprocessor=Preprocessor(augment_angle=180,
	augment_remove_random_min=0.0,
	augment_remove_random_max=0.1,
	augment_remove_plane_min=0.0,
	augment_remove_plane_max=0.5,
	augment_jitter=0.0,
	align="eigen",
	voxelize=True,
	scale_method="fit",
	center_method="mean",
	scale=(8, 8, 4),
	voxels=(32, 32, 16),
	remove_mean=False,
	remove_std=False,
	batch_size=32,
	scaler_train_passes=1)
segments, _, ids, n_ids, features, matches, labels_dict=data18.load(preprocessor=preprocessor)

train_fold = np.ones(ids.shape, dtype=np.int)
for c in np.unique(ids):
	dup_classes = data18.duplicate_classes[ids == c]
	unique_dup_classes = np.unique(dup_classes)

	# choose for train the sequence with the largest last segment
	dup_sizes = []
	for dup_class in unique_dup_classes:
		dup_ids = np.where(dup_class == data18.duplicate_classes)[0]
		last_id = np.max(dup_ids)
		dup_sizes.append(segments[last_id].shape[0])

	dup_keep = np.argmax(dup_sizes)

	# randomly distribute the others
	for i, dup_class in enumerate(unique_dup_classes):
		if i != dup_keep:
			if np.random.random() < 0:
				train_fold[duplicate_classes == dup_class] = 0

train_ids = np.where(train_fold == 1)[0]

preprocessor=Preprocessor(augment_angle=180,
		augment_remove_random_min=0.0,
		augment_remove_random_max=0.1,
		augment_remove_plane_min=0.0,
		augment_remove_plane_max=0.5,
		augment_jitter=0.0,
		align="eigen",
		voxelize=True,
		scale_method="fit",
		center_method="mean",
		scale=(8, 8, 4),
		voxels=(32, 32, 16),
		remove_mean=False,
		remove_std=False,
		batch_size=32,
		scaler_train_passes=1)
preprocessor.init_segments(segments, ids,train_ids=ids)
gen_train = Generator(
	preprocessor,
	ids,
	n_ids,
	train=True,
	batch_size=32,
	shuffle=True,
)


batch_segments, batch_classes = gen_train.next()
#segments=batch_segments.squeeze()
training = batch_segments
for i in range(600):
	if(i%10==0):
		print(i)
	batch_segments, batch_classes = gen_train.next()
	training = np.concatenate((training,batch_segments))


class LossHistory(keras.callbacks.Callback):
	def on_train_begin(self, logs={}):
		self.losses = []

	def on_batch_end(self, batch, logs={}):
		self.losses.append(logs.get('loss'))


loss_history = LossHistory()


input_voxel = Input(shape=(32, 32, 16, 1))
#input_voxel = input_voxel.reshape((-1, 32, 32, 16))

x = Conv3D(32, (3, 3, 3), activation='relu', padding='same')(input_voxel)
x = MaxPooling3D((2, 2, 2), padding='same')(x)
x = Conv3D(64, (3, 3 ,3), activation='relu', padding='same')(x)
x = MaxPooling3D((2, 2, 2), padding='same')(x)
#x = Dropout(0.2)(x)
x = Conv3D(64, (3, 3, 3), activation='relu', padding='same')(x)
x = MaxPooling3D((2, 2, 2), padding='same')(x)


x = Flatten()(x)
x = Dense(512)(x)
x = BatchNormalization()(x)
x = Dropout(0.5)(x)
encoded = Dense(64)(x)



x = Dense(8192)(encoded)
x = Reshape((8, 8, 4, 32))(x)
x = Conv3D(32, (3, 3, 3), activation='relu', padding='same')(x)
x = UpSampling3D((2, 2, 2))(x)
x = Conv3D(32, (3, 3, 3), activation='relu', padding='same')(x)
x = UpSampling3D((2, 2, 2))(x)
#x = Conv3D(16, (2, 2, 2), activation='relu')(x)
#x = UpSampling3D((2, 2, 2))(x)
decoded = Conv3D(1, (3, 3, 3), activation='sigmoid', padding='same')(x)


e_stopping = EarlyStopping(monitor='val_loss', mode='min', verbose=1, patience = 5)

autoencoder = Model(input_voxel, decoded)
autoencoder.compile(optimizer='adadelta', loss='binary_crossentropy')

history = autoencoder.fit(training, training, epochs=100, batch_size=32, validation_split=0.2, callbacks=[e_stopping, loss_history])
autoencoder.save("./keras_models/model.h5")
with open('./keras_models/losses.txt', 'w+') as f:
	for item in loss_history.losses:
		f.write("%s\n" % item)