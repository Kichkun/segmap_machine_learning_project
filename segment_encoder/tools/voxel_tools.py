from __future__ import print_function
from sklearn.base import BaseEstimator, TransformerMixin
from sklearn.preprocessing import StandardScaler
import numpy as np
import pickle
import os

TEMP_DIR = r'./temp'


class Voxelizer(BaseEstimator, TransformerMixin):
    """
    Transform from point cloud to voxelbox

    Parameters
    ----------
    voxel_shape : ndarray, default (32, 32, 16)
    """
    # from _voxelize

    def __init__(self, voxel_shape = np.array((32, 32, 16))):
        self.voxel_shape = voxel_shape

    def fit(self, X, y=None):
        return self  # create

    def transform(self, X:np.ndarray):

        segments = X
        voxelized_segments = np.zeros((len(segments),) + tuple(self.voxel_shape)) # So weird !!!
        # why not
        # segments_voxel_shape = np.concatenate(len(segments), self.voxel_shape)
        # np.zeros(segments_voxel_shape)

        for i, segment in enumerate(segments):
            # remove out of bounds points
            segment = segment[np.all(segment < self.voxel_shape, axis=1), :]
            segment = segment[np.all(segment >= 0, axis=1), :]
            # round coordinates
            segment = segment.astype(np.int)
            # fill voxel grid
            voxelized_segments[i, segment[:, 0], segment[:, 1], segment[:, 2]] = 1

        return voxelized_segments


class VoxelNormalizer(BaseEstimator, TransformerMixin):
    # from _normalize_voxel_matrix
    # remove mean and/or std

    def __init__(self, train_ids=None, voxel_shape = np.array((32, 32, 16))):

        raise NotImplementedError

        scales_path = os.path.join(TEMP_DIR, 'last_scales.csv')
        try: f = open(scales_path, 'r')
        except FileNotFoundError: print("file='last_scales.csv', not found in" + TEMP_DIR)

        self.train_ids = train_ids
        self._scaler_exists = False
        self.scaler_train_passes = None
        self.voxel_shape = voxel_shape

    def fit(self, X, y=None):
        # self._scaler fit
        return self  # create

    def transform(self, X:np.ndarray):

        segments = X
        segments = np.reshape(segments, (segments.shape[0], -1))
        segments = self._scaler.transform(segments) #R which has been fit on segments
        segments = np.reshape(segments, (segments.shape[0],) + tuple(self.voxel_shape))

        return segments
        return np.concatenate((X, self.shifted), axis = 0)



class TrainScaler(BaseEstimator, TransformerMixin):
    # from _train_scaler
    # align according to the robot's position

    def __init__(self, positions=None):
        raise NotImplementedError
        from sklearn.preprocessing import StandardScaler
        # self._scaler = dx
        self.positions = positions

    def fit(self, X, y=None):
        return self  # create

    def transform(self, X:np.ndarray):

        segments = X
        aligned_segments = []
        for i, seg in enumerate(segments):
            center = np.mean(seg, axis=0)

            robot_pos = self.positions[i] - center
            seg = seg - center

            # angle between robot and x-axis
            angle = np.arctan2(robot_pos[1], robot_pos[0])

            # align the segment so the robots perspective is along the x-axis
            inv_rotation_matrix_z = _get_rotation_matrix_z(angle)
            aligned_seg = np.dot(seg, inv_rotation_matrix_z)

            aligned_segments.append(aligned_seg)

        return aligned_segments


