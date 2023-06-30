import os as diva
"""
function: retrievePath()

Description: 
This function opens up a directory which displays all the session 2p folders for a specific mouse. Within this directory one goes into the
a session folder (example: Daas1 or Daas5) and retrieves necessary data. <<stats.npy or ops.npy>> Once the data is selected the absolute filepath
to it is returned as a string. 

INPUT: mouseName = The name a mouse for which sessions are being looked at. 
(note: The first letter of the mouses name can be lowercase or uppercase. Any irregular spellings will result in an error.)
OUTPUT: filepath = A filepath in the form of a string that directs one to desired data.
"""

def retrievePath(mouseName):

    if mouseName == 'Klan':

        #result1 is a list of pathnames in the initial path that lead to stat.npy files
        initialPath="N:/SRV/DATA/IvanLin/2P/"+mouseName+"/Daas"

        result1=[]
        filename='stat.npy'
        for root, dir, files in diva.walk(initialPath):
            if filename in files:
                result1.append(diva.path.join(root,filename))
        

        #result2 is a list of pathnames in the iniitial path that lead to ops.npy files
        result2=[]
        filename='ops.npy'
        for root, dir, files in diva.walk(initialPath):
            if filename in files:
                result2.append(diva.path.join(root,filename))

        #result 3 is a list of pathnames in the initial path that lead to iscell.npy files
        result3=[]
        filename='iscell.npy'
        for root, dir, files in diva.walk(initialPath):
            if filename in files:
                result3.append(diva.path.join(root,filename))


        return (result1,result2,result3)
        
    elif mouseName == 'Lama':

        initialPath="N:/SRV/DATA/IvanLin/2P/"+mouseName+"/Daas"

        result1=[]
        filename='stat.npy'
        for root, dir, files in diva.walk(initialPath):
            if filename in files:
                result1.append(diva.path.join(root,filename))

        result2=[]
        filename='ops.npy'
        for root, dir, files in diva.walk(initialPath):
            if filename in files:
                result2.append(diva.path.join(root,filename))

        result3=[]
        filename='iscell.npy'
        for root, dir, files in diva.walk(initialPath):
            if filename in files:
                result3.append(diva.path.join(root,filename))

        return (result1,result2,result3)

    elif mouseName == 'Leonel':

        initialPath="N:/SRV/DATA/IvanLin/2P/"+mouseName+"/Daas"

        result1=[]
        filename='stat.npy'
        for root, dir, files in diva.walk(initialPath):
            if filename in files:
                result1.append(diva.path.join(root,filename))

        result2=[]
        filename='ops.npy'
        for root, dir, files in diva.walk(initialPath):
            if filename in files:
                result2.append(diva.path.join(root,filename))

        result3=[]
        filename='iscell.npy'
        for root, dir, files in diva.walk(initialPath):
            if filename in files:
                result3.append(diva.path.join(root,filename))

        return (result1,result2,result3)
    
    elif mouseName == 'Luis':

        initialPath="N:/SRV/DATA/IvanLin/2P/"+mouseName+"/Daas"

        result1=[]
        filename='stat.npy'
        for root, dir, files in diva.walk(initialPath):
            if filename in files:
                result1.append(diva.path.join(root,filename))

        result2=[]
        filename='ops.npy'
        for root, dir, files in diva.walk(initialPath):
            if filename in files:
                result2.append(diva.path.join(root,filename))

        result3=[]
        filename='iscell.npy'
        for root, dir, files in diva.walk(initialPath):
            if filename in files:
                result3.append(diva.path.join(root,filename))

        return (result1,result2,result3)
    
    elif mouseName == 'Nuria':

        initialPath="N:/SRV/DATA/IvanLin/2P/"+mouseName+"/Daas"

        result1=[]
        filename='stat.npy'
        for root, dir, files in diva.walk(initialPath):
            if filename in files:
                result1.append(diva.path.join(root,filename))

        result2=[]
        filename='ops.npy'
        for root, dir, files in diva.walk(initialPath):
            if filename in files:
                result2.append(diva.path.join(root,filename))

        result3=[]
        filename='iscell.npy'
        for root, dir, files in diva.walk(initialPath):
            if filename in files:
                result3.append(diva.path.join(root,filename))

        return (result1,result2,result3)
    
    elif mouseName == 'Romero':
        initialPath="N:/SRV/DATA/IvanLin/2P/"+mouseName+"/Daas"

        result1=[]
        filename='stat.npy'
        for root, dir, files in diva.walk(initialPath):
            if filename in files:
                result1.append(diva.path.join(root,filename))

        result2=[]
        filename='ops.npy'
        for root, dir, files in diva.walk(initialPath):
            if filename in files:
                result2.append(diva.path.join(root,filename))

        result3=[]
        filename='iscell.npy'
        for root, dir, files in diva.walk(initialPath):
            if filename in files:
                result3.append(diva.path.join(root,filename))

        return (result1,result2,result3)
    
    elif mouseName == 'unicornia':

        initialPath="N:/SRV/DATA/IvanLin/2P/"+mouseName+"/Daas"

        result1=[]
        filename='stat.npy'
        for root, dir, files in diva.walk(initialPath):
            if filename in files:
                result1.append(diva.path.join(root,filename))

        result2=[]
        filename='ops.npy'
        for root, dir, files in diva.walk(initialPath):
            if filename in files:
                result2.append(diva.path.join(root,filename))

        result3=[]
        filename='iscell.npy'
        for root, dir, files in diva.walk(initialPath):
            if filename in files:
                result3.append(diva.path.join(root,filename))

        return (result1,result2,result3)
    
    elif mouseName == 'klan':

        initialPath="N:/SRV/DATA/IvanLin/2P/"+mouseName+"/Daas"

        result1=[]
        filename='stat.npy'
        for root, dir, files in diva.walk(initialPath):
            if filename in files:
                result1.append(diva.path.join(root,filename))

        result2=[]
        filename='ops.npy'
        for root, dir, files in diva.walk(initialPath):
            if filename in files:
                result2.append(diva.path.join(root,filename))\
                
        result3=[]
        filename='iscell.npy'
        for root, dir, files in diva.walk(initialPath):
            if filename in files:
                result3.append(diva.path.join(root,filename))

        return (result1,result2,result3)
    
    elif mouseName == 'lama':

        initialPath="N:/SRV/DATA/IvanLin/2P/"+mouseName+"/Daas"

        result1=[]
        filename='stat.npy'
        for root, dir, files in diva.walk(initialPath):
            if filename in files:
                result1.append(diva.path.join(root,filename))

        result2=[]
        filename='ops.npy'
        for root, dir, files in diva.walk(initialPath):
            if filename in files:
                result2.append(diva.path.join(root,filename))

        result3=[]
        filename='iscell.npy'
        for root, dir, files in diva.walk(initialPath):
            if filename in files:
                result3.append(diva.path.join(root,filename))

        return (result1,result2,result3)
    
    elif mouseName == 'leonel':

        initialPath="N:/SRV/DATA/IvanLin/2P/"+mouseName+"/Daas"

        result1=[]
        filename='stat.npy'
        for root, dir, files in diva.walk(initialPath):
            if filename in files:
                result1.append(diva.path.join(root,filename))

        result2=[]
        filename='ops.npy'
        for root, dir, files in diva.walk(initialPath):
            if filename in files:
                result2.append(diva.path.join(root,filename))

        result3=[]
        filename='iscell.npy'
        for root, dir, files in diva.walk(initialPath):
            if filename in files:
                result3.append(diva.path.join(root,filename))

        return (result1,result2,result3)
    
    elif mouseName == 'luis':

        initialPath="N:/SRV/DATA/IvanLin/2P/"+mouseName+"/Daas"

        result1=[]
        filename='stat.npy'
        for root, dir, files in diva.walk(initialPath):
            if filename in files:
                result1.append(diva.path.join(root,filename))

        result2=[]
        filename='ops.npy'
        for root, dir, files in diva.walk(initialPath):
            if filename in files:
                result2.append(diva.path.join(root,filename))

        result3=[]
        filename='iscell.npy'
        for root, dir, files in diva.walk(initialPath):
            if filename in files:
                result3.append(diva.path.join(root,filename))

        return (result1,result2,result3)
    
    elif mouseName == 'nuria':

        initialPath="N:/SRV/DATA/IvanLin/2P/"+mouseName+"/Daas"

        result1=[]
        filename='stat.npy'
        for root, dir, files in diva.walk(initialPath):
            if filename in files:
                result1.append(diva.path.join(root,filename))

        result2=[]
        filename='ops.npy'
        for root, dir, files in diva.walk(initialPath):
            if filename in files:
                result2.append(diva.path.join(root,filename))

        result3=[]
        filename='iscell.npy'
        for root, dir, files in diva.walk(initialPath):
            if filename in files:
                result3.append(diva.path.join(root,filename))

        return (result1,result2,result3)
    
    elif mouseName == 'romero':

        initialPath="N:/SRV/DATA/IvanLin/2P/"+mouseName+"/Daas"

        result1=[]
        filename='stat.npy'
        for root, dir, files in diva.walk(initialPath):
            if filename in files:
                result1.append(diva.path.join(root,filename))

        result2=[]
        filename='ops.npy'
        for root, dir, files in diva.walk(initialPath):
            if filename in files:
                result2.append(diva.path.join(root,filename))

        result3=[]
        filename='iscell.npy'
        for root, dir, files in diva.walk(initialPath):
            if filename in files:
                result3.append(diva.path.join(root,filename))

        return (result1,result2,result3)
    
    elif mouseName == 'Unicornia':

        initialPath="N:/SRV/DATA/IvanLin/2P/"+mouseName+"/Daas"

        result1=[]
        filename='stat.npy'
        for root, dir, files in diva.walk(initialPath):
            if filename in files:
                result1.append(diva.path.join(root,filename))

        result2=[]
        filename='ops.npy'
        for root, dir, files in diva.walk(initialPath):
            if filename in files:
                result2.append(diva.path.join(root,filename))

        result3=[]
        filename='iscell.npy'
        for root, dir, files in diva.walk(initialPath):
            if filename in files:
                result3.append(diva.path.join(root,filename))

        return (result1,result2,result3)
    
    else:
        print("Error: No name or inappropriate name given.\n")
        return (None,None,None)

#Test Calls
'''
a=input("Please provide the name of a mouse\n")
(statPath,opPath,iscellPath)=retrievePath(a)
print("\n")
print(statPath)
print("\n")
print(opPath)
print("\n")
print(iscellPath)
print("\n")
''' 
