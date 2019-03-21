# "Segmap" 3D Segment Mapping using Data-Driven Descriptors
## Machine Learning Course Project Skoltech 2019
 
We implemented the "Segmap"[1] work.  SegMap is the state-of-the-art work, provided the approach of a map representation solution to the localization and mapping problem based on the extracted segments from 3D point clouds. We leverages a data-driven descriptorin order to extract meaningful features that can also be used for reconstructing a dense 3D map of the environment and for extracting semantic information. This is particularly interesting for navigation tasks and for providing visual feedback to end-users such as robot operators, for example in search and rescuescenarios.

 ![General scheme](https://github.com/Kichkun/segmap_machine_learning_project/blob/master/plots/scheme.png)
### Input:
* labeled segments from LiDAR data
### Preprocessing:
* mark up the data
* voxelize
* augment

### Our goals: 
* compressed representation(data-driven descriptors) from LiDAR segments 
* reconstruction
* semantic classification 

### Datasets used: 
1. SegMap provided dataset based on Kitti odometry sequences[2] with segments extracted by their previously proposed approach[3]. 
The provided dataset wasn't labeled fully and correctly, we mark down all data, change the representation to *.npy for fast and convinient use and upload partly in folder "datasets". 
2. Beyond PASCAL: A Benchmark for 3D Object Detection in the Wild[4]. We had an idea to learn our model on perfect segments recieved from CAD-models, however on voxelization step it becomes clear that this dataset doesn't suit us due to very sparse results. 
3. SYDNEY URBAN OBJECTS DATASET[5]. We got this dataset on last stage of our project. It's suit us. Used for tests.
4. Vision meets Robotics: The KITTI Dataset. We were trying to use Kitti 3D object dataset[6] however we were not managed to extract valuable segments from LiDAR data. This dataset was created for other goals.

## Authors

* **Anastasia Kishkun** 
* **Alenicheva Alisa** 
* **Grashchenkov Kirill** 
* **Konstantin Pakulev** 
* **Roman Zinoviev** 

### Resources & References
[3D Segment Mapping using Data-Driven Descriptors]: http://www.roboticsproceedings.org/rss14/p03.pdf
[Kitti odometry dataset]: http://www.cvlibs.net/datasets/kitti/eval_odometry.php
[SegMatch: Segment based place recognition in 3D point clouds]: https://www.researchgate.net/publication/318693876_SegMatch_Segment_based_place_recognition_in_3D_point_clouds
[Beyond PASCAL: A Benchmark for 3D Object Detection in the Wild]: http://cvgl.stanford.edu/projects/pascal3d.html
[SYDNEY URBAN OBJECTS DATASET]: http://www.acfr.usyd.edu.au/papers/SydneyUrbanObjectsDataset.shtml
[Vision meets Robotics: The KITTI Dataset]: http://www.cvlibs.net/publications/Geiger2013IJRR.pdf
1. [3D Segment Mapping using Data-Driven Descriptors]

2. [Kitti odometry dataset]

3. [Beyond PASCAL: A Benchmark for 3D Object Detection in the Wild]

4. [SYDNEY URBAN OBJECTS DATASET]

5. [Vision meets Robotics: The KITTI Dataset]

6. [Vision meets Robotics: The KITTI Dataset]
 
