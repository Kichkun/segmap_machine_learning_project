from __future__ import print_function
from keras.models import Model
from keras.models import load_model
import numpy as np
from plot_roc import get_roc_pairs, get_roc_curve
from dataset import Dataset
from generator import Generator
from preprocessor import Preprocessor
import matplotlib as mpl
import matplotlib.pyplot as plt
mpl.use('Agg')

encoder_model = load_model("./lechuga/trained_models/keras_models_encoder/model_aut1_100.h5")
encoder = Model(encoder_model .layers[0].input, encoder_model .layers[11].output)
encoder.set_weights(encoder_model.get_weights())
print(encoder.summary())

batch_size = 16
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
folder = "C:/Users/kichk/Downloads/segmap_machine_learning_project-master/dataset18"
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

for batch in range(gen_test.n_batches):
    batch_segments, _ = gen_test.next()
    batch_descriptors = encoder.predict(batch_segments)

    for batch_descriptor in batch_descriptors:
        cnn_features.append(batch_descriptor)

cnn_features = np.array(cnn_features)

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