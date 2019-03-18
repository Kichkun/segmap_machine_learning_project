# todo maybe use global_ids, object_ids

from sklearn.pipeline import Pipeline
from segment_encoder.tools.segment_tools import RandomRemover,\
                                                PlaneRemover,\
                                                EigenAligner,\
                                                RandomRotator,\
                                                CoordinatesRescaler
from segment_encoder.tools.voxel_tools import Voxelizer

import pickle
import os
import numpy as np

SMALL_DATA_DIR = r'../small_data'


def train_pipeline(pointcloud_segments):

    augmentation_pipeline = Pipeline\
            ([
            ('RandomRemover', RandomRemover()),
            ('PlaneRemover', PlaneRemover()),
            ('EigenAligner', EigenAligner()),
            ('Rotator', RandomRotator()),
    ])

    pointcloud_segments = augmentation_pipeline.fit_transform(pointcloud_segments)

    preprocessing_pipeline = Pipeline([
            ('CoordinatesRescaler', CoordinatesRescaler(scale_method = "fit", center_method = "mean")),
            # ('Jitter', Jitter()),
            ('Voxelizer', Voxelizer()),
            # ('VoxelNormalizer', VoxelNormalizer(train_ids=train_ids))
        ])

    voxelbox = preprocessing_pipeline.fit_transform(pointcloud_segments)

    return voxelbox

def load_segments():
    with open(os.path.join(SMALL_DATA_DIR, 'segments.csv'), "rb") as f:  # Unpickling
        segments = pickle.load(f)

    positions = np.load(os.path.join(SMALL_DATA_DIR, 'positions.npy'))
    classes = np.load(os.path.join(SMALL_DATA_DIR, 'classes.npy'))
    features = np.load(os.path.join(SMALL_DATA_DIR, 'features.npy'))
    duplicate_classes = np.load(os.path.join(SMALL_DATA_DIR, 'duplicate_classes.npy'))
    n_classes = classes.shape[0]
    return segments, positions, classes, features, duplicate_classes, n_classes

if __name__ == '__main__':
    pointcloud_segments, positions, classes, features, duplicate_classes, n_classes = load_segments()
    voxelbox_segments = train_pipeline(pointcloud_segments)
    print(voxelbox_segments.shape)
