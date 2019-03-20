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

from sklearn.pipeline import Pipeline
from segment_encoder.tools.segment_tools import EigenAligner, CoordinatesRescaler
from segment_encoder.tools.voxel_tools import Voxelizer
from segment_encoder.tools.plot_tools import plot_segment_voxelbox

from plot_roc import get_roc_pairs, get_roc_curve
from dataset import Dataset
from generator import Generator
from preprocessor import Preprocessor
import matplotlib.pyplot as plt

models = tf.keras.models
Model = tf.keras.models.Model

model = models.load_model("./logs_keras_tb/model_data18_epochs50.h5", compile = False)
encoder = Model([model.layers[0].input, model.layers[8].input], model.layers[22].output)
print(encoder.summary())
encoder.set_weights(model.get_weights())

batch_size = 1
VOXEL_SHAPE = np.array((32, 32, 16))
USE_LAST_SAMPLE_ONLY = False
ALWAYS_AGAINST_LAST = False
MIN_DISTANCE_NEGATIVES = 20.0
# load dataset and preprocessor
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
folder = "./dataset18"
data18=Dataset(folder=folder,keep_match_thresh=0.7,require_change=0.1,require_relevance=0.05,)

segments, positions, classes, n_classes, features, _, _ = data18.load(preprocessor=preprocessor)
duplicate_classes = data18.duplicate_classes

preprocessor.init_segments(segments, classes, positions=positions)

# get roc positive and negative pairs
pair_ids, pair_labels = get_roc_pairs(
    segments,
    classes,
    duplicate_classes,
    USE_LAST_SAMPLE_ONLY,
    ALWAYS_AGAINST_LAST,
    MIN_DISTANCE_NEGATIVES,
)
pair_ids_nums=np.sort(np.unique(np.vstack([pair_ids[:,0],pair_ids[:,1]])))
# cnn features
print("Generating cnn features")
gen_test = Generator(
    preprocessor,
    range(len(segments)),
    n_classes,
    train=False,
    batch_size=batch_size,
    shuffle=False,
)

cnn_features = []

####custom generator

preprocessing_pipeline = Pipeline([('EigenAligner', EigenAligner()),('CoordinatesRescaler', CoordinatesRescaler(scale_method="fit",center_method="mean",voxel_shape=VOXEL_SHAPE)),('Voxelizer', Voxelizer(voxel_shape = VOXEL_SHAPE))])
segments_array=np.array(segments,dtype=np.object)
ids_array=np.array(classes)
unique_ids=np.unique(ids_array)
batch_generator=EncoderGenerator(nums=np.arange(segments_array.size),
segments=segments_array,
ids=ids_array,
pipeline=preprocessing_pipeline,
batch_size=batch_size, # BATCH_SIZE
n_classes=unique_ids.size, shuffle=False)
batch_descriptor = encoder.predict_generator(batch_generator)
batch_descriptor=np.array(batch_descriptor).reshape(-1,64)

cnn_features= batch_descriptor

fpr_cnn, tpr_cnn, roc_auc_cnn = get_roc_curve(
    cnn_features,
    pair_ids,
    pair_labels
)

fig_width_pt = 252
inches_per_pt = 1.0 / 72.27  # Convert pt to inch
fig_width = fig_width_pt * inches_per_pt  # width in inches
fig_height = fig_width
fig_size = [fig_width, fig_height]

fig_roc = plt.figure(figsize=(fig_width, fig_height))

fontsize = 9
params = {
    "axes.labelsize": fontsize,
    "font.size": fontsize,
    "legend.fontsize": fontsize,
    "xtick.labelsize": fontsize,
    "ytick.labelsize": fontsize,
    "figure.figsize": fig_size,
}
plt.rcParams.update(params)

lw = 0.7

plt.plot(
    fpr_cnn,
    tpr_cnn,
    color="red",
    lw=lw,
    label="area = %0.2f" % roc_auc_cnn,
)

plt.plot([0, 1], [0, 1], color="navy", lw=lw, linestyle="--")
plt.xlim([0.0, 1.0])
plt.ylim([0.0, 1.0])
plt.xlabel("False Positive Rate [-]")
plt.ylabel("True Positive Rate [-]")
plt.legend(loc="lower right")
fig_roc.savefig("roc.png")