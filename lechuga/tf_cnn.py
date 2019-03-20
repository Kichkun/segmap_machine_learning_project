from __future__ import print_function
import numpy as np
import sys
import os

from dataset import Dataset
from generator import Generator
from preprocessor import Preprocessor
from plot_roc import get_roc_pairs, get_roc_curve

test_size = 0.3
#retrain = './tmp/model-326400.ckpt'
retrain = False
n_epochs = 100
checkpoints = 1
batch_size = 16
keep_best = True
roc = True
log_name = "./losses1/"
cnn_model_folder = "./losses1/"
base_dir = ""
log_path = "./losses1/"
debug_path = "./losses1/"
folder='./'
#debug = False
debug = "./losses1/"
cnn_train_folders = folder
cnn_test_folder = folder
semantics_train_folder = folder
remove_mean = False
remove_std = False

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
        batch_size=16,
        scaler_train_passes=1)

segments = []
classes = np.array([], dtype=np.int)
n_classes = 0
duplicate_classes = np.array([], dtype=np.int)
max_duplicate_class = 0
duplicate_ids = np.array([], dtype=np.int)


#runs = cnn_train_folders.split(",")
#for run in runs:
dataset = Dataset(folder='dataset18')

run_segments, _, run_classes, run_n_classes, _, _, _ = dataset.load(preprocessor=preprocessor)
run_duplicate_classes = dataset.duplicate_classes
run_duplicate_ids = dataset.duplicate_ids

run_classes += n_classes
run_duplicate_classes += max_duplicate_class

segments += run_segments
classes = np.concatenate((classes, run_classes), axis=0)
n_classes += run_n_classes
duplicate_classes = np.concatenate(
    (duplicate_classes, run_duplicate_classes), axis=0
)
duplicate_ids = np.concatenate((duplicate_ids, run_duplicate_ids), axis=0)

max_duplicate_class = np.max(duplicate_classes) + 1

if debug:
    import json

    # empty or create the debug folder
    if os.path.isdir(debug_path):
        import glob

        debug_files = glob.glob(os.path.join(debug_path, "*.json"))
        for debug_file in debug_files:
            os.remove(debug_file)
    else:
        os.makedirs(debug_path)

    # store loss information
    epoch_log = []
    train_loss_log = []
    train_loss_c_log = []
    train_loss_r_log = []
    train_accuracy_log = []
    test_loss_log = []
    test_loss_c_log = []
    test_loss_r_log = []
    test_accuracy_log = []

    # store segment centers for the current run
    centers = []
    for cls in range(n_classes):
        class_ids = np.where(classes == cls)[0]
        last_id = class_ids[np.argmax(duplicate_ids[class_ids])]
        centers.append(np.mean(segments[last_id], axis=0).tolist())

    with open(os.path.join(debug_path, "centers.json"), "w") as fp:
        json.dump(centers, fp)

    # info for sequence prediction visualization
    pred = [0] * (np.max(duplicate_classes) + 1)
    duplicate_ids_norm = np.zeros(duplicate_ids.shape, dtype=np.int)
    for duplicate_class in np.unique(duplicate_classes):
        segment_ids = np.where(duplicate_classes == duplicate_class)[0]
        pred[duplicate_class] = [None] * segment_ids.size

        for i, segment_id in enumerate(segment_ids):
            duplicate_ids_norm[segment_id] = i

    def debug_write_pred(segment_id, segment_probs, train):
        top5_classes = np.argsort(segment_probs)[::-1]
        top5_classes = top5_classes[:5]
        top5_prob = segment_probs[top5_classes]

        segment_class = classes[segment_id]
        segment_prob = segment_probs[segment_class]

        info = [
            int(train),
            int(segment_class),
            float(segment_prob),
            top5_classes.tolist(),
            top5_prob.tolist(),
        ]

        duplicate_class = duplicate_classes[segment_id]
        duplicate_id = duplicate_ids_norm[segment_id]

        pred[duplicate_class][duplicate_id] = info


# load dataset for calculating roc
if roc:
    # get test dataset
    roc_preprocessor = preprocessor

    roc_dataset = Dataset(
        folder=cnn_test_folder,
        base_dir=base_dir,
        keep_match_thresh=0.7,
        require_change=0.1,
        require_relevance=0.05,
    )

    roc_segments, roc_positions, roc_classes, roc_n_classes, roc_features, _, _ = roc_dataset.load(
        preprocessor=roc_preprocessor
    )

    roc_duplicate_classes = roc_dataset.duplicate_classes

    # get roc positive and negative pairs
    pair_ids, pair_labels = get_roc_pairs(
        roc_segments, roc_classes, roc_duplicate_classes
    )

    roc_ids = np.unique(pair_ids)
    roc_segments = [roc_segments[roc_id] for roc_id in roc_ids]
    roc_classes = roc_classes[roc_ids]
    roc_positions = roc_positions[roc_ids]

    for i, roc_id in enumerate(roc_ids):
        pair_ids[pair_ids == roc_id] = i

    roc_preprocessor.init_segments(
        roc_segments, roc_classes, positions=roc_positions
    )

    # roc generator
    gen_roc = Generator(
        roc_preprocessor,
        range(len(roc_segments)),
        roc_n_classes,
        train=False,
        batch_size=batch_size,
        shuffle=False,
    )

# split so that the test set contains entire sequences
train_fold = np.ones(classes.shape, dtype=np.int)
for c in np.unique(classes):
    dup_classes = duplicate_classes[classes == c]
    unique_dup_classes = np.unique(dup_classes)

    # choose for train the sequence with the largest last segment
    dup_sizes = []
    for dup_class in unique_dup_classes:
        dup_ids = np.where(dup_class == duplicate_classes)[0]
        last_id = np.max(dup_ids)
        dup_sizes.append(segments[last_id].shape[0])

    dup_keep = np.argmax(dup_sizes)

    # randomly distribute the others
    for i, dup_class in enumerate(unique_dup_classes):
        if i != dup_keep:
            if np.random.random() < test_size:
                train_fold[duplicate_classes == dup_class] = 0

train_ids = np.where(train_fold == 1)[0]
test_ids = np.where(train_fold == 0)[0]

# initialize preprocessor
preprocessor.init_segments(segments, classes, train_ids=train_ids)

# save scaler mean in a csv
if remove_mean:
    scaler_path = os.path.join(cnn_model_folder, "scaler_mean.csv")
    with open(scaler_path, "w") as fp:
        for i in preprocessor._scaler.mean_:
            fp.write(str(i) + "\n")

# save the scaler as well using pickle
if remove_mean or remove_std:
    scaler_path = os.path.join(cnn_model_folder, "scaler.pkl")
    preprocessor.save_scaler(scaler_path)

# initialize segment batch generators
gen_train = Generator(
    preprocessor,
    train_ids,
    n_classes,
    train=True,
    batch_size=batch_size,
    shuffle=True,
)
gen_test = Generator(
    preprocessor,
    test_ids,
    n_classes,
    train=False,
    batch_size=batch_size,
    shuffle=True,
)


def init_model(input_shape, n_classes):
    with tf.name_scope("InputScope") as scope:
        cnn_input = tf.placeholder(
            dtype=tf.float32, shape=(None,) + input_shape + (1,), name="input"
        )

    # base convolutional layers
    y_true = tf.placeholder(dtype=tf.float32, shape=(None, n_classes), name="y_true")

    scales = tf.placeholder(dtype=tf.float32, shape=(None, 3), name="scales")

    training = tf.placeholder_with_default(
        tf.constant(False, dtype=tf.bool), shape=(), name="training"
    )

    conv1 = tf.layers.conv3d(
        inputs=cnn_input,
        filters=32,
        kernel_size=(3, 3, 3),
        padding="same",
        activation=tf.nn.relu,
        use_bias=True,
        kernel_initializer=tf.contrib.layers.xavier_initializer(),
        name="conv1",
    )

    pool1 = tf.layers.max_pooling3d(
        inputs=conv1, pool_size=(2, 2, 2), strides=(2, 2, 2), name="pool1"
    )

    conv2 = tf.layers.conv3d(
        inputs=pool1,
        filters=64,
        kernel_size=(3, 3, 3),
        padding="same",
        activation=tf.nn.relu,
        use_bias=True,
        kernel_initializer=tf.contrib.layers.xavier_initializer(),
        name="conv3",
    )

    pool2 = tf.layers.max_pooling3d(
        inputs=conv2, pool_size=(2, 2, 2), strides=(2, 2, 2), name="pool2"
    )

    conv3 = tf.layers.conv3d(
        inputs=pool2,
        filters=64,
        kernel_size=(3, 3, 3),
        padding="same",
        activation=tf.nn.relu,
        use_bias=True,
        kernel_initializer=tf.contrib.layers.xavier_initializer(),
        name="conv5",
    )

    flatten = tf.contrib.layers.flatten(inputs=conv3)

    flatten = tf.concat([flatten, scales], axis=1, name="flatten")

    # classification network
    
    dense1 = tf.layers.dense(
        inputs=flatten,
        units=512,
        activation=tf.nn.relu,
        kernel_initializer=tf.contrib.layers.xavier_initializer(),
        use_bias=True,
        name="dense1",
    ) 
    bn_dense1 = tf.layers.batch_normalization(
        dense1, training=training, name="bn_dense1"
    )

    dropout_dense1 = tf.layers.dropout(
        bn_dense1, rate=0.5, training=training, name="dropout_dense1"
    )

    descriptor = tf.layers.dense(
        inputs=dropout_dense1,
         #inputs=flatten,
        units=64,
        kernel_initializer=tf.contrib.layers.xavier_initializer(),
        activation=tf.nn.relu,
        use_bias=True,
        name="descriptor",
    )

    bn_descriptor = tf.layers.batch_normalization(
        descriptor, training=training, name="bn_descriptor"
    )

    with tf.name_scope("OutputScope") as scope:
        tf.add(bn_descriptor, 0, name="descriptor_bn_read")
        tf.add(descriptor, 0, name="descriptor_read")

    dropout_descriptor = tf.layers.dropout(
        bn_descriptor, rate=0.35, training=training, name="dropout_descriptor"
    )


    y_pred = tf.layers.dense(
        inputs=dropout_descriptor,
        units=n_classes,
        kernel_initializer=tf.contrib.layers.xavier_initializer(),
        activation=None,
        use_bias=True,
        name="classes",
    )

    loss_c = tf.reduce_mean(
        tf.nn.softmax_cross_entropy_with_logits_v2(logits=y_pred, labels=y_true),
        name="loss_c",
    )

    # reconstruction network
    dec_dense1 = tf.layers.dense(
        inputs=descriptor,
        units=8192,
        kernel_initializer=tf.contrib.layers.xavier_initializer(),
        activation=tf.nn.relu,
        use_bias=True,
        name="dec_dense1",
    )

    reshape = tf.reshape(dec_dense1, (tf.shape(cnn_input)[0], 8, 8, 4, 32))

    dec_conv1 = tf.layers.conv3d_transpose(
        inputs=reshape,
        filters=32,
        kernel_size=(3, 3, 3),
        strides=(2, 2, 2),
        padding="same",
        use_bias=False,
        kernel_initializer=tf.contrib.layers.xavier_initializer(),
        activation=tf.nn.relu,
        name="dec_conv1",
    )

    dec_conv2 = tf.layers.conv3d_transpose(
        inputs=dec_conv1,
        filters=32,
        kernel_size=(3, 3, 3),
        strides=(2, 2, 2),
        padding="same",
        use_bias=False,
        kernel_initializer=tf.contrib.layers.xavier_initializer(),
        activation=tf.nn.relu,
        name="dec_conv2",
    )

    dec_reshape = tf.layers.conv3d_transpose(
        inputs=dec_conv2,
        filters=1,
        kernel_size=(3, 3, 3),
        padding="same",
        use_bias=False,
        kernel_initializer=tf.contrib.layers.xavier_initializer(),
        activation=tf.nn.sigmoid,
        name="dec_reshape",
    )

    reconstruction = dec_reshape
    with tf.name_scope("ReconstructionScopeAE") as scope:
        tf.add(reconstruction, 0, name="ae_reconstruction_read")

    FN_TO_FP_WEIGHT = 0.9
    loss_r = -tf.reduce_mean(
        FN_TO_FP_WEIGHT * cnn_input * tf.log(reconstruction + 1e-10)
        + (1 - FN_TO_FP_WEIGHT) * (1 - cnn_input) * tf.log(1 - reconstruction + 1e-10)
    )
    tf.identity(loss_r, "loss_r")

    # training
    LOSS_R_WEIGHT = 200
    LOSS_C_WEIGHT = 1
    loss = tf.add(LOSS_C_WEIGHT * loss_c, LOSS_R_WEIGHT * loss_r, name="loss")

    global_step = tf.Variable(0, trainable=False, name="global_step")
    update_step = tf.assign(
        global_step, tf.add(global_step, tf.constant(1)), name="update_step"
    )

    optimizer = tf.train.AdamOptimizer(learning_rate=0.0001)

    # add batch normalization updates to the training operation
    update_ops = tf.get_collection(tf.GraphKeys.UPDATE_OPS)
    with tf.control_dependencies(update_ops):
        train_op = optimizer.minimize(loss, name="train_op")

    # statistics
    y_prob = tf.nn.softmax(y_pred, name="y_prob")

    correct_pred = tf.equal(tf.argmax(y_pred, 1), tf.argmax(y_true, 1))
    accuracy = tf.reduce_mean(tf.cast(correct_pred, tf.float32), name="accuracy")

    roc_auc = tf.placeholder(dtype=tf.float32, shape=(), name="roc_auc")

    with tf.name_scope("summary"):
        tf.summary.scalar("loss", loss, collections=["summary_batch"])
        tf.summary.scalar("loss_c", loss_c, collections=["summary_batch"])
        tf.summary.scalar("loss_r", loss_r, collections=["summary_batch"])
        tf.summary.scalar("accuracy", accuracy, collections=["summary_batch"])

        tf.summary.scalar("roc_auc", roc_auc, collections=["summary_epoch"])

print("Training with %d segments" % gen_train.n_segments)
print("Testing with %d segments" % gen_test.n_segments)

import tensorflow as tf

tf.reset_default_graph()

if retrain:
    # restore variable names from previous session
    saver = tf.train.import_meta_graph(retrain + ".meta")
else:
    # define a new model
    init_model(tuple(preprocessor.voxels), n_classes)

    # model saver
    saver = tf.train.Saver(max_to_keep=checkpoints)

# get key tensorflow variables
cnn_graph = tf.get_default_graph()

cnn_input = cnn_graph.get_tensor_by_name("InputScope/input:0")
y_true = cnn_graph.get_tensor_by_name("y_true:0")
training = cnn_graph.get_tensor_by_name("training:0")
scales = cnn_graph.get_tensor_by_name("scales:0")

loss = cnn_graph.get_tensor_by_name("loss:0")
loss_c = cnn_graph.get_tensor_by_name("loss_c:0")
loss_r = cnn_graph.get_tensor_by_name("loss_r:0")

accuracy = cnn_graph.get_tensor_by_name("accuracy:0")
y_prob = cnn_graph.get_tensor_by_name("y_prob:0")
descriptor = cnn_graph.get_tensor_by_name("OutputScope/descriptor_read:0")
roc_auc = cnn_graph.get_tensor_by_name("roc_auc:0")

global_step = cnn_graph.get_tensor_by_name("global_step:0")
update_step = cnn_graph.get_tensor_by_name("update_step:0")
train_op = cnn_graph.get_operation_by_name("train_op")

summary_batch = tf.summary.merge_all("summary_batch")
summary_epoch = tf.summary.merge_all("summary_epoch")

with tf.Session() as sess:
    # tensorboard statistics
    if log_name:
        train_writer = tf.summary.FileWriter(
            os.path.join(log_path, log_name, "train"), sess.graph
        )
        test_writer = tf.summary.FileWriter(
            os.path.join(log_path, log_name, "test")
        )

    # initialize all tf variables
    tf.global_variables_initializer().run()

    if retrain:
        saver.restore(sess, retrain)

    # remember best epoch accuracy
    if keep_best:
        best_accuracy = 0

    # sequence of train and test batches
    batches = np.array([1] * gen_train.n_batches + [0] * gen_test.n_batches)
    for epoch in range(0, n_epochs):
        train_loss = 0
        train_loss_c = 0
        train_loss_r = 0
        train_accuracy = 0
        train_step = 0

        test_loss = 0
        test_loss_c = 0
        test_loss_r = 0
        test_accuracy = 0
        test_step = 0

        np.random.shuffle(batches)

        console_output_size = 0
        for step, train in enumerate(batches):
            if train:
                batch_segments, batch_classes = gen_train.next()

                # run optimizer and calculate loss and accuracy
                summary, batch_loss, batch_loss_c, batch_loss_r, batch_accuracy, batch_prob, _ = sess.run(
                    [summary_batch, loss, loss_c, loss_r, accuracy, y_prob, train_op],
                    feed_dict={
                        cnn_input: batch_segments,
                        y_true: batch_classes,
                        training: True,
                        scales: preprocessor.last_scales,
                    },
                )

                if debug:
                    for i, segment_id in enumerate(gen_train.batch_ids):
                        debug_write_pred(segment_id, batch_prob[i], train)

                if log_name:
                    train_writer.add_summary(summary, sess.run(global_step))

                train_loss += batch_loss
                train_loss_c += batch_loss_c
                train_loss_r += batch_loss_r
                train_accuracy += batch_accuracy
                train_step += 1
            else:
                batch_segments, batch_classes = gen_test.next()

                # calculate test loss and accuracy
                summary, batch_loss, batch_loss_c, batch_loss_r, batch_accuracy, batch_prob = sess.run(
                    [summary_batch, loss, loss_c, loss_r, accuracy, y_prob],
                    feed_dict={
                        cnn_input: batch_segments,
                        y_true: batch_classes,
                        scales: preprocessor.last_scales,
                    },
                )

                if debug:
                    for i, segment_id in enumerate(gen_test.batch_ids):
                        debug_write_pred(segment_id, batch_prob[i], train)

                if log_name:
                    test_writer.add_summary(summary, sess.run(global_step))

                test_loss += batch_loss
                test_loss_c += batch_loss_c
                test_loss_r += batch_loss_r
                test_accuracy += batch_accuracy
                test_step += 1

            # update training step
            sess.run(update_step)

            # print results
            sys.stdout.write("\b" * console_output_size)

            console_output = "epoch %2d " % epoch

            if train_step:
                console_output += "loss %.4f acc %.2f c %.4f r %.4f " % (
                    train_loss / train_step,
                    train_accuracy / train_step * 100,
                    train_loss_c / train_step,
                    train_loss_r / train_step,
                )

            if test_step:
                console_output += "v_loss %.4f v_acc %.2f v_c %.4f v_r %.4f" % (
                    test_loss / test_step,
                    test_accuracy / test_step * 100,
                    test_loss_c / test_step,
                    test_loss_r / test_step,
                )

            console_output_size = len(console_output)

            sys.stdout.write(console_output)
            sys.stdout.flush()

        # dump prediction values and loss
        if debug:
            epoch_debug_file = os.path.join(debug_path, "%d.json" % epoch)
            with open(epoch_debug_file, "w") as fp:
                json.dump(pred, fp)

            epoch_log.append(epoch)
            train_loss_log.append(train_loss / train_step)
            train_loss_c_log.append(train_loss_c / train_step)
            train_loss_r_log.append(train_loss_r / train_step)
            train_accuracy_log.append(train_accuracy / train_step * 100)
            test_loss_log.append(test_loss / test_step)
            test_loss_c_log.append(test_loss_c / test_step)
            test_loss_r_log.append(test_loss_r / test_step)
            test_accuracy_log.append(test_accuracy / test_step * 100)

            with open(os.path.join(debug_path, "loss.json"), "w") as fp:
                json.dump(
                    {
                        "epoch": epoch_log,
                        "train_loss": train_loss_log,
                        "train_loss_c": train_loss_c_log,
                        "train_loss_r": train_loss_r_log,
                        "train_accuracy": train_accuracy_log,
                        "test_loss": test_loss_log,
                        "test_loss_c": test_loss_c_log,
                        "test_loss_r": test_loss_r_log,
                        "test_accuracy": test_accuracy_log,
                    },
                    fp,
                )

        # calculate roc
        if roc:
            cnn_features = []
            for batch in range(gen_roc.n_batches):
                batch_segments, _ = gen_roc.next()

                batch_descriptors = sess.run(
                    descriptor,
                    feed_dict={
                        cnn_input: batch_segments,
                        scales: roc_preprocessor.last_scales,
                    },
                )

                for batch_descriptor in batch_descriptors:
                    cnn_features.append(batch_descriptor)

            cnn_features = np.array(cnn_features)

            _, _, epoch_roc_auc = get_roc_curve(cnn_features, pair_ids, pair_labels)

            summary = sess.run(summary_epoch, feed_dict={roc_auc: epoch_roc_auc})
            test_writer.add_summary(summary, sess.run(global_step))

            sys.stdout.write(" roc: %.3f" % epoch_roc_auc)

        # flush tensorboard log
        if log_name:
            train_writer.flush()
            test_writer.flush()

        # save epoch model
        if not keep_best or test_accuracy > best_accuracy:
            if checkpoints > 1:
                model_name = "model-%d.ckpt" % sess.run(global_step)
            else:
                model_name = "model.ckpt"

            saver.save(sess, os.path.join(cnn_model_folder, model_name))
            tf.train.write_graph(
                sess.graph.as_graph_def(), cnn_model_folder, "graph.pb"
            )

        print()