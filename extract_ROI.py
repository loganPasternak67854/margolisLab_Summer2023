import numpy as np
from colorsys import hsv_to_rgb

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

#CITE CODE FOR ROI EXTRACTION: ON MAC

"""

def extract_ROI(statPath,opsPath,iscellPath):
    #numpy.load(filename): function return the input array from a disk file with npy extension(.npy)

    stat = np.load(statPath,allow_pickle=True)
    iscell=np.load(iscellPath,allow_pickle=True)[:,0].astype(int)
    ops = np.load(opsPath,allow_pickle=True).item()

    '''
    print('Stat Shape')
    print(stat.shape)
    print('\n')
    print('iscell Shape')
    print(iscell.shape)
    '''

    #numpy.zeros(shape): return a new array of given shape and type, filled with zeros
    #The number of rows is equal ops['Ly'] and the number of columns is equal to ops['Lx']

    #im = np.zeros((ops['Ly'], ops['Lx']))

    #Number of cells is equal to the size of stats
    #There might be a problem with the extraction of stats

    ncells=len(stat)
    h=np.random.rand(ncells)
    Lx=ops['Lx']
    Ly=ops['Ly']
    hsvs=np.zeros((2,Ly,Lx,3),dtype=np.float32)

    for i, stat in enumerate(stat):
            ypix=stat['ypix']
            xpix=stat['xpix']
            lam=stat['lam']
            hsvs[iscell[i], ypix, xpix, 0] = h[i]
            hsvs[iscell[i], ypix,xpix,1]=1
            hsvs[iscell[i],ypix,xpix,2]=lam/lam.max()
    
    rgbs=np.array([hsv_to_rgb(*hsv) for hsv in hsvs.reshape(-1,3)]).reshape(hsvs.shape)

    '''
    for n in range(0,ncells):
        
        #USE iscell to select cells that we want to include and exclude those that we don't (1 is good! 0 is bad!)
        if iscell[n,0]==1:
            ypix = stat[n]['ypix'][~stat[n]['overlap']]
            xpix = stat[n]['xpix'][~stat[n]['overlap']]
            im[ypix,xpix] = n+1

    #im[im==0]=np.nan
    '''
    return (rgbs)

    

#Test Input

'''
statPath='N:/SRV/DATA/IvanLin/2P/Romero/Daas/Daas1/suite2p/plane0/stat.npy'
opsPath='N:/SRV/DATA/IvanLin/2P/Romero/Daas/Daas1/suite2p/plane0/ops.npy'
iscellPath='N:/SRV/DATA/IvanLin/2P/Romero/Daas/Daas1/suite2p/plane0/iscell.npy'
x=extract_ROI(statPath,opsPath,iscellPath)
print(x)
'''
    
