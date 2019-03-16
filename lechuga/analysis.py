from __future__ import print_function
import numpy as np
import matplotlib.pyplot as plt
import os
from preprocessor import Preprocessor
from dataset import Dataset

data18=Dataset(folder='dataset18')
segments, _, ids, n_ids, features, matches, labels_dict = data18.load()
preprocessor=Preprocessor(augment_angle=180,
	augment_remove_random_min=0.0,
	augment_remove_random_max=0.1,
	augment_remove_plane_min=0.0,
	augment_remove_plane_max=0.5,
	augment_jitter=0.0,
	align="eigen",
	voxelize=True,
	scale_method="fit",
	center_method="mean",
	scale=(8, 8, 4),
	voxels=(32, 32, 16),
	remove_mean=False,
	remove_std=False,
	batch_size=32,
	scaler_train_passes=1)


segments, positions, classes, n_classes, _, _, _ = data18.load(
    preprocessor=preprocessor
)


# Class size distribution
class_histogram, _ = np.histogram(classes, bins=range(n_classes + 1))
class_size_histogram, bins = np.histogram(
    class_histogram, bins=range(np.max(class_histogram) + 2)
)

fig1 = plt.figure(1)
plt.bar(bins[:-1], class_size_histogram)

# Segment size distribution
segments_size = []
for segment in segments:
    segments_size.append(np.max(segment, axis=0) - np.min(segment, axis=0))
segments_size = np.array(segments_size)
fig1.savefig("./tmp1/" + "analysis1.png")
fig2 = plt.figure(2)
segments_size = np.ceil(segments_size)
for axis in range(segments_size.shape[1]):
    axis_sizes = segments_size[:, axis]
    sizes_histogram, bins = np.histogram(
        axis_sizes, bins=np.arange(np.min(axis_sizes), np.max(axis_sizes) + 2)
    )
    sizes_cdf = np.cumsum(sizes_histogram) / float(np.sum(sizes_histogram))

    plt.subplot(3, 1, axis + 1)
    plt.plot(bins[:-1], sizes_cdf)
fig2.savefig("./tmp1/" + "analysis2.png")
plt.show()