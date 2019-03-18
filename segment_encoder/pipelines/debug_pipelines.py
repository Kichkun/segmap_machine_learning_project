'''
data is taken from dataset27
after data.load
first n_samples/100 were taken and saved as csv, npy
'''
import matplotlib.pyplot as plt
import numpy as np
import pickle
import os

import tensorflow as tf
HDF5_PATH = r'../../notebooks/'
f_name = 'data18.hdf5'
print(os.path.join(HDF5_PATH, f_name))

x_data = tf.keras.utils.HDF5Matrix(HDF5_PATH, 'data')

from segment_encoder.tools.segment_tools import RandomRemover,\
                                                PlaneRemover,\
                                                EigenAligner,\
                                                RandomRotator,\
                                                CoordinatesRescaler
from segment_encoder.tools.voxel_tools import Voxelizer

from segment_encoder.tools.plot_tools import plot_segment_pcl, \
                                             plot_segments_pcl, \
                                             plot_segment_voxelbox


SEGMENT_ID = 9 # which segment to show

# load small data
SMALL_DATA_DIR = r'../small_data'



with open(os.path.join(SMALL_DATA_DIR, 'segments.csv'), "rb") as f:
    pointcloud_segments= pickle.load(f)

positions = np.load(os.path.join(SMALL_DATA_DIR, 'positions.npy'))
classes = np.load(os.path.join(SMALL_DATA_DIR, 'classes.npy'))
features = np.load(os.path.join(SMALL_DATA_DIR, 'features.npy'))
duplicate_classes = np.load(os.path.join(SMALL_DATA_DIR, 'duplicate_classes.npy'))
n_classes = classes.shape[0]

pointcloud_segments = pointcloud_segments[:10]

pointcloud_segment = pointcloud_segments[SEGMENT_ID]
print(pointcloud_segment.shape)

pointcloud_segments = RandomRemover().fit_transform(pointcloud_segments)
pointcloud_segment = pointcloud_segments[SEGMENT_ID]
print(pointcloud_segment.shape)

pointcloud_segments = PlaneRemover().fit_transform(pointcloud_segments)
pointcloud_segment = pointcloud_segments[SEGMENT_ID]
print(pointcloud_segment.shape)

pointcloud_segments = EigenAligner().fit_transform(pointcloud_segments)
pointcloud_segment = pointcloud_segments[SEGMENT_ID]
print(pointcloud_segment.shape)

pointcloud_segments = RandomRotator().fit_transform(pointcloud_segments)
pointcloud_segment = pointcloud_segments[SEGMENT_ID]
print(pointcloud_segment.shape)

coordinates_scaler = CoordinatesRescaler(scale_method = "fixed",
                    center_method = "mean",
                    scale = np.array((8,8,4)),
                    voxel_shape = np.array((32, 32, 16)),
                    min_scale_threshold = np.array((3.2, 3.2, 1.6)))

pointcloud_segments = coordinates_scaler.fit_transform(pointcloud_segments)
pointcloud_segment = pointcloud_segments[SEGMENT_ID]
print(pointcloud_segment.shape)


voxelbox_segments = Voxelizer().fit_transform(pointcloud_segments)
voxelbox_segment = voxelbox_segments[SEGMENT_ID]
print(voxelbox_segment.shape)


pointcloud_segments = EigenAligner().fit_transform(pointcloud_segments)
pointcloud_segment = pointcloud_segments[SEGMENT_ID]
print(pointcloud_segment.shape)

coordinates_scaler = CoordinatesRescaler(scale_method = "fixed",
                    center_method = "mean",
                    scale = np.array((8,8,4)),
                    voxel_shape = np.array((32, 32, 16)),
                    min_scale_threshold = np.array((3.2, 3.2, 1.6)))
pointcloud_segments = coordinates_scaler.fit_transform(pointcloud_segments)
pointcloud_segment = pointcloud_segments[SEGMENT_ID]
print(pointcloud_segment.shape)

voxelbox_segments = Voxelizer(voxel_shape = np.array((64, 64, 8))).fit_transform(pointcloud_segments)
voxelbox_segment = voxelbox_segments[SEGMENT_ID]
print(voxelbox_segment.shape)
