from __future__ import print_function
from builtins import input
import numpy as np
import os
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import random
from sklearn import metrics
import sys
import tensorflow as tf

from dataset import Dataset
from generator import Generator, GeneratorFeatures
from preprocessor import Preprocessor

SOME_FLAG_FOR_RESULT_EVAL = True
batch_size = 16
log_path = "./tmp1/"
n_epochs = 50
cnn_model_folder = "/home/anastasia/segmap_machine_learning_project-master/tmp/"
semantics_model_folder = "/home/anastasia/segmap_machine_learning_project-master/tmp1/"
use_matches = False
data18=Dataset(folder='dataset18')
segments, _, ids, n_ids, features, matches, labels_dict = data18.load()
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

# Generate descriptors
preprocessor.init_segments(segments, [0] * len(segments))
segments_processed = preprocessor.process(segments, train=False, normalize=False)

gen_test = Generator(
    preprocessor,
    range(len(segments)),
    1,
    train=False,
    batch_size=batch_size,
    shuffle=False,
)


tf.reset_default_graph()

saver = tf.train.import_meta_graph(
    os.path.join(cnn_model_folder, "model-326400.ckpt.meta")
)

graph = tf.get_default_graph()
cnn_input = graph.get_tensor_by_name("InputScope/input:0")
descriptor = graph.get_tensor_by_name("OutputScope/descriptor_read:0")
scales = graph.get_tensor_by_name("scales:0")

features = []
with tf.Session() as sess:
    saver.restore(sess, tf.train.latest_checkpoint(cnn_model_folder))

    for step in range(0, gen_test.n_batches):
        batch_segments, batch_classes = gen_test.next()

        # calculate descriptors
        batch_descriptor = batch_descriptors = sess.run(
            descriptor,
            feed_dict={cnn_input: batch_segments, scales: preprocessor.last_scales},
        )

        features.append(batch_descriptor)

    features = np.concatenate(features, axis=0)

# define the model
FEATURE_DIM = features.shape[1]
N_CLASSES = 3
tf.reset_default_graph()

with tf.name_scope("InputScope") as scope:
    nn_input = tf.placeholder(
        dtype=tf.float32, shape=(None, FEATURE_DIM), name="input"
    )  # , 1,) ??

y_true = tf.placeholder(dtype=tf.float32, shape=(None, N_CLASSES), name="y_true")

training = tf.placeholder_with_default(
    tf.constant(False, dtype=tf.bool), shape=(), name="training"
)

dense1 = tf.layers.dense(
    inputs=nn_input,
    units=64,
    activation=tf.nn.relu,
    use_bias=True,
    kernel_initializer=tf.contrib.layers.xavier_initializer(),
    name="dense1",
)

dropout_dense1 = tf.layers.dropout(
    dense1, rate=0.5, training=training, name="dropout_dense1"
)

y_pred = tf.layers.dense(
    inputs=dropout_dense1,
    units=N_CLASSES,
    activation=None,
    use_bias=True,
    kernel_initializer=tf.contrib.layers.xavier_initializer(),
    name="prediction",
)

with tf.name_scope("OutputScope") as scope:
    tf.add(y_pred, 0, name="output_read")

loss = tf.nn.softmax_cross_entropy_with_logits_v2(logits=y_pred, labels=y_true)
loss = tf.reduce_mean(loss)

optimizer = tf.train.AdamOptimizer(learning_rate=0.0001)

# add batch normalization updates to the training operation
update_ops = tf.get_collection(tf.GraphKeys.UPDATE_OPS)
with tf.control_dependencies(update_ops):
    train_op = optimizer.minimize(loss)

# calculate and save statistics
correct_pred = tf.equal(tf.argmax(y_pred, 1), tf.argmax(y_true, 1))
accuracy = tf.reduce_mean(tf.cast(correct_pred, tf.float32))

tf.summary.scalar("loss", loss)
tf.summary.scalar("accuracy", accuracy)

# model saver
saver = tf.train.Saver()

# split in train and test
RATIO_TRAIN = 0.7
features_test = []
labels_test = []
features_train = []
labels_train = []

unique_ids = np.unique(ids)
np.random.shuffle(unique_ids)

ids_train = unique_ids[0 : int(float(len(unique_ids)) * RATIO_TRAIN)]

for i in range(len(ids)):
    if ids[i] in ids_train:
        features_train.append(features[i, :])
        labels_train.append(labels_dict[ids[i]])
    else:
        features_test.append(features[i, :])
        labels_test.append(labels_dict[ids[i]])

features_train = np.asarray(features_train)
features_test = np.asarray(features_test)

print("Training size: ", len(labels_train), " testing size: ", len(labels_test))

gen_train = GeneratorFeatures(features_train, labels_train, n_classes=N_CLASSES)
gen_test = GeneratorFeatures(features_test, labels_test, n_classes=N_CLASSES)

LOG_NAME = "./semantic_losses/"

with tf.Session() as sess:
    # tensorboard statistics
    if LOG_NAME:
        train_writer = tf.summary.FileWriter(
            os.path.join(log_path, LOG_NAME, "train"), sess.graph
        )
        test_writer = tf.summary.FileWriter(
            os.path.join(log_path, LOG_NAME, "test")
        )
        summary_step = 0

    summary = tf.summary.merge_all()

    # initialize all tf variables
    tf.global_variables_initializer().run()

    for epoch in range(0, n_epochs):
        # train
        epoch_loss = 0
        epoch_accuracy = 0

        console_output_size = 0
        for step in range(0, gen_train.n_batches):
            batch_features, batch_classes = gen_train.next()

            # run optimizer and calculate loss and accuracy
            batch_summary, batch_loss, batch_accuracy, _ = sess.run(
                [summary, loss, accuracy, train_op],
                feed_dict={
                    nn_input: batch_features,
                    y_true: batch_classes,
                    training: True,
                },
            )

            if LOG_NAME:
                train_writer.add_summary(batch_summary, summary_step)
                summary_step = summary_step + 1

            epoch_loss = epoch_loss + batch_loss
            epoch_accuracy = epoch_accuracy + batch_accuracy

            # print results
            sys.stdout.write("\b" * console_output_size)

            console_output = "epoch %2d loss: %.4f acc: %.2f" % (
                epoch,
                epoch_loss / (step + 1),
                epoch_accuracy / (step + 1) * 100,
            )
            console_output_size = len(console_output)

            sys.stdout.write(console_output)
            sys.stdout.flush()

        sys.stdout.write(" ")

        # test
        epoch_loss = 0
        epoch_accuracy = 0

        console_output_size = 0
        for step in range(0, gen_test.n_batches):
            batch_features, batch_classes = gen_test.next()

            # calculate test loss and accuracy
            batch_summary, batch_loss, batch_accuracy = sess.run(
                [summary, loss, accuracy],
                feed_dict={nn_input: batch_features, y_true: batch_classes},
            )

            if LOG_NAME:
                test_writer.add_summary(batch_summary, summary_step)
                summary_step = summary_step + 1

            epoch_loss = epoch_loss + batch_loss
            epoch_accuracy = epoch_accuracy + batch_accuracy

            # print results
            sys.stdout.write("\b" * console_output_size)

            console_output = "val_loss: %.4f val_acc: %.2f" % (
                epoch_loss / (step + 1),
                epoch_accuracy / (step + 1) * 100,
            )
            console_output_size = len(console_output)

            sys.stdout.write(console_output)
            sys.stdout.flush()

        print()

        saver.save(sess, os.path.join(semantics_model_folder, "model.ckpt"))
        tf.train.write_graph(sess.graph.as_graph_def(), semantics_model_folder, "graph.pb")

    if SOME_FLAG_FOR_RESULT_EVAL:
        print("Some sample results")

        try:
            range_ids = list(range(len(ids)))
            np.random.shuffle(range_ids)
            for i in range_ids:
                if ids[i] not in ids_train:
                    segment = segments[i]
                    label = labels_dict[ids[i]]
                    feature = np.zeros((1, features[i].shape[0]))
                    feature[0, :] = features[i]

                    prediction = sess.run([y_pred], feed_dict={nn_input: feature})

                    print("Label: ", label, " prediction ", prediction)

                    fig = plt.figure(1)
                    ax = fig.add_subplot(1, 1, 1, projection="3d")
                    ax.scatter(
                        segment[:, 0], segment[:, 1], segment[:, 2], color="blue", marker="."
                    )

                    plt.draw()
                    plt.pause(0.001)
                    fig.savefig("./tmp1/" + "out" + str(i) + ".png")
                    input("Segment: ")
                    plt.clf()

        except KeyboardInterrupt:
            print("Exiting.")