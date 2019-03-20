import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import numpy as np
import sys

def plot_segment_pcl(segment, extra_info=None, segment_id=0):

    # scale the axes to match for all the segments
    axes_min = np.array(np.min(segment, axis=0))
    axes_max = np.array(np.max(segment, axis=0))

    fig = plt.figure(segment_id, figsize=(12, 6))
    plt.clf()
    ax = fig.add_subplot(111, projection="3d")

    ax.set_xlim(axes_min[0], axes_max[0])
    ax.set_ylim(axes_min[1], axes_max[1])
    ax.set_zlim(axes_min[2], axes_max[2])

    x, y, z = np.hsplit(segment, segment.shape[1])
    ax.scatter(x, y, z, c=list(((z - min(z)) / max(z)).reshape(-1, )), s=5)

    # fig.canvas.flush_events()
    plt.show()


def plot_segments_pcl(segments, extra_info=None):
    for i, segment in enumerate(segments):
        plot_segment_pcl(segment, extra_info=extra_info, segment_id=i)
    plt.ioff()
    plt.close("all")


def plot_segment_voxelbox(voxelbox):

        # convert representation of batch to scatterplot
        segment = []
        for x in range(voxelbox.shape[0]):
            for y in range(voxelbox.shape[1]):
                for z in range(voxelbox.shape[2]):
                    if voxelbox[x, y, z] == 1:
                        segment.append([x, y, z])

        # plot processed segment
        segment_voxel = np.array(segment)
        fig = plt.figure(1, figsize=(12, 6))
        plt.clf()

        ax1 = fig.add_subplot(111, projection="3d")

        # Maintain aspect ratio on xy scale
        ax1.set_xlim(np.min(segment_voxel[:, :]), np.max(segment_voxel[:, :]))
        ax1.set_ylim(np.min(segment_voxel[:, :]), np.max(segment_voxel[:, :]))
        ax1.set_zlim(np.min(segment_voxel[:, :]), np.max(segment_voxel[:, :]))

        x, y, z = np.hsplit(segment_voxel, segment_voxel.shape[1])
        ax1.scatter(x, y, z, c=list(((z - min(z)) / max(z)).reshape(-1, )))

        plt.show()


def plot_segment_voxelboxes(voxelboxes):

    for i in range(voxelboxes.shape[0]):

        # convert representation of batch to scatterplot
        segment_voxel = []
        for x in range(voxelboxes.shape[1]):
            for y in range(voxelboxes.shape[2]):
                for z in range(voxelboxes.shape[3]):
                    if voxelboxes[i, x, y, z] == 1:
                        segment_voxel.append([x, y, z])

        # plot processed segment
        segment_voxel = np.array(segment_voxel)
        fig = plt.figure(1, figsize=(12, 6))
        plt.clf()

        ax1 = fig.add_subplot(111, projection="3d")

        # Maintain aspect ratio on xy scale
        ax1.set_xlim(np.min(segment_voxel[:, :]), np.max(segment_voxel[:, :]))
        ax1.set_ylim(np.min(segment_voxel[:, :]), np.max(segment_voxel[:, :]))
        ax1.set_zlim(np.min(segment_voxel[:, :]), np.max(segment_voxel[:, :]))

        x, y, z = np.hsplit(segment_voxel, segment_voxel.shape[1])
        ax1.scatter(x, y, z, c=list(((z - min(z)) / max(z)).reshape(-1, )))

        plt.show()

if __name__ == '__main__':
    print('plot_tools done!')