# -*- coding: utf-8 -*-
import numpy as np
import h5py
import deepdish as dd


#save segments and labels to hdf5 file
#input from origial loadings from csv
#segments - list of segments
#ids - list of ids of each segment in segments
#n_ids - amount of unique ids
#labels_dict - dictionary{id:label}
#filename - name for saved file "filename.hdf5"
#return written segment_dict
def saving_file(segments,ids,n_ids,labels_dict,filename):
    segment_dict={}
    for i in range(n_ids):
        segment_dict['id'+str(i)]={}
        segment_dict['id'+str(i)]['label']=np.array(labels_dict[i])
        segment_dict['id'+str(i)]['segments']=[]
    for i in range(len(segments)):
        segment_dict['id'+str(ids[i])]['segments'].append(segments[i])
    f = h5py.File(filename+'.hdf5','w')
    for key in segment_dict.keys():
        grp=f.create_group(key)
        grp.create_dataset('label',data=segment_dict[key]['label'])
        for i,segment in enumerate(segment_dict[key]['segments']):
            grp.create_dataset('num'+str(i),data=segment)
    f.close()
    return segment_dict

#load segments and labels from hdf5 file
#input
#filename - name for saved file "filename.hdf5"
#return segments_dict {id:list of segments}, 
# labels_dict {id:label}
def loading_file(filename):
    data=dd.io.load(filename+'.hdf5')
    labels_dict={}
    segments_dict={}
    for key in data.keys():
        seg_id=int(key[2:])
        labels_dict[seg_id]=data[key]['label']
        del data[key]['label']
        segments_dict[seg_id]=data[key].values()
    return segments_dict, labels_dict


#convert dictionary of segments into lists of segments and ids
#input
#segments_dict {id: list of segments}
#output
#segments - list of all segments,ids - list of ids of each segment
def converter(segments_dict):
    ids=[]
    segments=[]
    for key in segments_dict.keys():
        for segment in segments_dict[key]:
            ids.append(key)
            segments.append(segment)
    return segments,ids