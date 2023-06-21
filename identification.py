'''
identification: This function will take the array of pathnames supplied from retrievePaths. 
The find method will be used on these pathnames in order to identify the Daas number at a specific index of the pathname array. 
The output will be an array where each element shows the associated Daas number at the index.
'''

import retrievePath as func3

def identification(statPath):

    name=[]

    str=statPath

    if (str.find('Daas1'))!=-1:

        if (str.find('Daas10'))!=-1:

                temp=str.find('Daas10')
                placeholder=str[temp:(temp+6)]
                name=placeholder
            
        elif (str.find('Daas11'))!=-1:

                temp=str.find('Daas11')
                placeholder=str[temp:(temp+6)]
                name=placeholder


        elif (str.find('Daas12'))!=-1:

                temp=str.find('Daas12')
                placeholder=str[temp:(temp+6)]
                name=placeholder

        elif (str.find('Daas13'))!=-1:

                temp=str.find('Daas13')
                placeholder=str[temp:(temp+6)]
                name=placeholder

        elif (str.find('Daas14'))!=-1:

                temp=str.find('Daas14')
                placeholder=str[temp:(temp+6)]
                name=placeholder

        elif (str.find('Daas15'))!=-1:

                temp=str.find('Daas15')
                placeholder=str[temp:(temp+6)]
                name=placeholder

        elif (str.find('Daas16'))!=-1:

                temp=str.find('Daas16')
                placeholder=str[temp:(temp+6)]
                name=placeholder

        elif (str.find('Daas17'))!=-1:

                temp=str.find('Daas17')
                placeholder=str[temp:(temp+6)]
                name=placeholder

        elif (str.find('Daas18'))!=-1:

                temp=str.find('Daas18')
                placeholder=str[temp:(temp+6)]
                name=placeholder

        elif (str.find('Daas19'))!=-1:

                temp=str.find('Daas19')
                placeholder=str[temp:(temp+6)]
                name=placeholder
            
        elif (str.find('ReversalDaas1'))!=-1:

                temp=str.find('ReversalDaas1')
                placeholder=str[temp:(temp+13)]
                name=placeholder

        else:

                temp=str.find('Daas1')
                placeholder=str[temp:(temp+5)]
                name=placeholder

    elif str.find('Daas2')!=-1:

        if str.find('Daas20')!=-1:

                temp=str.find('Daas20')
                placeholder=str[temp:(temp+6)]
                name=placeholder

        elif str.find('ReversalDaas2')!=-1:

                temp=str.find('ReversalDaas2')
                placeholder=str[temp:(temp+13)]
                name=placeholder

        else:
                temp=str.find('Daas2')
                placeholder=str[temp:(temp+5)]
                name=placeholder

    elif str.find('Daas3')!=-1:

        if str.find('ReversalDaas3')!=-1:

                temp=str.find('ReversalDaas3')
                placeholder=str[temp:(temp+13)]
                name=placeholder

        else:

                temp=str.find('Daas3')
                placeholder=str[temp:(temp+5)]
                name=placeholder

    elif str.find('Daas4')!=-1:

        if str.find('ReversalDaas4')!=-1:

                temp=str.find('ReversalDaas4')
                placeholder=str[temp:(temp+13)]
                name=placeholder
                
        else:

                temp=str.find('Daas4')
                placeholder=str[temp:(temp+5)]
                name=placeholder

    elif str.find('Daas5')!=-1:

        if str.find('ReversalDaas5')!=-1:

                temp=str.find('ReversalDaas5')
                placeholder=str[temp:(temp+13)]
                name=placeholder
                
        else:

                temp=str.find('Daas5')
                placeholder=str[temp:(temp+5)]
                name=placeholder

    elif str.find('Daas6')!=-1:

        if str.find('ReversalDaas6')!=-1:

                temp=str.find('ReversalDaas6')
                placeholder=str[temp:(temp+13)]
                name=placeholder
                
        else:

                temp=str.find('Daas6')
                placeholder=str[temp:(temp+5)]
                name=placeholder

    elif str.find('Daas7')!=-1:
            
            temp=str.find('Daas7')
            placeholder=str[temp:(temp+5)]
            name=placeholder

    elif str.find('Daas8')!=-1:
            
            temp=str.find('Daas8')
            placeholder=str[temp:(temp+5)]
            name=placeholder

    elif str.find('Daas9')!=-1:
            
            temp=str.find('Daas9')
            placeholder=str[temp:(temp+5)]
            name=placeholder

    elif str.find('Daas10')!=-1:
            
            temp=str.find('Daas10')
            placeholder=str[temp:(temp+5)]
            name=placeholder

    else:
            name='NaN'

    return name


#TEST
"""      
#retrievePath for stat.npy and ops.npy for given mouse

mouseName=input("Please provide the name of a mouse")

#print("Retrieve stat.npy and ops.npy path arrays.")

(path1,path2)=func3.retrievePath(mouseName)

trueName=[]

for i in range(0,len(path1)):

    road=path1[i]
    temp=identification(road)
    trueName.append(temp)

for i in range(0,len(path1)):
    print('')
    print('Index '+str(i))
    print(trueName[i])
    print('')
 
 """
