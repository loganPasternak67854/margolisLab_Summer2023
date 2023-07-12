function[box,images,tf,jump,crouch]=similarityAnalysis(data,dimension)
%{
Problem Specification:

Determine a method for aligning the centers of all masks to a common origin
or center point. Once the centers are aligned, conduct a correlation 
analysis or calculate the Jaccard similarity index to assess the degree of 
similarity between the masks.

Idea:
1) Identify the centroids of two ROIs

2) Determine an appropriate window where the center of the image is also
the centroid of an ROI. There will be two BW 2d matrices. Maybe use
regionprops(image,'BoundingBox') then use max of width and height? What
happens if centroid is close to an edge. 

3) Use corr2 or jaccard on the two matrices to determine the similarity
between the two images. 
%}

%Standard window around centroid is 10 by 10 pixels
size_of_cropped_img=9;


%Retrieve the cropped images from the bounding boxes for all the Daas'


field1='Jaccard';
field2='Correlation';

box=struct(field1,{},field2,{});

field1='window';
images=struct(field1,{});

%PROBLEM: Some of the windows are not the standard size because centroid is
%near the edge. What do I do about edges? Add zeros around matrix or tell
%program that if two matrices do not have the same dimensions then skip.
%link: https://www.mathworks.com/matlabcentral/answers/368551-how-to-add-zeros-around-a-matrix

for i=1:dimension

    temp=data(i).Centroids;
    image=data(i).LayerROIData;

    for j=1:length(temp(:,1))
      
        %Get the centroids for each daas
        centroidLIST=data(i).Centroids;
        centroid_X=centroidLIST(j,1);
        centroid_Y=centroidLIST(j,2);

        %Retreive the cropped images
        xmin=centroid_X-(size_of_cropped_img/2);
        ymin=centroid_Y-(size_of_cropped_img/2);
        images(i,j).window=imcrop(image,[xmin,ymin,size_of_cropped_img,size_of_cropped_img]);

    end

end


[rows,cols]=size(data(1).Centroids);

%Do Jaccard and normxcorr2 on the cropped images

%Number of centroids in Daas1
for i=1:rows
    
    %Loops from Daas2-last Daas
    for j=2:dimension
        
        %Retrieves the BoundingBox data for Daas#j
        temp=data(j).Centroids;
        
        %Loops through all the centroids of Daas#j
        for k=1:length(temp(:,1))
            
            %Determines the dimensions of images that will be compared
            [numRows1,numCols1]=size(images(1,i).window);
            [numRows2,numCols2]=size(images(j,k).window);
           
            %If the dimensions for one image are not the same then
            %similarity analysis can not be done. ROI at corner!
            if (numRows1~=numRows2)||(numCols1~=numCols2)
            
                box(i,k,j).Jaccard=NaN;
                box(i,k,j).Correlation=NaN;

            else
                
                box(i,k,j).Jaccard=jaccard(images(1,i).window,images(j,k).window);
                box(i,k,j).Correlation=corr2(images(1,i).window,images(j,k).window);
                
                %{
                temp=normxcorr2(images(1,i).window,images(j,k).window);
                box(i,k,j).Correlation=max(temp(:));
                %}

            end

            tf(i,k,j)=isnan(box(i,k,j).Correlation);

        end

    end

end


end
