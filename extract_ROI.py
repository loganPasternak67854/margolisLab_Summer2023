import numpy as np

"""
extract_ROI:
FUNCTIONALITY:
This function extracts the ROIs on python.
INPUTS:
statPath= the pathname for the stat.npy file within a session folder (Example: Daas1->suite2p->plane0->stat.npy)
opsPath= the pathname for the ops.npy file within a session folder (Example: Daas1->suite2p->plane0->ops.npy)
OUTPUT:

Returns an image matrix that will be fed into a 3d matrix 

Displays all the ROIs for each session.

"""

def extract_ROI(statPath,opsPath,iscellPath):
    #numpy.load(filename): function return the input array from a disk file with npy extension(.npy)

    stat = np.load(statPath,allow_pickle=True)
    iscell=np.load(iscellPath,allow_pickle=True)
    ops = np.load(opsPath,allow_pickle=True).item()

    #numpy.zeros(shape): return a new array of given shape and type, filled with zeros
    #The number of rows is equal ops['Ly'] and the number of columns is equal to ops['Lx']

    im = np.zeros((ops['Ly'], ops['Lx']))

    #Number of cells is equal to the size of stats
    ncells=stat.size

    for n in range(0,ncells):
        
        #USE iscell to select cells that we want to include and exclude those that we don't (1 is good! 0 is bad!)
        if iscell[n,0]==1:
        ypix = stat[n]['ypix'][~stat[n]['overlap']]
        xpix = stat[n]['xpix'][~stat[n]['overlap']]
        im[ypix,xpix] = n+1

    return im  
    
