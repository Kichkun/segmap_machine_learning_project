from keras.models import load_model
from keras.layers.core import Dropout, Activation
from keras.layers import Input, Dense, Conv3D, MaxPooling3D, UpSampling3D, Dropout, Flatten, Reshape
from keras.models import Model
from keras import backend as K
from keras.callbacks import EarlyStopping
from keras.layers.normalization import BatchNormalization


class LossHistory(keras.callbacks.Callback):
	def on_train_begin(self, logs={}):
		self.losses = []

	def on_batch_end(self, batch, logs={}):
		self.losses.append(logs.get('loss'))

loss_history = LossHistory()        

e_stopping = EarlyStopping(monitor='val_loss', mode='min', verbose=1)		


encoder_model = load_model("model.h5")
encoder = Model(encoder_model.layers[0].input, encoder_model .layers[6].output)
encoder.set_weights(encoder_model.get_weights())
for layer in encoder.layers:
	layer.trainable = False
	
#input_vector = Input(shape=(4, 4, 2, 64))

x = encoder.layers[-1].output
x = Dense(64)(x)
x = Dropout(0.5)(x)
x = Dense(3)(x)
o = Activation('softmax', name='loss')(x)



model2 = Model(input_voxel, output=[o])
model2.compile(optimizer='adadelta', loss='crossentropy')
history = model2.fit(x, y, epochs=50, batch_size=32, validation_split=0.2, callbacks=[e_stopping, loss_history])
















