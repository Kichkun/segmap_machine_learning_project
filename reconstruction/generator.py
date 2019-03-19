import numpy as np
import tensorflow as tf

from sklearn.pipeline import Pipeline
from sklearn.base import BaseEstimator, TransformerMixin


class Voxelizer(BaseEstimator, TransformerMixin):
    """
    Transform from point cloud to voxelbox
    Parameters
    ----------
    voxel_shape : ndarray, default (32, 32, 16)
    """

    # from _voxelize

    def __init__(self, voxel_shape=np.array((32, 32, 16))):
        self.voxel_shape = voxel_shape

    def fit(self, X, y=None):
        return self  # create

    def transform(self, X: np.ndarray):
        segments = X
        voxelized_segments = np.zeros((len(segments),) + tuple(self.voxel_shape))  # So weird !!!
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

    def __init__(self, scale_method="fit",
                 center_method="mean",
                 scale=np.array((8, 8, 4)),
                 voxel_shape=np.array((32, 32, 16)),
                 min_scale_threshold=np.array((3.2, 3.2, 1.6))):

        assert scale_method in ["fixed", "aspect", "fit"]
        assert center_method in ["none", "mean", "min_max"]
        self.scale = scale
        self.voxel_shape = voxel_shape
        self.min_scale_threshold = min_scale_threshold  # [3.2 3.2 1.6]

        self.scale_method = scale_method
        self.center_method = center_method

    def fit(self, X, y=None):
        return self  # create

    def transform(self, X: np.ndarray):
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
                segment = segment * (self.voxel_shape - 1)  # R [31, 31, 15]

            # recenter segment
            if self.center_method == "mean":
                center = np.mean(segment, axis=0)  # [12.99260985 18.49886429  6.82488768]
            elif self.center_method == "min_max":
                center = np.max(segment, axis=0) / 2.0

            segment = segment + (self.voxel_shape - 1) / 2.0 - center

            last_scales.append(scale)

            ##for now without saving last scales
            # with open(os.path.join(TEMP_DIR, 'last_scales.csv'), "wb") as f:  # Pickling
            #     pickle.dump(last_scales, f)

            rescaled_segments.append(segment)

        return rescaled_segments


def train_pipeline(pointcloud_segments):
    preprocessing_pipeline = Pipeline([
        ('CoordinatesRescaler', CoordinatesRescaler(scale_method="fit", center_method="mean")),
        # ('Jitter', Jitter()),
        ('Voxelizer', Voxelizer()),
        # ('VoxelNormalizer', VoxelNormalizer(train_ids=train_ids))
    ])

    voxelbox = preprocessing_pipeline.fit_transform(pointcloud_segments)

    return voxelbox


class DataGenerator(tf.keras.utils.Sequence):
    '''Generates data for Keras Simple'''

    def __init__(self, nums, segments, ids, batch_size=32, dim=(32, 32, 16),
                 n_classes=3, shuffle=True, scale_method='fit'):
        'Initialization'
        self.dim = dim
        self.batch_size = batch_size
        self.nums = nums  # segment nums
        self.n_classes = n_classes
        self.shuffle = shuffle
        self.segments = segments
        self.ids = ids
        self.last_scales = None
        self.scale_method = scale_method
        self.on_epoch_end()

    def __len__(self):
        'Denotes the number of batches per epoch'
        return int(np.floor(len(self.list_IDs) / self.batch_size))

    def __getitem__(self, index):
        'Generate one batch of data'
        # Generate indexes of the batch
        indexes = self.indexes[index * self.batch_size:(index + 1) * self.batch_size]

        # Find list of IDs
        nums_temp = self.nums[indexes]  # to change

        # Generate data
        X, y = self.__data_generation(nums_temp)

        return X, y, self.last_scales

    def on_epoch_end(self):
        'Updates indexes after each epoch'
        self.indexes = np.arange(self.nums.size)
        if self.shuffle == True:
            np.random.shuffle(self.indexes)

    def __data_generation(self, nums_temp):
        'Generates data containing batch_size samples'  # X : (n_samples, *dim)
        # Initialization
        # assert type(self.segments) == list
        X = self.segments[nums_temp]
        self._get_last_scales(X)
        y = self.ids[nums_temp]

        # Generate data
        X = train_pipeline(X)

        return X, tf.keras.utils.to_categorical(y, num_classes=self.n_classes)

    def _get_last_scales(self, segments):

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
                scale = np.max(segment, axis=0)  # max x,y,z

            self.last_scales.append(scale)

        return