from __future__ import print_function
from sklearn.base import BaseEstimator, TransformerMixin
from sklearn.preprocessing import StandardScaler
import numpy as np
import pickle
import os

TEMP_DIR = r'../temp'

def shift_pcl(pcl, dims, cval=50):
    raise NotImplementedError
    return

class PclShifter(BaseEstimator, TransformerMixin):

    # commonly used idea for images, could be used for pcls as well
    # augment data with basic shift of pcl should improve performance
    # todo implement later
    def __init__(self, dx=0, dy=0, new_vals=50):
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
    """
    Remove random percentage of points

    Parameters
    ----------
    low : float, default 0
        lower bound percent of points to remove.

    high : float,  default 0.1
        upper bound percent of points to remove.
    """
    # from _augment_remove_random

    def __init__(self, low=0, high=0.1):
        self.low = low
        self.high = high
        return

    def fit(self, X, y=None):
        return self  # create

    def transform(self, X:list):
        segments = X
        augmented_segments = []
        for segment in segments:

            # percentage of points to remove between low and high
            remove = (np.random.random()*(self.high - self.low) + self.low)

            # randomly choose the points to keep
            n_points = segment.shape[0]

            idx = np.arange(n_points)
            np.random.shuffle(idx)
            idx = idx[int(idx.size * remove) :]

            keep_ids = np.random.choice(idx, size=int(n_points * (1-remove))) #R
            augmented_segments.append(segment[keep_ids])

        return augmented_segments

class PlaneRemover(BaseEstimator, TransformerMixin):
    """Remove random percentage of points

    Parameters
    ----------
    low : float, default 0
        lower bound augment_remove_plane_min.

    high : float,  default 0.5
        upper bound augment_remove_plane_max.

    scale : ndarray,  default (8,8,4)
        upper bound augment_remove_plane_max.

    """
    # from _augment_remove_plane

    def __init__(self, low=0.0, high=0.5, scale=np.array((8,8,4))):
        self.low = low
        self.high = high
        self.scale = scale
        return

    def fit(self, X, y=None):
        return self  # create

    def transform(self, X:list):
        segments = X
        augmented_segments = []
        for segment in segments:

            # center segment
            center = np.mean(segment, axis=0)
            segment = segment - center

            # slice off a section of the segment
            while True: # todo avoid while with flag found (exhaustive search)

                # generate random plane
                plane_norm = np.random.random(3) - 0.5
                plane_norm = plane_norm / np.sqrt(np.sum(plane_norm ** 2))

                # on which side of the plane each point is
                sign = np.dot(segment, plane_norm)

                # find an offset that removes a desired amount of points
                found = False
                plane_offsets = np.linspace(-np.max(self.scale), np.max(self.scale), 100)
                np.random.shuffle(plane_offsets)
                for plane_offset in plane_offsets:
                    keep = sign + plane_offset > 0
                    remove_percentage = 1 - (np.sum(keep) / float(keep.size))

                    if remove_percentage > self.low and remove_percentage < self.high: #R 0<x<1
                        segment = segment[keep]
                        found = True
                        break

                if found:
                    break

            segment = segment + center
            augmented_segments.append(segment)

        return augmented_segments
        # return np.concatenate((X, self.shifted), axis = 0)

class Aligner(BaseEstimator, TransformerMixin):
    # from _align_eigen
    """Align points

    Parameters
    ----------
    method : str, default eigen
        lower bound percent of points to remove.

    positions : ndarray,  default (8,8,4)
        upper bound percent of points to remove.
    """

    def __init__(self, method='eigen', positions=None):
        self.method = method
        self.positions = positions
    def fit(self, X, y=None):
        return self  # create

    def transform(self, X:list):
        '''X: list'''
        segments = X
        aligned_segments = []
        if self.method == 'eigen':
            for segment in segments:

                n_points = segment.shape[0]

                center = np.mean(segment, axis=0) # [ 4.18954968 -5.20061169  0.21617181]

                # Calculate covariance (x,y) and rotation angle
                covariance_2d = np.cov(segment[:, :2] - center[:2], rowvar=False, bias=True)
                # [[ 4.79467599 -0.93348773]
                #  [-0.93348773  0.36801586]]
                eigenvalues, eigenvectors = np.linalg.eig(covariance_2d)
                # [4.98347609 0.17921576]
                # [[ 0.98015383  0.19823843]
                #  [-0.19823843  0.98015383]]
                alignment_rad = np.arctan2(eigenvectors[1, 0], eigenvectors[0, 0])

                if eigenvalues[0] < eigenvalues[1]:
                    alignment_rad = alignment_rad + np.pi / 2

                inv_rotation_matrix_z = _get_rotation_matrix_z(alignment_rad)
                aligned_segment = np.dot(segment, inv_rotation_matrix_z)

                y_center = np.mean(segment[:, 1])
                n_below = np.sum(segment[:, 1] < y_center)

                if n_below <  n_points / 2:
                    # rotate by angle + pi
                    alignment_rad = alignment_rad + np.pi
                    inv_rotation_matrix_z = _get_rotation_matrix_z(np.pi)
                    aligned_segment = np.dot(aligned_segment, inv_rotation_matrix_z)

                aligned_segments.append(aligned_segment)

            return aligned_segments

        elif self.method == 'robot':

            if self.positions is None:
                print('no positions given to Aligner,/nskipping Aligner(robot)')
                return X

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

class EigenAligner(BaseEstimator, TransformerMixin):

    """Align points by eigen vectors"""
    # from _align_eigen

    def __init__(self,):
        return

    def fit(self, X, y=None):
        return self  # create

    def transform(self, X:list):
        '''X: list'''
        segments = X
        aligned_segments = []
        for segment in segments:
            # Calculate covariance
            center = np.mean(segment, axis=0)

            covariance_2d = np.cov(segment[:, :2] - center[:2], rowvar=False, bias=True)
            #R too many indices for array
            eigenvalues, eigenvectors = np.linalg.eig(covariance_2d)
            alignment_rad = np.arctan2(eigenvectors[1, 0], eigenvectors[0, 0])

            if eigenvalues[0] < eigenvalues[1]:
                alignment_rad = alignment_rad + np.pi / 2

            inv_rotation_matrix_z = _get_rotation_matrix_z(alignment_rad)
            aligned_segment = np.dot(segment, inv_rotation_matrix_z)

            y_center = np.mean(segment[:, 1])
            n_below = np.sum(segment[:, 1] < y_center)

            if n_below < segment.shape[0] / 2:
                alignment_rad = alignment_rad + np.pi
                inv_rotation_matrix_z = _get_rotation_matrix_z(np.pi)
                aligned_segment = np.dot(aligned_segment, inv_rotation_matrix_z)

            aligned_segments.append(aligned_segment)

        return aligned_segments


class RandomRotator(BaseEstimator, TransformerMixin):
    """Rotate points by random angle in range

    Parameters
    ----------
    angle_range_deg : float, default [-180.0, 180.0]
        random angle is chosen in this range.
    """
    # form _augment_rotation

    def __init__(self, angle_range_deg=np.array((-180.0, 180.0))):
        # self.angle_rad = augment_angle * np.pi / 180
        self.angle_range_rad = angle_range_deg * np.pi / 180
        pass

    def fit(self, X, y=None):
        return self  # create

    def transform(self, X:list):
        '''X: list'''
        segments = X
        augmented_segments = []
        for segment in segments:
            # rotation = np.random.uniform(-angle_rad, angle_rad)
            rotation = np.random.uniform(self.angle_range_rad[0], self.angle_range_rad[1]) # 2.86
            segment = np.dot(segment, _get_rotation_matrix_z(rotation))
            augmented_segments.append(segment)

        return augmented_segments


# if voxelize

class CoordinatesRescaler(BaseEstimator, TransformerMixin):

    """Rescale coordinates of points

    Parameters
    ----------
    scale_method : str, default "fit"
        method of scaling.

    center_method : str,  default "mean"
        center_method.

    scale : ndarray,  default (8,8,4)
        used only if scale_method is "fixed".

    voxel_shape : ndarray, default (32, 32, 16)

    min_scale_threshold : ndarray,  default (3.2, 3.2, 1.6)
        min_scale bound.
    """
    # from _rescale_coordinates
    # rescale coordinates and center
    # scale same as in PlaneRemover
    # todo Why not MinMaxScaler of sklearn ?

    def __init__(self, scale_method = "fixed",
                 center_method = "mean",
                 scale = np.array((8,8,4)),
                 voxel_shape = np.array((32, 32, 16)),
                 min_scale_threshold = np.array((3.2, 3.2, 1.6))):

        assert scale_method in ["fixed", "aspect", "fit"]
        assert center_method in ["none", "mean", "min_max"]
        self.scale = scale
        self.voxel_shape = voxel_shape
        self.min_scale_threshold = min_scale_threshold # [3.2 3.2 1.6]

        self.scale_method = scale_method
        self.center_method = center_method

    def fit(self, X, y=None):
        return self  # create

    def transform(self, X:np.ndarray):
        '''X: numerical'''
        segments = X
        # center corner to origin
        centered_segments = []
        for segment in segments:
            segment = segment - np.min(segment, axis=0)
            centered_segments.append(segment)
        segments = centered_segments

        ## for now without saving last scales
        # try: os.remove(os.path.join(TEMP_DIR, 'last_scales.csv'))
        # except FileNotFoundError: pass

        # store the last scaling factors that were used
        last_scales = []

        # rescale coordinates to fit inside voxel matrix
        rescaled_segments = []
        for segment in segments:
            # choose scale
            if self.scale_method == "fixed":
                scale = self.scale
                segment = segment / scale * (self.voxel_shape - 1)
            elif self.scale_method == "aspect":
                scale = np.tile(np.max(segment), 3)
                segment = segment / scale * (self.voxel_shape - 1)
            elif self.scale_method == "fit":
                scale = np.max(segment, axis=0)  # [8.79245905 3.30835126 2.313096]
                thresholded_scale = np.maximum(scale, self.min_scale_threshold)
                # downsize
                segment = segment / thresholded_scale
                # mul to voxel_shape
                segment = segment * (self.voxel_shape - 1) #R [31, 31, 15]

            # recenter segment
            if self.center_method == "mean":
                center = np.mean(segment, axis=0) # [12.99260985 18.49886429  6.82488768]
            elif self.center_method == "min_max":
                center = np.max(segment, axis=0) / 2.0

            segment = segment + (self.voxel_shape - 1) / 2.0 - center

            last_scales.append(scale)

            ##for now without saving last scales
            # with open(os.path.join(TEMP_DIR, 'last_scales.csv'), "wb") as f:  # Pickling
            #     pickle.dump(last_scales, f)

            rescaled_segments.append(segment)

        return rescaled_segments


class Jitter(BaseEstimator, TransformerMixin):
    # from _augment_jitter
    # concatenates jitter
    # randomly displace the segment
    # voxel_shape same as in CoordinatesRescaler

    def __init__(self, jitter, voxel_shape = np.array((32, 32, 16))):
        self.jitter = jitter
        self.voxel_shape = voxel_shape
        return

    def fit(self, X, y=None):
        return self  # create

    def transform(self, X: np.ndarray):
        segments = X

        jitter_segments = []
        for segment in segments:
            jitter = np.random.random(3) * 2 - 1
            jitter = jitter * self.jitter * self.voxel_shape / 2

            segment = segment + jitter
            jitter_segments.append(segment)

        return jitter_segments

def _get_rotation_matrix_z(theta):
    return np.array([[np.cos(theta), -np.sin(theta), 0],
                     [np.sin(theta), np.cos(theta), 0],
                     [0, 0, 1],])

segment_pcl_list_scaler = StandardScaler()

# todo during augmentation we process segments and classes, ids should be processed as well
if __name__ == '__main__':
    print('segment_tools done!')