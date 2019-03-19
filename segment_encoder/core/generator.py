import numpy as np
import tensorflow as tf
from ..pipelines.main_pipelines import train_pipeline, load_segments
from ..tools.plot_tools import plot_segment_voxelboxes
from sklearn.pipeline import Pipeline
from segment_encoder.tools.segment_tools import RandomRemover,\
                                                PlaneRemover,\
                                                EigenAligner,\
                                                RandomRotator,\
                                                CoordinatesRescaler
from segment_encoder.tools.voxel_tools import Voxelizer
import os

# todo please define paths below

class BaseGenerator(tf.keras.utils.Sequence):

    '''Generates data for Keras Simple not defined yet

    Parameters
    ----------
    nums : ndarray,
        not defined yet.
    segments : ndarray, default 2
        not defined yet.
    ids : ndarray, default 2
        not defined yet.
    pipeline : Pipeline, default 2
        not defined yet.
    batch_size : int, default 32
        not defined yet.
    n_classes : int, default 3
        not defined yet.
    shuffle : boolean, default True
        not defined yet.
    scale_method : str, default 'fit'
        not defined yet.
    '''

    def __init__(self, nums, segments, ids, pipeline, batch_size=32,
                 n_classes=3, shuffle=True, scale_method='fit'):

        '''Initialization'''

        self.batch_size = batch_size
        self.nums = nums # segment nums
        self.n_classes = n_classes
        self.shuffle = shuffle
        self.segments = segments
        self.ids=ids
        self.last_scales = None
        self.scale_method = scale_method
        self.pipeline = pipeline
        self.on_epoch_end()

    def __len__(self):

        '''Denotes the number of batches per epoch'''

        return int(self.ids.size // self.batch_size)

    def __getitem__(self, index):

        '''Generate one batch of data'''

        # Generate indexes of the batch
        indexes = self.indexes[index*self.batch_size : (index+1)*self.batch_size]

        # Find list of IDs
        nums_temp=self.nums[indexes] # to change

        # Generate data
        X, y = self.__data_generation(nums_temp)

        # return X.reshape(X.shape[0],X.shape[1],X.shape[2],X.shape[3],1), y, self.last_scales
        return X, y, self.last_scales

    def on_epoch_end(self):

        '''Updates indexes after each epoch'''

        self.indexes = np.arange(self.nums.size)
        if self.shuffle == True:
            np.random.shuffle(self.indexes)

    def __data_generation(self, nums_temp):

        '''Generates data containing batch_size samples'''

        # Initialization
        assert type(self.segments) == np.ndarray
        X = self.segments[nums_temp]
        self._get_last_scales(X)
        y = self.ids[nums_temp]

        # Generate data
        X = self.pipeline.fit_transform(X)

        # output batch with onehot labels
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


class EncoderGenerator(BaseGenerator):

    '''No y'''

    def __getitem__(self, index):

        '''Generate one batch of data'''

        # Generate indexes of the batch
        indexes = self.indexes[index*self.batch_size : (index+1)*self.batch_size]

        # Find list of IDs
        nums_temp=self.nums[indexes] # to change

        # Generate data
        X = self.__data_generation(nums_temp)
        self.last_scales = np.array(self.last_scales)
        self.last_scales = self.last_scales.reshape(self.last_scales.shape[0], 1, 3)
        # return X.reshape(X.shape[0],X.shape[1],X.shape[2],X.shape[3],1), y, self.last_scales
        X = X.reshape((X.shape[0],X.shape[1],X.shape[2],X.shape[3], 1))
        return [X, self.last_scales], X

    def __data_generation(self, nums_temp):

        '''Generates data containing batch_size samples'''

        # Initialization
        assert type(self.segments) == np.ndarray
        X = self.segments[nums_temp]
        self._get_last_scales(X)
        y = self.ids[nums_temp]

        # Generate data
        X = self.pipeline.fit_transform(X)

        # output batch with onehot labels
        return X

class SemanticsGenerator(BaseGenerator):

    '''No y'''

    def __getitem__(self, index):

        '''Generate one batch of data'''

        # Generate indexes of the batch
        indexes = self.indexes[index*self.batch_size : (index+1)*self.batch_size]

        # Find list of IDs
        nums_temp=self.nums[indexes] # to change

        # Generate data
        X = self.__data_generation(nums_temp)

        # return X.reshape(X.shape[0],X.shape[1],X.shape[2],X.shape[3],1), y, self.last_scales
        return X, self.last_scales

    def __data_generation(self, nums_temp):

        '''Generates data containing batch_size samples'''

        # Initialization
        assert type(self.segments) == np.ndarray
        X = self.segments[nums_temp]
        self._get_last_scales(X)
        y = self.ids[nums_temp]

        # Generate data
        X = self.pipeline.fit_transform(X)

        # output batch with onehot labels
        return X



def get_roc_pairs(
    segments,
    ids,
    USE_LAST_SAMPLE_ONLY=False,
    ALWAYS_AGAINST_LAST=False,
    MIN_DISTANCE_NEGATIVES=20.0,
):
    pair_ids = []
    pair_labels = []

    # calculate centroids
    centroids = [np.mean(segment, 0) for segment in segments]

    # positive samples
    for _id in np.unique(ids):
        class_ids = np.where(ids == _id)[0]

        n_ids = class_ids.size
        if n_ids != 1:
            # get halves
            if n_ids %2 != 0:
                class_ids = class_ids[1:]
            ids_1 = class_ids[:n_ids//2]
            ids_2 = class_ids[n_ids//2:]
            # get pairs
            if ALWAYS_AGAINST_LAST:
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
                        pass
                    n_positives = len(pair_ids)

    # negative samples
    np.random.seed(54321)
    ids = range(len(segments))

    last_ids = []
    for sequence in np.unique(duplicate_ids):
        last_ids.append(np.where(duplicate_ids == sequence)[0][-1])

    n_negatives = 0
    while n_negatives < n_positives:
        id_1 = np.random.sample(ids, 1)[0]
        id_2 = np.random.sample(ids, 1)[0]

        if ALWAYS_AGAINST_LAST:
            id_2 = np.random.sample(last_ids, 1)[0]

        dist = np.linalg.norm(centroids[id_1] - centroids[id_2])
        if dist >= MIN_DISTANCE_NEGATIVES:
            pair_ids.append([id_1, id_2])
            pair_labels.append(0)
            n_negatives += 1
            pass

    pair_ids = np.array(pair_ids)
    pair_labels = np.array(pair_labels)

    print("Positive pairs: %d" % n_positives)
    print("Negative pairs: %d" % n_negatives)

    return pair_ids, pair_labels


if __name__ == '__main__':
    pass