from sklearn.pipeline import Pipeline
from ..tools.segment_tools import *
segments = np.array([])

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
            ('Rotator', Rotator()),
    ])

    segments = segments_preprocessing_pipeline.fit_transform(segments)

    if to_voxelise:
        voxel_preprocessing_pipeline = Pipeline([
                ('CoordinatesRescaler', CoordinatesRescaler(scale_method = "fixed", center_method = "mean")),
                ('Jitter', Jitter()),
                ('Voxelizer', Voxelizer()),
                ('VoxelNormalizer', VoxelNormalizer(train_ids=train_ids))
            ])

        segments = voxel_preprocessing_pipeline.fit_transform(segments)

    return segments

def load_segments():
    raise NotImplementedError
    return

if __name__ == '__main__':
    segments = load_segments()
    segments = init_pipeline(segments)
    segments = train_pipeline(segments)
