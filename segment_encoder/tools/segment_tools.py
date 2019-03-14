from __future__ import print_function
from sklearn.base import BaseEstimator, TransformerMixin
import numpy as np


def shift_pcl(pcl, dims, cval=50):
    raise NotImplementedError
    return

class PclShifter(BaseEstimator, TransformerMixin):

    # commonly used idea for images, could be used for pcls as well
    # augment data with basic shift of pcl should improve performance
    # todo implement later
    def __init__(self, dx=0, dy=0, new_vals=50):  # no *args or **kargs
        self.dx = dx
        self.dy = dy
        self.new = new_vals
        self.shifted = None

    def shift_pcl_(self, pcl_array, dx, dy, dz, new):
        # pcl_array = array[n_points, n_dims]
        # segments = array[n_segments, n_points, n_dims]

        xs = np.random.uniform(low=1, high=5, size=100)
        ys = np.random.uniform(low=-10, high=-12, size=100)
        zs = np.random.uniform(low=-0.007, high=-0.9, size=100)

        pcl_array = np.concatenate((xs, ys, zs)).T

        raise NotImplementedError
        assert pcl_array.shape[0] == 3 # x y z

        return shift_pcl(pcl_array.reshape(28, 28), [dy, dx, dy], cval=new).reshape(784)

    def shift_pcls_(self, pcl_matrix, dx, dy, dz):
        return np.array([self.shift_pcl_(pcl_array, dx, dy, dz, 50) \
                         for pcl_array in pcl_matrix])

    def fit(self, X, y=None):
        self.shifted = self.shift_pcls_(X, self.dx, self.dy)
        return self  # create

    def transform(self, X):
        '''X: numerical matrix'''
        return np.concatenate((X, self.shifted), axis = 0)

class RandomRemover(BaseEstimator, TransformerMixin):
    # from _augment_remove_random
    def __init__(self):  # no *args or **kargs
        return

    def fit(self, X, y=None):
        return self  # create

    def transform(self, X):
        '''X: numerical'''
        # todo reimplement assuming segments = array[n_segments, n_points, n_dims]

        segments = X
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
        # return np.concatenate((X, self.shifted), axis = 0)

class PlaneRemover(BaseEstimator, TransformerMixin):
    # from _augment_remove_plane

    def __init__(self):  # no *args or **kargs
        return

    def fit(self, X, y=None):
        return self  # create

    def transform(self, X):
        '''X: numerical'''
        # todo reimplement assuming segments = array[n_segments, n_points, n_dims]
        segments = X
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
        # return np.concatenate((X, self.shifted), axis = 0)

class EigenAligner(BaseEstimator, TransformerMixin):
    # from _align_eigen
    def __init__(self, method='eigen'):  # no *args or **kargs
        self.method = method

    def fit(self, X, y=None):
        return self  # create

    def transform(self, X):
        '''X: numerical'''
        # todo reimplement assuming segments = array[n_segments, n_points, n_dims]
        segments = X
        return np.concatenate((X, self.shifted), axis = 0)

class Rotator(BaseEstimator, TransformerMixin):
    # form _augment_rotation
    def __init__(self):  # no *args or **kargs
        return

    def fit(self, X, y=None):
        return self  # create

    def transform(self, X):
        '''X: numerical'''
        # todo reimplement assuming segments = array[n_segments, n_points, n_dims]
        segments = X
        return np.concatenate((X, self.shifted), axis = 0)

class CoordinatesRescaler(BaseEstimator, TransformerMixin):
    # from _rescale_coordinates
    # rescale coordinates and center
    # todo Why not MinMaxScaler of sklearn ?

    def __init__(self, scale_method = "fixed", center_method = "mean"):  # no *args or **kargs
        assert scale_method in ["fixed", "aspect", "fit"]
        assert center_method in ["none", "mean", "min_max"]

        self.scale_method = scale_method
        self.center_method = center_method

    def fit(self, X, y=None):
        return self  # create

    def transform(self, X):
        '''X: numerical'''
        # todo reimplement assuming segments = array[n_segments, n_points, n_dims]
        segments = X
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
        # return np.concatenate((X, rescaled_segments), axis = 0)

class Jitter(BaseEstimator, TransformerMixin):
    # from _augment_jitter
    # randomly displace the segment

    def __init__(self):  # no *args or **kargs
        return

    def fit(self, X, y=None):
        return self  # create

    def transform(self, X):
        '''X: numarical DataFrame'''
        # todo reimplement assuming segments = array[n_segments, n_points, n_dims]
        segments = X
        jitter_segments = []
        for segment in segments:
            jitter = np.random.random(3) * 2 - 1
            jitter = jitter * self.augment_jitter * self.voxels / 2

            segment = segment + jitter
            jitter_segments.append(segment)


        return np.concatenate((X, jitter_segments), axis = 0)


class Voxelizer(BaseEstimator, TransformerMixin):
    # from _voxelize
    # insert into voxel grid
    def __init__(self):  # no *args or **kargs
        return

    def fit(self, X, y=None):
        return self  # create

    def transform(self, X):
        '''X: numerical'''
        # todo reimplement assuming segments = array[n_segments, n_points, n_dims]
        segments = X
        voxelized_segments = np.zeros((len(segments),) + tuple(self.voxels)) # So weird !!!
        for i, segment in enumerate(segments):
            # remove out of bounds points
            segment = segment[np.all(segment < self.voxels, axis=1), :]
            segment = segment[np.all(segment >= 0, axis=1), :]

            # round coordinates
            segment = segment.astype(np.int)

            # fill voxel grid
            voxelized_segments[i, segment[:, 0], segment[:, 1], segment[:, 2]] = 1

        return voxelized_segments
        # return np.concatenate((X, self.shifted), axis = 0)

class VoxelNormalizer(BaseEstimator, TransformerMixin):
    # from _normalize_voxel_matrix
    # remove mean and/or std

    def __init__(self, train_ids=None):  # no *args or **kargs
        self.train_ids = train_ids
        self._scaler = None
        self._scaler_exists = False
        self.scaler_train_passes = None

    def fit(self, X, y=None):
        # self._scaler fit
        return self  # create

    def transform(self, X):
        '''X: numerical'''
        # todo reimplement assuming segments = array[n_segments, n_points, n_dims]
        segments = X
        segments = np.reshape(segments, (segments.shape[0], -1))
        segments = self._scaler.transform(segments)
        segments = np.reshape(segments, (segments.shape[0],) + tuple(self.voxels))

        return segments
        return np.concatenate((X, self.shifted), axis = 0)

class RobotAligner(BaseEstimator, TransformerMixin):
    # from _align_robot
    # align according to the robot's position

    def __init__(self, positions=None):  # no *args or **kargs
        # self._scaler = dx
        self.positions = positions

    def fit(self, X, y=None):
        return self  # create

    def transform(self, X):
        '''X: numerical'''
        # todo reimplement assuming segments = array[n_segments, n_points, n_dims]
        segments = X
        aligned_segments = []
        for i, seg in enumerate(segments):
            center = np.mean(seg, axis=0)

            robot_pos = self.positions[i] - center
            seg = seg - center

            # angle between robot and x-axis
            angle = np.arctan2(robot_pos[1], robot_pos[0])

            # align the segment so the robots perspective is along the x-axis
            inv_rotation_matrix_z = self._get_rotation_matrix_z(angle)
            aligned_seg = np.dot(seg, inv_rotation_matrix_z)

            aligned_segments.append(aligned_seg)

        return aligned_segments
        # return np.concatenate((X, self.shifted), axis = 0)

class TrainScaler(BaseEstimator, TransformerMixin):
    # from _train_scaler
    # align according to the robot's position

    def __init__(self, positions=None):  # no *args or **kargs
        from sklearn.preprocessing import StandardScaler
        # self._scaler = dx
        self.positions = positions

    def fit(self, X, y=None):
        return self  # create

    def transform(self, X):
        '''X: numerical'''
        # todo reimplement assuming segments = array[n_segments, n_points, n_dims]
        segments = X
        aligned_segments = []
        for i, seg in enumerate(segments):
            center = np.mean(seg, axis=0)

            robot_pos = self.positions[i] - center
            seg = seg - center

            # angle between robot and x-axis
            angle = np.arctan2(robot_pos[1], robot_pos[0])

            # align the segment so the robots perspective is along the x-axis
            inv_rotation_matrix_z = self._get_rotation_matrix_z(angle)
            aligned_seg = np.dot(seg, inv_rotation_matrix_z)

            aligned_segments.append(aligned_seg)

        return aligned_segments
        # return np.concatenate((X, self.shifted), axis = 0)


# todo during augmentation we process segments and classes, ids should be processed as well
