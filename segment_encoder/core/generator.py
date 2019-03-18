import numpy as np
import tensorflow as tf
from main_pipelines import train_pipeline, load_segments
from plot_tools import plot_segment_voxelboxes
# from ..tools.plot_tools import plot_segment_voxelboxes

class DataGenerator(tf.keras.utils.Sequence):
    '''Generates data for Keras Simple'''

    def __init__(self, nums, segments, ids,batch_size=32, dim=(32,32,16),
                 n_classes=3, shuffle=True, scale_method='fit'):
        'Initialization'
        self.dim = dim
        self.batch_size = batch_size
        self.nums = nums # segment nums
        self.n_classes = n_classes
        self.shuffle = shuffle
        self.segments = segments
        self.ids=ids
        self.last_scales = None
        self.scale_method = scale_method
        self.on_epoch_end()

    def __len__(self):
        'Denotes the number of batches per epoch'
        return int(np.floor(len(self.list_IDs) / self.batch_size))

    def __getitem__(self, index):
        'Generate one batch of data'
        # Generate indexes of the batch
        indexes = self.indexes[index*self.batch_size:(index+1)*self.batch_size]

        # Find list of IDs
        nums_temp=self.nums[indexes] # to change

        # Generate data
        X, y = self.__data_generation(nums_temp)

        return X, y, self.last_scales

    def on_epoch_end(self):
        'Updates indexes after each epoch'
        self.indexes = np.arange(self.nums.size)
        if self.shuffle == True:
            np.random.shuffle(self.indexes)

    def __data_generation(self, nums_temp):
        'Generates data containing batch_size samples' # X : (n_samples, *dim)
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

if __name__ == '__main__':
    pointcloud_segments, positions, ids, features, duplicate_classes, n_classes = load_segments()
    pointcloud_segments = np.array(pointcloud_segments, dtype=np.object)
    # a = segments[np.array((1,2,3))]

    generator = DataGenerator(nums=np.arange(len(pointcloud_segments)),
                              segments=pointcloud_segments,
                              ids=ids,
                              batch_size=32,
                              dim=(32,32,16),
                              n_classes=n_classes)

    voxelbox_segments_batch, ids_batch, last_scales_batch = generator.__getitem__(index=0)

    print(voxelbox_segments_batch.shape)
    plot_segment_voxelboxes(voxelboxes=voxelbox_segments_batch)
