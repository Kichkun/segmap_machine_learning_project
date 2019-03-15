from __future__ import print_function
import numpy as np
import random
import os
from sklearn import metrics
import pickle
from plot_roc import get_roc_pairs, get_roc_curve
from dataset import Dataset
from generator import Generator
from classifiertools import get_default_preprocessor
from preprocessor import Preprocessor
import matplotlib as mpl
import tensorflow as tf
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
mpl.use('Agg')

ae_model = ""
cnn_model_folder = "/home/anastasia/segmap_machine_learning_project-master/tmp/"
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

data18=Dataset(folder='dataset18',keep_match_thresh=0.7,require_change=0.1,require_relevance=0.05,)

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


tf.reset_default_graph()

# restore variable names from previous session
saver = tf.train.import_meta_graph(
    os.path.join(cnn_model_folder, "model-326400.ckpt.meta")
)

# get key tensorflow variables
cnn_graph = tf.get_default_graph()

cnn_input = cnn_graph.get_tensor_by_name("InputScope/input:0")
scales = cnn_graph.get_tensor_by_name("scales:0")
descriptor = cnn_graph.get_tensor_by_name("OutputScope/descriptor_read:0")

cnn_features = []
with tf.Session() as sess:
    saver.restore(sess, tf.train.latest_checkpoint(cnn_model_folder))

    for batch in range(gen_test.n_batches):
        batch_segments, _ = gen_test.next()

        batch_descriptors = sess.run(
            descriptor,
            feed_dict={cnn_input: batch_segments, scales: preprocessor.last_scales},
        )

        for batch_descriptor in batch_descriptors:
            cnn_features.append(batch_descriptor)

cnn_features = np.array(cnn_features)

# ae features
if ae_model:
    print("Generating AE features")
    tf.reset_default_graph()

    # restore variable names from previous session
    saver = tf.train.import_meta_graph(ae_model + ".meta")

    # get key tensorflow variables
    ae_graph = tf.get_default_graph()

    ae_input = ae_graph.get_tensor_by_name("InputScope/input:0")
    ae_descriptor = ae_graph.get_tensor_by_name("OutputScope/descriptor_read:0")
    scales = ae_graph.get_tensor_by_name("scales:0")

    ae_features = []
    with tf.Session() as sess:
        saver.restore(sess, ae_model)

        for batch in range(gen_test.n_batches):
            batch_segments, _ = gen_test.next()

            batch_descriptors = sess.run(
                ae_descriptor,
                feed_dict={
                    ae_input: batch_segments,
                    scales: preprocessor.last_scales,
                },
            )

            for batch_descriptor in batch_descriptors:
                ae_features.append(batch_descriptor)

    ae_features = np.array(ae_features)

# eigen features
eigen_features = features[:, :7]

# plot the ROCs
fpr_eigen, tpr_eigen, roc_auc_eigen = get_roc_curve(
    eigen_features,
    pair_ids,
    pair_labels
)

fpr_cnn, tpr_cnn, roc_auc_cnn = get_roc_curve(
    cnn_features,
    pair_ids,
    pair_labels
)




mpl.use("Agg")


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
    fpr_eigen,
    tpr_eigen,
    color="green",
    lw=lw,
    label="Eigen (area = %0.2f)" % roc_auc_eigen,
)


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