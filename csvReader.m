function[data,bank,box,rock,images,roiPick]=csvReader()

%{
DESCRIPTION: This function is the main branch of an alogrithm that does
probabilistic analysis of neurons across 2p sessions. It calculates the
distance, jaccard index, and 2d-correlation between each ROI of session 1 
with all the ROIs of every other session. One also has the option to
display a black and white image of a session with associated centroids
within range. An option is also available to look view an overlap between
two cropped images along with the two masks' combined distance, jaccard
index, and 2d-correlation value.

NECESSARY FUNCTIONS AND LIBRARIES:

centroidDistance.m
show_ROILayer.m
similarityAnalysis.m
overlayDisplay.m
ImageProcessing Toolbox

INPUTS: User will select the folder with all csv files containing session 
        data from the directory.
OUTPUTS: 
        data: The primary structure containing all relevant data including
        ROI centroid data (Centroids), ROI similarity data (Similarity), 
        ,ROI distance data (Distance), and the image data for each session 
        (LayerROIData). The cell of each distance and similarity matrix 
        contains the similarity data between a mask of Daas1 and a mask of 
        Daas x. The row number of the matrix tells you which mask is being 
        considered in Daas1 and the column number tells you which mask is 
        considered in Daas x.

        bank: This is the output of centroidDistance. Will contain distance
        data and centroid data. 

        box: This is the output of similarityAnalysis. This will contain
        the similarity data (Jaccard and 2d-Correlation) for every ROI of
        every session. The data will manifest as a matrices of structures.
        The cell of each similarity matrix contains the similarity data
        between a mask of Daas1 and a mask of Daas x. The row number of the
        matrix tells you which mask is being considered in Daas1 and the
        column number tells you which mask is considered in Daas x.

        rock: This is a diagostic variable. It tells you if the similarity
        analysis function could not fully crop out a mask within a session.

        images:This contains the cropped out images of each mask of a
        session. Every cropped out mask is 10x10 pixels. The center of the
        cropped out image is the centroid for the mask. NOTE: Neurons are
        cropped out selectively. To be specific, if a centroid is found
        that is between the following coordinates then image cropping can
        be done: 11<xpixel<numRows-11 and 11<ypixel<numCols-11 (numRows and
        numCols are the dimensions of the session image). This is done to
        avoid improperly cropped images getting in the way of similarity
        analysis. 

%}

%Retrieves the csv folder datapath

fprintf('Please give me the folder containing all csv files...\n');

path=uigetdir;

if isequal(path,0)
    disp('User selected Cancel')
    return
else
    disp(['User selected ',path]);
    folderPath=path;
end

%Reads information about csv data in csv folder

p=dir([folderPath '/*.csv']);

%Create an array of csv filenames

for k=1:length(p)

    filename=[folderPath '/' p(k).name];

end

%Create a string array which will contain the csv data paths

csvPaths=strings(length(p),1);

for w=1:length(p)
    csvPaths(w)=strcat(p(w).folder,'/',p(w).name);
end

%Use readtable in order to import ROI data into a matrix

for w=1:length(p)

    T=readtable(csvPaths(w));
    T_mat=table2array(T);
    matrix(:,:,w)=T_mat;

end

%This function will store the file names for each layer of the matrix

dimension=length(p);
layers=string(dimension);

for w=1:length(p)

    layers(w)=p(w).name;

end

%This will convert the string filenames in the layers array to character
%arrays. These character arrays are then used to identify how to reorder
%the layers list as to have Daas numbers in increasing order.

daasList=zeros(1,length(p));

for i=1:dimension

    charArray=convertStringsToChars(layers(i));

    %For Daas1-Daas20
    if charArray(7)=='D'
        
        %For Daas1-Daas9
        if (charArray(12)=='.')

            daasNum=charArray(11);
            daasNum=str2num(daasNum);
            daasList(i)=daasNum;
        
        %For Daas10-Daas20
        else

            daasNum1=charArray(11);
            daasNum2=charArray(12);
            daasNum=append(daasNum1,daasNum2);
            daasNum=str2num(daasNum);
            daasList(i)=daasNum;

        end

    %For ReversalDaas1-ReversalDaas6
    else
            daasNum=charArray(19);
            daasNum=str2num(daasNum);
            daasList(i)=daasNum+50;

    end

end

%Sorts the layers array as to match the increasing Daas number ordering.
%Also sorts the matrix array to compliment this change.
[daasList_sorted,I]=sort(daasList);
layers_sorted=layers(I);
matrixNew=matrix(:,:,I);

%Threshold the image
%matrixNew=matrixNew>50;

%Creates binary image 3d matrix
matrixNew=imbinarize(matrixNew);

%We can see some circles not completely filled.
%Use imfill function to fill these holes.

l=size(matrixNew,3);
for i=1:l
    matrixNew(:,:,i)=imfill(matrixNew(:,:,i),'holes');
end

%matrixNew=imfill(matrixNew,'holes');

%Removes small objects from binary image that have fewer than 3 pixels

matrixNew=bwareaopen(matrixNew,3);

[xdim,ydim,zdim]=size(matrixNew);

%Create a structure with all relevant data ordered
%{

%}
field1='LayerIdentification';
field2='LayerROIData';
field3='Distance';
field4='Similarity';
field5='Centroids';
field6='BoundingBox';
field7='oldCentroids';

data=struct(field1,{},field2,{},field3,{},field4,{},field5,{},field6,{},field7,{});


for i=1:dimension

    data(i).LayerIdentification=layers_sorted(i);
    data(i).LayerROIData=matrixNew(:,:,i);
    data(i).Similarity=0;
    

end

bank=centroidDistance(data,dimension,xdim,ydim);

for i=1:dimension
    data(i).oldCentroids=bank(i).centroids;
    data(i).Centroids=bank(i).correctCentroids;
    data(i).BoundingBox=bank(i).boundingBox;
end

for i=2:dimension
    data(i).Distance=bank(i).distance;
end

%Find max and min values of length and width of bounding box and figure out
%thresholding.This will be fed into similarity analysis will be used to
%calc the dimensions of the evaluation window. Multipy max and min by 2.

[box,images,tf]=similarityAnalysis(data,dimension);

for i=2:dimension

    [row,column]=size(data(i).Distance);
    data(i).Similarity=box(:,1:column,i);

end

%Used to display a Daas with centroids labeled

in=input("Do you want to display a Daas image with centroids labeled? 1=Yes and 2=No ...\n");
yn=cast(in,"uint8");
if yn==1
show_ROILayer(data);
end

%Used to visualize overlay between masks and display distance and
%similarity values.

in=input("Do you want to display an overlay of two masks? 1=Yes and 2=No ...\n");
yn=cast(in,"uint8");
if yn==1
overlayDisplay(images,data);
end

%Shows which masks comparisons are viable

for i=2:dimension

    if any(tf(:,:,i),"all")
        rock(i)=1;
    else
        rock(i)=0;
    end

end

%{
Pick an roi from Daas one and collect all the combinations of similarity
and distance calculations for all the sessions. This will output a
structure contains data tables. The structure will have 2:(number of
session) tables.
%}

[roiPick,numpy]=roi_accross_day(data,dimension);

%Creepy image of me pops up when best_worst_actual initiated
roiPick=best_worst_actual(roiPick,dimension,images,data,numpy);

%{

imshow(images(1,52).window)
title('Daas1 ROI1');
figure, imshow(images(1,47).window)
title('Daas1 ROI2');
figure, imshow(images(1,67).window)
title('Daas1 ROI3');
figure, imshow(images(1,91).window)
title('Daas1 ROI4');
figure, imshow(images(1,44).window)
title('Daas1 ROI5');
figure, imshow(images(1,46).window)
title('Daas1 ROI6');

figure, imshow(images(5,46).window)
title('Daas5 ROI1');
figure, imshow(images(5,41).window)
title('Daas5 ROI2');
figure, imshow(images(5,65).window)
title('Daas5 ROI3');
figure, imshow(images(5,83).window)
title('Daas5 ROI4')
figure, imshow(images(5,40).window)
title('Daas5 ROI5')
figure, imshow(images(5,36).window)
title('Daas5 ROI6')

%}

end