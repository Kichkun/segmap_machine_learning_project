from sklearn.pipeline import Pipeline
from ..tools.segment_tools import *
import pickle
import os

SMALL_DATA_DIR = r'../small_data'

with open(os.path.join(SMALL_DATA_DIR, 'segments.csv'), "rb") as f:   # Unpickling
    segments = pickle.load(f)

positions = np.load(os.path.join(SMALL_DATA_DIR, 'positions.npy'))
classes = np.load(os.path.join(SMALL_DATA_DIR, 'classes.npy'))
features = np.load(os.path.join(SMALL_DATA_DIR, 'features.npy'))
duplicate_classes = np.load(os.path.join(SMALL_DATA_DIR, 'duplicate_classes.npy'))
n_classes = classes.shape[0]


def init_pipeline(segments=None, classes=None, positions=None, train_ids=None, scaler_path=None):
    init_pipeline = Pipeline([
            ('RobotAligner', RobotAligner(positions)),
        ])
    return init_pipeline.fit_transform(segments)


def train_pipeline(segments, train_ids, to_voxelise = True):

    segments_preprocessing_pipeline = Pipeline([
            ('RandomRemover', RandomRemover()),
            ('PlaneRemover', PlaneRemover()),
            ('EigenAligner', EigenAligner(method='eigen')),
            ('Rotator', RandomRotator()),
    ])

    segments = segments_preprocessing_pipeline.fit_transform(segments)

    if to_voxelise:
        voxels_preprocessing_pipeline = Pipeline([
                ('CoordinatesRescaler', CoordinatesRescaler(scale_method = "fixed", center_method = "mean")),
                ('Jitter', Jitter()),
                ('Voxelizer', Voxelizer()),
                ('VoxelNormalizer', VoxelNormalizer(train_ids=train_ids))
            ])

        voxels = voxels_preprocessing_pipeline.fit_transform(segments)

    return voxels

def load_segments():
    raise NotImplementedError
    return

if __name__ == '__main__':
    segments = load_segments()
    segments = init_pipeline(segments)
    segments = train_pipeline(segments)
