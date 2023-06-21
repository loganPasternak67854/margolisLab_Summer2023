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

def extract_ROI(statPath,opsPath):
    #numpy.load(filename): function return the input array from a disk file with npy extension(.npy)

    stat = np.load(statPath,allow_pickle=True)
    ops = np.load(opsPath,allow_pickle=True).item()

    #numpy.zeros(shape): return a new array of given shape and type, filled with zeros
    #The number of rows is equal ops['Ly'] and the number of columns is equal to ops['Lx']

    im = np.zeros((ops['Ly'], ops['Lx']))

    #Number of cells is equal to the size of stats
    ncells=stat.size
    #print("\n")
    #print(ncells)

    #What is ncells? Is one supposed to retrieve it from ops in some way?

    for n in range(0,ncells):
        ypix = stat[n]['ypix'][~stat[n]['overlap']]
        xpix = stat[n]['xpix'][~stat[n]['overlap']]
        im[ypix,xpix] = n+1

    return im  
    
