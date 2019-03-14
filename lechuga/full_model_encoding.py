from __future__ import print_function
import numpy as np
import random
from sklearn import metrics
import pickle
import os
import numpy as np
import sys
import logging
import tensorflow as tf
logging.getLogger().setLevel(logging.INFO)
import os
os.environ['CUDA_VISIBLE_DEVICES'] = "0"
folder='C:/Users/kichk/Downloads/segmap_machine_learning_project-master/'
cnn_train_folders = folder
cnn_test_folder = folder
semantics_train_folder = folder
normalize_classes = True
# Combine sequences based on merge events triggered in segmatch
use_merges = True

# Size of the merged sequence compared to the last element in the merged
# sequence to keep matches containing the merged sequence
keep_match_thresh = 0.3

# Combine the views based on the segmatch matches
use_matches = True

# Discard classes of segments that are smaller than min_class_size
min_class_size = 2

# The relative size of a segment compared to the last segment in the sequence
# so that it is still considered relevant and kept
require_relevance = 0.05

# The number of points that must be different so that two segments are
# considered different. Similar segments are removed in chronological order
require_diff_points = 0

# Generate new samples by randomly rotating each sample by
# [-augment_angle, augment_angle] degrees.
augment_angle = 180
require_change=0.1
# Augment by randomly removing a percentage of points from each sample
augment_remove_random_min = 0.0
augment_remove_random_max = 0.1
augment_remove_plane_min = 0.0
augment_remove_plane_max = 0.5

# Augment by randomly jittering the segment after centering
augment_jitter = 0.0

# Align the segments (robot/eigen/none)
align = "eigen"

# Which type of scaling to use
#     - fixed: use a fixed scale
#     - aspect: scale, but maintain aspect ratio
#     - fit: scale each dimenstion indipendently
scale_method = "fit"

# How to center the segment
#     - mean: based on the segments mean, some point will be out of bounds
#     - min_max: centers based on the min and max of each dimension
#     - none: no centering
center_method = "mean"

# Size of the voxel parallelepiped in meters
scale_x = 8
scale_y = 8
scale_z = 4

# Number of voxels in the rectangular parallelepiped into
# which to normalize each segment
voxels_x = 32
voxels_y = 32
voxels_z = 16

# Remove the mean and std
remove_mean = False
remove_std = False

# Folder into which to save the model after training
# If no model_base_dir is given, the default model_base_dir will be used instead
#model_base_dir = ...
cnn_model_folder = "/home/anastasia/segmap_machine_learning_project-master/tmp"
semantics_model_folder = "/home/anastasia/segmap_machine_learning_project-master/tmp"

# Percentage of match sequences to put in the test set
test_size = 0.3

# Number of epochs to train for
n_epochs = 6
checkpoints = 3
# Batch size
batch_size = 16

# Root path to save tensorboard logs
log_path = "/tmp/tensorboard/"

# Directory where to save debug outputs
debug = False
debug_path = "/tmp/debug"
retrain = 'C:/Users/kichk/Downloads/segmap_machine_learning_project-master/segmap64/model.ckpt'
keep_best = False
roc = True
log_name = "/tmp/"
class Preprocessor(object):
    def __init__(
        self,
        augment_angle=0.0,
        augment_remove_random_min=0.0,
        augment_remove_random_max=0.0,
        augment_remove_plane_min=0.0,
        augment_remove_plane_max=0.0,
        augment_jitter=0.0,
        align="none",
        voxelize=True,
        scale_method="fixed",
        center_method="none",
        scale=(1, 1, 1),
        voxels=(1, 1, 1),
        remove_mean=False,
        remove_std=False,
        batch_size=16,
        scaler_train_passes=1,
    ):
        self.augment_remove_random_min = augment_remove_random_min
        self.augment_remove_random_max = augment_remove_random_max
        self.augment_remove_plane_min = augment_remove_plane_min
        self.augment_remove_plane_max = augment_remove_plane_max
        self.augment_angle = augment_angle
        self.augment_jitter = augment_jitter

        self.align = align
        self.voxelize = voxelize
        self.scale_method = scale_method
        self.center_method = center_method
        self.scale = np.array(scale)
        self.voxels = np.array(voxels)
        self.remove_mean = remove_mean
        self.remove_std = remove_std
        self.batch_size = batch_size
        self.scaler_train_passes = scaler_train_passes
        self._scaler_exists = False

        min_voxel_side_length_m = 0.1
        self.min_scale = self.voxels * min_voxel_side_length_m

        self.last_scales = []

    def init_segments(
        self, segments, classes, positions=None, train_ids=None, scaler_path=None
    ):

        self.segments = segments
        self.classes = np.array(classes)

        if self.align == "robot":
            assert positions is not None
            self.segments = self._align_robot(self.segments, positions)

        # check if we need to train a scaler
        if self.remove_mean or self.remove_std:
            if scaler_path is None:
                assert train_ids is not None
                self._train_scaler(train_ids)
            else:
                self.load_scaler(scaler_path)

    def get_processed(self, segment_ids, train=True, normalize=True):
        batch_segments = []
        for i in segment_ids:
            batch_segments.append(self.segments[i])

        batch_segments = self.process(batch_segments, train, normalize)
        batch_classes = self.classes[segment_ids]

        return batch_segments, batch_classes

    def process(self, segments, train=True, normalize=True):
        # augment through distorsions
        if train and self.augment_remove_random_max > 0:
            segments = self._augment_remove_random(segments)

        if train and self.augment_remove_plane_max > 0:
            segments = self._augment_remove_plane(segments)

        # align after distorsions
        if self.align == "eigen":
            segments = self._align_eigen(segments)

        # augment rotation
        if train and self.augment_angle > 0:
            segments = self._augment_rotation(segments)

        if self.voxelize:
            # rescale coordinates and center
            segments = self._rescale_coordinates(segments)

            # randomly displace the segment
            if train and self.augment_jitter > 0:
                segments = self._augment_jitter(segments)

            # insert into voxel grid
            segments = self._voxelize(segments)

            # remove mean and/or std
            if normalize and self._scaler_exists:
                segments = self._normalize_voxel_matrix(segments)

        return segments

    def get_n_batches(self, train=True):
        if train:
            return self.n_batches_train
        else:
            return self.n_batches_test

    # create rotation matrix that rotates point around
    # the origin by an angle theta, expressed in radians
    def _get_rotation_matrix_z(self, theta):
        R_z = [
            [np.cos(theta), -np.sin(theta), 0],
            [np.sin(theta), np.cos(theta), 0],
            [0, 0, 1],
        ]

        return np.array(R_z)

    # align according to the robot's position
    def _align_robot(self, segments, positions):
        aligned_segments = []
        for i, seg in enumerate(segments):
            center = np.mean(seg, axis=0)

            robot_pos = positions[i] - center
            seg = seg - center

            # angle between robot and x-axis
            angle = np.arctan2(robot_pos[1], robot_pos[0])

            # align the segment so the robots perspective is along the x-axis
            inv_rotation_matrix_z = self._get_rotation_matrix_z(angle)
            aligned_seg = np.dot(seg, inv_rotation_matrix_z)

            aligned_segments.append(aligned_seg)

        return aligned_segments

    def _align_eigen(self, segments):
        aligned_segments = []
        for segment in segments:
            # Calculate covariance
            center = np.mean(segment, axis=0)

            covariance_2d = np.cov(segment[:, :2] - center[:2], rowvar=False, bias=True)

            eigenvalues, eigenvectors = np.linalg.eig(covariance_2d)
            alignment_rad = np.arctan2(eigenvectors[1, 0], eigenvectors[0, 0])

            if eigenvalues[0] < eigenvalues[1]:
                alignment_rad = alignment_rad + np.pi / 2

            inv_rotation_matrix_z = self._get_rotation_matrix_z(alignment_rad)
            aligned_segment = np.dot(segment, inv_rotation_matrix_z)

            y_center = np.mean(segment[:, 1])
            n_below = np.sum(segment[:, 1] < y_center)

            if n_below < segment.shape[0] / 2:
                alignment_rad = alignment_rad + np.pi
                inv_rotation_matrix_z = self._get_rotation_matrix_z(np.pi)
                aligned_segment = np.dot(aligned_segment, inv_rotation_matrix_z)

            aligned_segments.append(aligned_segment)

        return aligned_segments

    # augment with multiple rotation of the same segment
    def _augment_rotation(self, segments):
        angle_rad = self.augment_angle * np.pi / 180

        augmented_segments = []
        for segment in segments:
            rotation = np.random.uniform(-angle_rad, angle_rad)
            segment = np.dot(segment, self._get_rotation_matrix_z(rotation))
            augmented_segments.append(segment)

        return augmented_segments

    def _augment_remove_random(self, segments):
        augmented_segments = []
        for segment in segments:
            # percentage of points to remove
            remove = (
                np.random.random()
                * (self.augment_remove_random_max - self.augment_remove_random_min)
                + self.augment_remove_random_min
            )

            # randomly choose the points
            idx = np.arange(segment.shape[0])
            np.random.shuffle(idx)
            idx = idx[int(idx.size * remove) :]

            segment = segment[idx]
            augmented_segments.append(segment)

        return augmented_segments

    def _augment_remove_plane(self, segments):
        augmented_segments = []
        for segment in segments:
            # center segment
            center = np.mean(segment, axis=0)
            segment = segment - center

            # slice off a section of the segment
            while True:
                # generate random plane
                plane_norm = np.random.random(3) - 0.5
                plane_norm = plane_norm / np.sqrt(np.sum(plane_norm ** 2))

                # on which side of the plane each point is
                sign = np.dot(segment, plane_norm)

                # find an offset that removes a desired amount of points
                found = False
                plane_offsets = np.linspace(
                    -np.max(self.scale), np.max(self.scale), 100
                )
                np.random.shuffle(plane_offsets)
                for plane_offset in plane_offsets:
                    keep = sign + plane_offset > 0
                    remove_percentage = 1 - (np.sum(keep) / float(keep.size))

                    if (
                        remove_percentage > self.augment_remove_plane_min
                        and remove_percentage < self.augment_remove_plane_max
                    ):
                        segment = segment[keep]
                        found = True
                        break

                if found:
                    break

            segment = segment + center
            augmented_segments.append(segment)

        return augmented_segments

    def _augment_jitter(self, segments):
        jitter_segments = []
        for segment in segments:
            jitter = np.random.random(3) * 2 - 1
            jitter = jitter * self.augment_jitter * self.voxels / 2

            segment = segment + jitter
            jitter_segments.append(segment)

        return jitter_segments

    def _rescale_coordinates(self, segments):
        # center corner to origin
        centered_segments = []
        for segment in segments:
            segment = segment - np.min(segment, axis=0)
            centered_segments.append(segment)
        segments = centered_segments

        # store the last scaling factors that were used
        self.last_scales = []

        # rescale coordinates to fit inside voxel matrix
        rescaled_segments = []
        for segment in segments:
            # choose scale
            if self.scale_method == "fixed":
                scale = self.scale
                segment = segment / scale * (self.voxels - 1)
            elif self.scale_method == "aspect":
                scale = np.tile(np.max(segment), 3)
                segment = segment / scale * (self.voxels - 1)
            elif self.scale_method == "fit":
                scale = np.max(segment, axis=0)
                thresholded_scale = np.maximum(scale, self.min_scale)
                segment = segment / thresholded_scale * (self.voxels - 1)

            # recenter segment
            if self.center_method != "none":
                if self.center_method == "mean":
                    center = np.mean(segment, axis=0)
                elif self.center_method == "min_max":
                    center = np.max(segment, axis=0) / 2.0

                segment = segment + (self.voxels - 1) / 2.0 - center

            self.last_scales.append(scale)
            rescaled_segments.append(segment)

        return rescaled_segments

    def _voxelize(self, segments):
        voxelized_segments = np.zeros((len(segments),) + tuple(self.voxels))
        for i, segment in enumerate(segments):
            # remove out of bounds points
            segment = segment[np.all(segment < self.voxels, axis=1), :]
            segment = segment[np.all(segment >= 0, axis=1), :]

            # round coordinates
            segment = segment.astype(np.int)

            # fill voxel grid
            voxelized_segments[i, segment[:, 0], segment[:, 1], segment[:, 2]] = 1

        return voxelized_segments

    def _train_scaler(self, train_ids):
        from sklearn.preprocessing import StandardScaler

        scaler = StandardScaler(with_mean=self.remove_mean, with_std=self.remove_std)

        for p in range(self.scaler_train_passes):
            for i in np.arange(0, len(train_ids), self.batch_size):
                segment_ids = train_ids[i : i + self.batch_size]
                segments, _ = self.get_processed(segment_ids)
                segments = np.reshape(segments, (segments.shape[0], -1))
                scaler.partial_fit(segments)

        self._scaler = scaler
        self._scaler_exists = True

    # remove mean and std
    def _normalize_voxel_matrix(self, segments):
        segments = np.reshape(segments, (segments.shape[0], -1))
        segments = self._scaler.transform(segments)
        segments = np.reshape(segments, (segments.shape[0],) + tuple(self.voxels))

        return segments

    def save_scaler(self, path):
        import pickle

        with open(path, "w") as fp:
            pickle.dump(self._scaler, fp)

    def load_scaler(self, path):
        import pickle

        with open(path, "r") as fp:
            self._scaler = pickle.load(fp)
            self._scaler_exists = True
class Dataset(object):
    # load config values
    def __init__(
        self,
        folder=folder,
        base_dir="",
        require_change=require_change,
        use_merges=use_merges,
        keep_match_thresh=keep_match_thresh,
        use_matches=use_matches,
        min_class_size=min_class_size,
        require_relevance=require_relevance,
        require_diff_points=require_diff_points,
        normalize_classes=normalize_classes,
    ):
        abs_folder = os.path.abspath(os.path.join(base_dir, folder))
        try:
            assert os.path.isdir(abs_folder)
        except AssertionError:
            raise IOError("Dataset folder {} not found.".format(abs_folder))

        self.folder = abs_folder
        self.require_change = require_change
        self.use_merges = use_merges
        self.keep_match_thresh = keep_match_thresh
        self.use_matches = use_matches
        self.min_class_size = min_class_size
        self.require_relevance = require_relevance
        self.require_diff_points = require_diff_points
        self.normalize_classes = normalize_classes

    # load the segment dataset
    def load(self, preprocessor=None):
#         from ..tools.import_export import load_segments, load_positions, load_features

        # load all the csv files
        self.segments, sids, duplicate_sids = load_segments(folder=self.folder)
        self.positions, pids, duplicate_pids = load_positions(folder=self.folder)
        self.features, self.feature_names, fids, duplicate_fids = load_features(
            folder=self.folder
        )

        self.classes = np.array(sids)
        self.duplicate_classes = self.classes.copy()
        self.positions = np.array(self.positions)
        self.features = np.array(self.features)
        self.duplicate_ids = np.array(duplicate_sids)

        # load labels
#         from ..tools.import_export import load_labels

        self.labels, self.lids = load_labels(folder=self.folder)
        self.labels = np.array(self.labels)
        self.labels_dict = dict(zip(self.lids, self.labels))

        # load matches
#         from ..tools.import_export import load_matches

        self.matches = load_matches(folder=self.folder)

        if self.require_change > 0.0:
            self._remove_unchanged()

        # combine sequences that are part of a merger
        if self.use_merges:
#             from ..tools.import_export import load_merges

            merges, _ = load_merges(folder=self.folder)
            self._combine_sequences(merges)
            self.duplicate_classes = self.classes.copy()

        # remove small irrelevant segments
        if self.require_relevance > 0:
            self._remove_irrelevant()

        # only use segments that are different enough
        if self.require_diff_points > 0:
            assert preprocessor is not None
            self._remove_similar(preprocessor)

        # combine classes based on matches
        if self.use_matches:
            self._combine_classes()

        # normalize ids and remove small classes
        self._normalize_classes()

        print(
            "  Found",
            self.n_classes,
            "valid classes with",
            len(self.segments),
            "segments",
        )

        self._sort_ids()

        return (
            self.segments,
            self.positions,
            self.classes,
            self.n_classes,
            self.features,
            self.matches,
            self.labels_dict,
        )

    def _remove_unchanged(self):
        keep = np.ones(self.classes.size).astype(np.bool)
        for cls in np.unique(self.classes):
            class_ids = np.where(self.classes == cls)[0]

            prev_size = self.segments[class_ids[0]].shape[0]
            for class_id in class_ids[1:]:
                size = self.segments[class_id].shape[0]
                if size < prev_size * (1.0 + self.require_change):
                    keep[class_id] = False
                else:
                    prev_size = size

        self._trim_data(keep)

        print("  Found %d segments that changed enough" % len(self.segments))

    # list of sequence pairs to merge and correct from the matches table
    def _combine_sequences(self, merges):
        # calculate the size of each sequence based on the last element
        last_sizes = {}
        subclasses = {}
        for cls in np.unique(self.classes):
            class_ids = np.where(self.classes == cls)[0]
            last_id = class_ids[np.argmax(self.duplicate_ids[class_ids])]
            last_sizes[cls] = len(self.segments[last_id])
            subclasses[cls] = []

        # make merges and keep a list of the merged sequences for each class
        for merge in merges:
            merge_sequence, target_sequence = merge

            merge_ids = np.where(self.classes == merge_sequence)[0]
            target_ids = np.where(self.classes == target_sequence)[0]

            self.classes[merge_ids] = target_sequence
            self.duplicate_ids[target_ids] += merge_ids.size

            subclasses[target_sequence].append(merge_sequence)
            subclasses[target_sequence] += subclasses[merge_sequence]
            del subclasses[merge_sequence]

        # calculate how relevant the merges are based on size
        relevant = {}
        new_class = {}
        for main_class in subclasses:
            relevant[main_class] = True
            new_class[main_class] = main_class

            main_size = last_sizes[main_class]
            for sub_class in subclasses[main_class]:
                new_class[sub_class] = main_class
                sub_size = last_sizes[sub_class]
                if float(sub_size) / main_size < self.keep_match_thresh:
                    relevant[sub_class] = False
                else:
                    relevant[sub_class] = True

        # ignore non-relevant merges and for the relevant merges replace
        # the merged class with the new class name
        new_matches = []
        for match in self.matches:
            new_match = []
            for cls in match:
                if relevant[cls]:
                    new_match.append(new_class[cls])

            if len(new_match) > 1:
                new_matches.append(new_match)

        print("  Found %d matches that are relevant after merges" % len(new_matches))

        self.matches = new_matches

    # combine the classes in a 1d vector of labeled classes based on a 2d
    # listing of segments that should share the same class
    def _combine_classes(self):
        # filtered out non-unique matches
        unique_matches = set()
        for match in self.matches:
            unique_match = []
            for cls in match:
                if cls not in unique_match:
                    unique_match.append(cls)

            if len(unique_match) > 1:
                unique_match = tuple(sorted(unique_match))
                if unique_match not in unique_matches:
                    unique_matches.add(unique_match)

        unique_matches = [list(match) for match in unique_matches]
        print("  Found %d matches that are unique" % len(unique_matches))

        # combine matches with classes in common
        groups = {}
        class_group = {}

        for i, cls in enumerate(np.unique(unique_matches)):
            groups[i] = [cls]
            class_group[cls] = i

        for match in unique_matches:
            main_group = class_group[match[0]]

            for cls in match:
                other_group = class_group[cls]
                if other_group != main_group:
                    for other_class in groups[other_group]:
                        if other_class not in groups[main_group]:
                            groups[main_group].append(other_class)
                            class_group[other_class] = main_group

                    del groups[other_group]

        self.matches = [groups[i] for i in groups]
        print("  Found %d matches after grouping" % len(self.matches))

        # combine the sequences into the same class
        for match in self.matches:
            assert len(match) > 1
            for other_class in match[1:]:
                self.classes[self.classes == other_class] = match[0]

    # make class ids sequential and remove classes that are too small
    def _normalize_classes(self):
        # mask of segments to keep
        keep = np.ones(self.classes.size).astype(np.bool)

        # number of classes and current class counter
        self.n_classes = 0
        for i in np.unique(self.classes):
            # find the elements in the class
            idx = self.classes == i
            if np.sum(idx) >= self.min_class_size:
                # if class is large enough keep and relabel
                if self.normalize_classes:
                    self.classes[idx] = self.n_classes

                # found one more class
                self.n_classes = self.n_classes + 1
            else:
                # mark class for removal and delete label information
                keep = np.logical_and(keep, np.logical_not(idx))

        # remove data on the removed classes
        self._trim_data(keep)

    # remove segments that are too small compared to the last
    # element in the sequence
    def _remove_irrelevant(self):
        keep = np.ones(self.classes.size).astype(np.bool)
        for cls in np.unique(self.classes):
            class_ids = np.where(self.classes == cls)[0]
            last_id = class_ids[np.argmax(self.duplicate_ids[class_ids])]
            last_size = len(self.segments[last_id])

            for class_id in class_ids:
                segment_size = len(self.segments[class_id])
                if float(segment_size) / last_size < self.require_relevance:
                    keep[class_id] = False

        self._trim_data(keep)

        print("  Found %d segments that are relevant" % len(self.segments))

    # remove segments that are too similar based on hamming distance
    def _remove_similar(self, preprocessor):
        keep = np.ones(self.classes.size).astype(np.bool)
        for c in np.unique(self.classes):
            class_ids = np.where(self.classes == c)[0]

            # sort duplicates in chronological order
            class_ids = class_ids[np.argsort(self.duplicate_ids[class_ids])]

            segments_class = [self.segments[i] for i in class_ids]
            segments_class = preprocessor._rescale_coordinates(segments_class)
            segments_class = preprocessor._voxelize(segments_class)

            for i, segment_1 in enumerate(segments_class):
                for segment_2 in segments_class[i + 1 :]:
                    diff = np.sum(np.abs(segment_1 - segment_2))

                    if diff < self.require_diff_points:
                        keep[class_ids[i]] = False
                        break

        self._trim_data(keep)

        print("  Found %d segments that are dissimilar" % len(self.segments))

    def _sort_ids(self):
        ordered_ids = []
        for cls in np.unique(self.classes):
            class_ids = np.where(self.classes == cls)[0]
            class_sequences = self.duplicate_classes[class_ids]
            unique_sequences = np.unique(class_sequences)

            for unique_sequence in unique_sequences:
                sequence_ids = np.where(class_sequences == unique_sequence)[0]
                sequence_ids = class_ids[sequence_ids]
                sequence_frame_ids = self.duplicate_ids[sequence_ids]

                # order chronologically according to frame id
                sequence_ids = sequence_ids[np.argsort(sequence_frame_ids)]

                ordered_ids += sequence_ids.tolist()

        ordered_ids = np.array(ordered_ids)

        self.segments = [self.segments[i] for i in ordered_ids]
        self.classes = self.classes[ordered_ids]

        if self.positions.size > 0:
            self.positions = self.positions[ordered_ids]
        if self.features.size > 0:
            self.features = self.features[ordered_ids]

        self.duplicate_ids = self.duplicate_ids[ordered_ids]
        self.duplicate_classes = self.duplicate_classes[ordered_ids]

    # keep only segments and corresponding data where the keep parameter is true
    def _trim_data(self, keep):
        self.segments = [segment for (k, segment) in zip(keep, self.segments) if k]
        self.classes = self.classes[keep]

        if self.positions.size > 0:
            self.positions = self.positions[keep]
        if self.features.size > 0:
            self.features = self.features[keep]

        self.duplicate_ids = self.duplicate_ids[keep]
        self.duplicate_classes = self.duplicate_classes[keep]
def to_onehot(y, n_classes):
    y_onehot = np.zeros((len(y), n_classes))
    for i, cls in enumerate(y):
        y_onehot[i, cls] = 1

    return y_onehot
class Generator(object):
    def __init__(
        self,
        preprocessor,
        segment_ids,
        n_classes,
        train=True,
        batch_size=16,
        shuffle=False,
    ):
        self.preprocessor = preprocessor
        self.segment_ids = segment_ids
        self.n_classes = n_classes
        self.train = train
        self.batch_size = batch_size
        self.shuffle = shuffle

        self.n_segments = len(self.segment_ids)
        self.n_batches = int(np.ceil(float(self.n_segments) / batch_size))

        self._i = 0

    def __iter__(self):
        return self

    def next(self):
        if self.shuffle and self._i == 0:
            np.random.shuffle(self.segment_ids)

        self.batch_ids = self.segment_ids[self._i : self._i + self.batch_size]
#         print(self.segment_ids)
        self._i = self._i + self.batch_size
        if self._i >= self.n_segments:
            self._i = 0

        batch_segments, batch_classes = self.preprocessor.get_processed(
            self.batch_ids, train=self.train
        )

        batch_segments = batch_segments[:, :, :, :, None]
        batch_classes = to_onehot(batch_classes, self.n_classes)

        return batch_segments, batch_classes


class GeneratorFeatures(object):
    def __init__(self, features, classes, n_classes=2, batch_size=16, shuffle=True):
        self.features = features
        self.classes = np.asarray(classes)
        self.n_classes = n_classes
        self.batch_size = batch_size
        self.shuffle = shuffle
        self.n_samples = features.shape[0]
        self.n_batches = int(np.ceil(float(self.n_samples) / batch_size))
        self._i = 0

        self.sample_ids = list(range(self.n_samples))
        if shuffle:
            np.random.shuffle(self.sample_ids)

    def next(self):
        batch_ids = self.sample_ids[self._i : self._i + self.batch_size]

        self._i = self._i + self.batch_size
        if self._i >= self.n_samples:
            self._i = 0

        batch_features = self.features[batch_ids, :]
        batch_classes = self.classes[batch_ids]
        batch_classes = to_onehot(batch_classes, self.n_classes)

        return batch_features, batch_classes


def load_segments(folder=folder, filename="segments_database.csv"):
    # container
    segments = []

    # extract and store point data
    from pandas import read_csv

    file_path = os.path.join(folder, filename)
    extracted_data = read_csv(file_path, delimiter=" ").values

    segment_ids = extracted_data[:, 0].astype(int)
    duplicate_ids = extracted_data[:, 1].astype(int)
    points = extracted_data[:, 2:]

    #     complete_ids = list(zip(segment_ids, duplicate_ids))
    id_changes = []
    for i in range(len(segment_ids)):
        if i > 0 and (segment_ids[i] != (segment_ids[i - 1]) or duplicate_ids[i] != duplicate_ids[i - 1]):
            id_changes.append(i)
    #     complete_ids = list(zip(segment_ids, duplicate_ids))
    #     id_changes = []
    #     for i, complete_id in enumerate(complete_ids):
    #         if i > 0 and complete_id != complete_ids[i - 1]:
    #             id_changes.append(i)

    segments = np.split(points, id_changes)

    segment_ids = [ids[0] for ids in np.split(segment_ids, id_changes)]
    duplicate_ids = [ids[0] for ids in np.split(duplicate_ids, id_changes)]

    if len(set(zip(segment_ids, duplicate_ids))) != len(segment_ids):
        raise ValueError(
            "Id collision when importing segments. Two segments with same id exist in file."
        )

    print(
            "  Found "
            + str(len(segments))
            + " segments from "
            + str(np.unique(segment_ids).size)
            + " sequences"
    )
    return segments, segment_ids, duplicate_ids


def load_segments_no_duplicates(folder=folder, filename="segments_database.csv"):
    # container
    segments = []

    # extract and store point data
    from pandas import read_csv

    file_path = os.path.join(folder, filename)
    extracted_data = read_csv(file_path, delimiter=" ").values

    segment_ids = extracted_data[:, 0].astype(int)
    points = extracted_data[:, 1:]

    id_changes = []
    for i, segment_id in enumerate(segment_ids):
        if i > 0 and segment_id != segment_ids[i - 1]:
            id_changes.append(i)

    segments = np.split(points, id_changes)

    segment_ids = [ids[0] for ids in np.split(segment_ids, id_changes)]

    print("  Found " + str(len(segments)) + " segments.")
    return segments, segment_ids


def load_positions(folder=folder, filename="positions_database.csv"):
    segment_ids = []
    duplicate_ids = []
    positions = []

    file_path = os.path.join(folder, filename)
    if os.path.isfile(file_path):
        with open(file_path) as inputfile:
            for line in inputfile:
                split_line = line.strip().split(" ")

                segment_ids.append(int(split_line[0]))
                duplicate_ids.append(int(split_line[1]))

                segment_position = list(map(float, split_line[2:]))
                positions.append(segment_position)

    print("  Found positions for " + str(len(positions)) + " segments")
    return positions, segment_ids, duplicate_ids


def load_labels(folder=folder, filename="labels_database.csv"):
    segment_ids = []
    labels = []

    file_path = os.path.join(folder, filename)
    if os.path.isfile(file_path):
        with open(file_path) as inputfile:
            for line in inputfile:
                split_line = line.strip().split(" ")

                segment_ids.append(int(split_line[0]))
                labels.append(int(split_line[1]))

    print("  Found labels for " + str(len(labels)) + " segment ids")
    return labels, segment_ids


def load_features(folder=folder, filename="features_database.csv"):
    # containers
    segment_ids = []
    duplicate_ids = []
    features = []
    feature_names = []

    file_path = os.path.join(folder, filename)
    if filename:
        with open(file_path) as inputfile:
            for line in inputfile:
                split_line = line.strip().split(" ")

                # feature names
                if len(feature_names) == 0:
                    feature_names = split_line[2::2]

                # id
                segment_id = split_line[0]
                segment_ids.append(int(segment_id))
                duplicate_id = split_line[1]
                duplicate_ids.append(int(duplicate_id))

                # feature values
                features.append(np.array([float(i) for i in split_line[3::2]]))

    print("  Found features for " + str(len(features)) + " segments", end="")
    if "autoencoder_feature1" in feature_names:
        print("(incl. autoencoder features)", end="")
    print(" ")
    return features, feature_names, segment_ids, duplicate_ids


def load_matches(folder=folder, filename="matches_database.csv"):
    # containers
    matches = []

    file_path = os.path.join(folder, filename)

    if os.path.isfile(file_path):
        with open(file_path) as inputfile:
            for line in inputfile:
                split_line = line.strip().split(" ")
                matches.append([int(float(i)) for i in split_line if i != ""])

    print("  Found " + str(len(matches)) + " matches")
    return np.array(matches)


def load_merges(folder=folder, filename="merge_events_database.csv"):
    merge_timestamps = []
    merges = []

    file_path = os.path.join(folder, filename)
    with open(file_path) as inputfile:
        for line in inputfile:
            split_line = line.strip().split(" ")
            merge_timestamps.append(int(split_line[0]))
            merges.append(list(map(int, split_line[1:])))

    print("  Found " + str(len(merges)) + " merge events")
    return merges, merge_timestamps


def load_list_of_lists(path):
    with open(path) as infile:
        list_of_lists = [line.strip().split(" ") for line in infile]
    return convert_strings_to_floats_in_list_of_lists(list_of_lists)


def convert_strings_to_floats_in_list_of_lists(list_of_lists):
    result = []
    for list_ in list_of_lists:
        result_line = []
        for item in list_:
            try:
                num = float(item)
                if num.is_integer():
                    num = int(num)
                result_line.append(num)
            except:
                result_line.append(item)
        result.append(result_line)
    return result
import numpy as np
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

folder18='dataset18'
data18=Dataset(folder=folder18)
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
preprocessor.init_segments(segments, ids,train_ids=ids)
gen_train = Generator(
    preprocessor,
    ids,
    n_ids,
    train=True,
    batch_size=32,
    shuffle=False,
)



def get_roc_pairs(
    segments,
    classes,
    duplicate_classes,
    USE_LAST_SAMPLE_ONLY=False,
    ALWAYS_AGAINST_LAST=False,
    MIN_DISTANCE_NEGATIVES=20.0,
):
    pair_ids = []
    pair_labels = []

    # calculate centroids
    centroids = [np.mean(segment, 0) for segment in segments]

    # positive samples
    for cls in np.unique(classes):
        class_ids = np.where(classes == cls)[0]

        sequences = duplicate_classes[class_ids]
        unique_sequences = np.unique(sequences)

        if unique_sequences.size > 1:
            for i, sequence_1 in enumerate(unique_sequences):
                for sequence_2 in unique_sequences[i + 1 :]:
                    ids_1 = class_ids[np.where(sequences == sequence_1)[0]]
                    ids_2 = class_ids[np.where(sequences == sequence_2)[0]]

                    if USE_LAST_SAMPLE_ONLY:
                        pair_ids.append(ids_1[-1], ids_2[-1])
                        pair_labels.append(1)
                    elif ALWAYS_AGAINST_LAST:
                        for id_1 in ids_1:
                            pair_ids.append([id_1, ids_2[-1]])
                            pair_labels.append(1)

                        for id_2 in ids_2:
                            pair_ids.append([ids_1[-1], id_2])
                            pair_labels.append(1)
                    else:
                        for id_1 in ids_1:
                            for id_2 in ids_2:
                                pair_ids.append([id_1, id_2])
                                pair_labels.append(1)

    n_positives = len(pair_ids)

    # negative samples
    random.seed(54321)
    ids = range(len(segments))

    last_ids = []
    for sequence in np.unique(duplicate_classes):
        last_ids.append(np.where(duplicate_classes == sequence)[0][-1])

    n_negatives = 0
    while n_negatives < n_positives:
        id_1 = random.sample(ids, 1)[0]
        id_2 = random.sample(ids, 1)[0]

        if ALWAYS_AGAINST_LAST:
            id_2 = random.sample(last_ids, 1)[0]

        dist = np.linalg.norm(centroids[id_1] - centroids[id_2])
        if dist >= MIN_DISTANCE_NEGATIVES:
            pair_ids.append([id_1, id_2])
            pair_labels.append(0)
            n_negatives += 1

    pair_ids = np.array(pair_ids)
    pair_labels = np.array(pair_labels)

    print("Positive pairs: %d" % n_positives)
    print("Negative pairs: %d" % n_negatives)

    return pair_ids, pair_labels


def get_roc_curve(features, pair_ids, pair_labels):
    y_pred = []
    for i in range(pair_ids.shape[0]):
        y_pred.append(
            1.0
            / (
                np.linalg.norm(features[pair_ids[i, 0]] - features[pair_ids[i, 1]])
                + 1e-12
            )
        )

    fpr, tpr, thresholds = metrics.roc_curve(pair_labels, y_pred, pos_label=1)
    roc_auc = metrics.auc(fpr, tpr)

    return fpr, tpr, roc_auc
#!/home/mr/segmappyenv/bin/python3


base_dir = 'C:/Users/kichk/Downloads/segmap_machine_learning_project-master/'
folder = ''
segments = []
classes = np.array([], dtype=np.int)
n_classes = 0
duplicate_classes = np.array([], dtype=np.int)
max_duplicate_class = 0
duplicate_ids = np.array([], dtype=np.int)

runs = cnn_train_folders.split(",")
for run in runs:
    dataset = data18

    run_segments, _, run_classes, run_n_classes, _, _, _ = dataset.load(
        preprocessor=preprocessor
    )
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
    roc_preprocessor = preprocessor #TODO: check

    roc_dataset = data18

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
    gen_roc = Generator(
        roc_preprocessor,
        range(len(roc_segments)),
        roc_n_classes,
        train=False,
        batch_size=batch_size,
        shuffle=False,
    )
import tensorflow as tf

# define the cnn model
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
prev_epoch = -1
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

print("Training with %d segments" % gen_train.n_segments)
print("Testing with %d segments" % gen_test.n_segments)


tf.reset_default_graph()
retrain = False
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
tf.device("/device:GPU:0")
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
        saver.restore(sess,retrain)

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
            #if (prev_epoch!=epoch):
           #     prev_epoch = epoch
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
