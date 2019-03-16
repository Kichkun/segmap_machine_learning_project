'''
data is taken from dataset27
after data.load
first n_samples/100 were taken and saved as csv, npy
'''
import matplotlib.pyplot as plt
from segment_encoder.tools.segment_tools import *
from segment_encoder.tools.voxel_tools import *

from segment_encoder.tools.plot_tools import plot_segment_pcl, plot_segments_pcl
import pickle
import os

SEGMENT_ID = 9 # which segment to show

# load small data
SMALL_DATA_DIR = r'../small_data'



with open(os.path.join(SMALL_DATA_DIR, 'segments.csv'), "rb") as f:
    segments_pointcloud = pickle.load(f)

positions = np.load(os.path.join(SMALL_DATA_DIR, 'positions.npy'))
classes = np.load(os.path.join(SMALL_DATA_DIR, 'classes.npy'))
features = np.load(os.path.join(SMALL_DATA_DIR, 'features.npy'))
duplicate_classes = np.load(os.path.join(SMALL_DATA_DIR, 'duplicate_classes.npy'))
n_classes = classes.shape[0]

segments_pointcloud = segments_pointcloud[:10]

segment_pointcloud = segments_pointcloud[SEGMENT_ID]
print(segment_pointcloud.shape)

segments_pointcloud = RandomRemover().fit_transform(segments_pointcloud)
segment_pointcloud = segments_pointcloud[SEGMENT_ID]
print(segment_pointcloud.shape)

segments_pointcloud = PlaneRemover().fit_transform(segments_pointcloud)
segment_pointcloud = segments_pointcloud[SEGMENT_ID]
print(segment_pointcloud.shape)

segments_pointcloud = EigenAligner().fit_transform(segments_pointcloud)
segment_pointcloud = segments_pointcloud[SEGMENT_ID]
print(segment_pointcloud.shape)

segments_pointcloud = RandomRotator().fit_transform(segments_pointcloud)
segment_pointcloud = segments_pointcloud[SEGMENT_ID]
print(segment_pointcloud.shape)

coordinates_scaler = CoordinatesRescaler(scale_method = "fixed",
                    center_method = "mean",
                    scale = np.array((8,8,4)),
                    voxel_shape = np.array((32, 32, 16)),
                    min_scale_threshold = np.array((3.2, 3.2, 1.6)))

segments_pointcloud = coordinates_scaler.fit_transform(segments_pointcloud)
segment_pointcloud = segments_pointcloud[SEGMENT_ID]
print(segment_pointcloud.shape)


segments_voxelbox = Voxelizer().fit_transform(segments_pointcloud)
segment_voxelbox = segments_voxelbox[SEGMENT_ID]
print(segment_voxelbox.shape)


segments_pointcloud = EigenAligner().fit_transform(segments_pointcloud)
segment_pointcloud = segments_pointcloud[SEGMENT_ID]
print(segment_pointcloud.shape)

coordinates_scaler = CoordinatesRescaler(scale_method = "fixed",
                    center_method = "mean",
                    scale = np.array((8,8,4)),
                    voxel_shape = np.array((32, 32, 16)),
                    min_scale_threshold = np.array((3.2, 3.2, 1.6)))
segments_pointcloud = coordinates_scaler.fit_transform(segments_pointcloud)
segment_pointcloud = segments_pointcloud[SEGMENT_ID]
print(segment_pointcloud.shape)

segments_voxelbox = Voxelizer().fit_transform(segments_pointcloud)
segment_voxelbox = segments_voxelbox[SEGMENT_ID]
print(segment_voxelbox.shape)