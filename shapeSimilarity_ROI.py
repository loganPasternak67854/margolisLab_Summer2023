"""""
Problem:

In order to analyze neuronal activity over multiple days, it is crucial to ensure accurate tracking of the same neurons. However,
This can be challenging due to slight variattions in recording parameters across different days. After collecting videos, I utilize
a software called Suite2p to process them. This software extracts the region of interest (ROI) associated with the neurons and captures
the fluorescence changes. Unfortunately, accessing the mask shape of the ROI is only possible through Python, while all my code is written in MATLAB.

AIM: 

Write a code in python, that first, goes folder by folder of my neuronal activity recordings (Romero Folders on the Drive), 2nd, extracts the masks of
the ROIs, and saves the individual masks as a file that can be used in Matlab. Onece in Matlab, we will need to be able to compare ROI mask from
different days, and make a similarity analysis to determine if the ROIs are the same or different.

Folders:
N:/SRV/DATA/IvanLin\/2P/Romero/Daas

Masks can be found here:
N:/SRV/DATA/IvanLin/2P/Romero/Daas/Daas1/suite2p/plane0

"""

import retrievePath as func1
import extract_ROI as func2
import identification as func3
import matplotlib.pyplot as plt
import numpy as np
from tkinter import filedialog

class Images():
    #Initilize the object with the ROI image matrix and a reference number. This reference number is used to identify an image.
    def __init__(self,matrix,num,mouse):
        self.image=matrix
        self.refNum=num
        self.mouseName=mouse

    #Destructor for Images instance
    def __del__(self):
            print("")

    #Allows one to retrieve the image matrix for an instance of a class
    def getImage(self):
        return self.image
    
    #Allows one to retrieve the reference number for an instance of a class
    def getNum(self):
        return self.refNum
    
    #Allows one to retrieve the name of the mouse for an instance of a class
    def getName(self):
        return self.mouseName
    
    #Allows one to change the image matrix for an instance of a class if needed
    def setImage(self,matrix):
        self.image=matrix
    
    #Allows one to change the reference number for an instance of a class
    def setNum(self,num):
        self.refNum=num

    #Allows one to change the name of the mouse for an istance of a class
    def setName(self,mouse):
        self.mouseName=mouse


    #Displays image of ROI matrix
    def showImage(self):

        temp=self.refNum
        print("THIS IS IMAGE ",temp)

        #matplotlib.pyplot.imshow(imageData): in pyplot module of matplotlib library is used to display data
        #as an image; i.e. on a 2D regular raster
        plt.imshow(self.image)

        #plt.show(): Display all open figures
        plt.show()


#retrievePath for stat.npy and ops.npy for given mouse

mouseName=input("Please provide the name of a mouse\n")

#print("Retrieve stat.npy and ops.npy path arrays.\n")

(statPaths,opsPaths)=func1.retrievePath(mouseName)

#Provides an array which shows which Daas is associated with a specific path and index

trueName=[]

for i in range(0,len(statPaths)):

    road=statPaths[i]
    temp=func3.identification(road)
    trueName.append(temp)


#Give confirmation that you want to save all ROI data saved to the directory
no_or_yes=int(input("If you want to save all ROI data into the directory please press 1, otherwise type 0...\n"))
    
if no_or_yes==1:
        
    #Retrieve a folder in which you want to save your new data
    my_dir=filedialog.askdirectory()

    #Extract the ROI data for given the stat.npy and ops.npy data retrieved above and store in a 3d array

    image_array = []

    for i in range(0,len(statPaths)):
        
        matrix=func2.extract_ROI(statPaths[i],opsPaths[i])
        new_mouseName=str(mouseName)
        new_i=str(i)
        combinedPath=my_dir+'/'+new_mouseName+new_i+'.csv'
        image_array.append(Images(matrix,i,mouseName))

    #Output test
    for i in range (0,len(statPaths)):
        print("\n")
        print(image_array[i].mouseName)
        print("\n")
        print(image_array[i].refNum)
        print("\n")
        print(image_array[i].image)
        print("\n\n\n")

    #print("This is the number of Daas': ", len(statPaths))

    #This function will save the ROS matrices as csv files (example: Romero will give us 20 ROS csv files)
    for i in range(0,len(statPaths)):
        #fileName=str(image_array[i].mouseName)+image_array[i]+trueName[i]+'.csv'
        fileName=str(image_array[i].mouseName)+trueName[i]+'.csv'
        np.savetxt(fileName,image_array[i].image,delimiter=',')

    #Deletes image object array
    for i in range (len(statPaths),0):
        del image_array[i]

else:
    #Extract the ROI data for given the stat.npy and ops.npy data retrieved above and store in a 3d array

    image_array = []
     
    for i in range(0,len(statPaths)):
        
        matrix=func2.extract_ROI(statPaths[i],opsPaths[i])
        image_array.append(Images(matrix,i,mouseName))

    #Output test
    for i in range (0,len(statPaths)):
        print("\n")
        print(image_array[i].mouseName)
        print("\n")
        print(image_array[i].refNum)
        print("\n")
        print(image_array[i].image)
        print("\n\n\n")

    #This shows an image for one of the ROS matrices
    image_array[0].showImage()

    #Deletes image object array
    for i in range (len(statPaths),0):
        del image_array[i]
