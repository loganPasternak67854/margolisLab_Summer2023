function[container,revamped_sessions]=centroidDistance(structure,numLayers,xdim,ydim,refNum)
%{
DESCIRPTION: Calculate the distances between all masks of each session. This involves
comparing the center coordinates (x1,y1) of each Region of Interest(ROI) in
Daas1 with all ROIs(x2,y2) of subsequent days. To acheive this, utilize the
formula d=sqrt((x2-x1)^2+(y2-y1)^2). In MATLAB, you can employ the function
nchoosek to obtain all possible combinations for comparing the mask's ROIs.

INPUT: 
structure: a structure which contains the image matrix which will will need
for distance analysis.
numLayers: this is the number of layers in the image matrix
xdim:
ydim:
refSession: The session chosen by the user as the reference session for
distance and similarity calculation.

OUTPUT:
container: a structure that will contain the centroid locations for each
Daas as well as a distance matrix which will show the distance between
a centroid in Daas1 with a centroid in any other Daas.
%}

%Create a structure with all relevant data ordered 
field1='centroids';
field2='distance';
field3='boundingBox';
field4='correctCentroids';
container=struct(field1,{},field2,{},field3,{},field4,{});

for i=1:numLayers

    image=structure(i).LayerROIData;
    s=regionprops(image,'centroid','BoundingBox');
    centroidArray=cat(1,s.Centroid);
    container(i).centroids=centroidArray;
    boundingArray=cat(1,s.BoundingBox);
    container(i).boundingBox=boundingArray;

end

%Find all the centroids that are in range 15:xdim/ydim-15 and store in
%struct

field1='centroid_coordArray';
centBox=struct(field1,{});

for i=1:numLayers
    image=container(i).centroids;
    [numRows,numCols]=size(image);
    forum=zeros(numRows,2);
    for j=1:numRows
        
        if (30<image(j,1)) && (image(j,1)<(ydim-30)) && (30<image(j,2)) && (image(j,2)<(xdim-30))
            forum(j,1)=image(j,1);
            forum(j,2)=image(j,2);
        else       
            forum(j,1)=NaN;
            forum(j,2)=NaN;
        end

    end
    centBox(i).centroid_coordArray=forum;
end

%{
for i=1:numLayers

    container(i).inRange=centBox(i).centroid_coordArray;

end
%}

%Remove NaNs from centroid lists

for i=1:numLayers
    image=container(i).centroids;
    [numRows,numCols]=size(image);
    centroidFull=[];
    for j=1:numRows

        temp=centBox(i).centroid_coordArray;
        if ~isnan(temp(j,1)) && isempty(centroidFull)
            centroidFull=[temp(j,1),temp(j,2)];
        elseif ~isnan(temp(j,1))
            coord=[temp(j,1),temp(j,2)];
            centroidFull=[centroidFull;coord];
        end
            
    end
    centBox(i).centroid_coordArray=centroidFull;
end

for i=1:numLayers
    container(i).correctCentroids=centBox(i).centroid_coordArray;
end

%If Session1 is chosen as the reference image
if (refNum==1)
    %{
    Loop through the points of Daas1 then loop through the Daas layers then
    loop through the points in that layer to determine the distance between
    centroids in Daas1 with other Daas'.
    %}
    
    [rows,cols]=size(container(1).correctCentroids);
    
    for i=1:rows
        for j=2:numLayers
            [numPoint2,pass]=size(container(j).correctCentroids);
            for k=1:numPoint2
                
                %Coordinate of a centroid in Daas1
                base1=container(1).correctCentroids;
                x1=base1(i,1);
                y1=base1(i,2);
                
                %Coordinate of a centroid in every other Daas
                base2=container(j).correctCentroids;
                x2=base2(k,1);
                y2=base2(k,2);
    
                %This is the distance between point i and point k in  their
                %respective planes. Row=Daas1 and Column=AltDaas
                distance=distanceBetween(x1,y1,x2,y2);
                temp(i,k,j)=distance;
            end
        end
    end
    
    %Stores distance values into container structure
    %Find a way to get rid of the unnecessary zeros in each distance struct
    
    for j=2:numLayers
        standard=temp(:,:,j);
        container(j).distance=standard;
        container(j).distance(:,all(~container(j).distance,1))=[];
        container(j).distance((rows+1):end,:)=[];
    end

    revamped_sessions=0;

%If any other session is chosen as the reference image
else 

    %{
    Loop through the points of selected Daas then loop through the Daas layers then
    loop through the points in that layer to determine the distance between
    centroids in selected Daas with other Daas'.
    %}
    [rows,cols]=size(container(refNum).correctCentroids);
    sessions=1:numLayers;
    revamped_sessions=setdiff(sessions,refNum);

    for i=1:rows
        for j=1:length(revamped_sessions)
            [numPoint2,pass]=size(container(revamped_sessions(j)).correctCentroids);
            for k=1:numPoint2
                
                %Coordinate of a centroid in Daas1
                base1=container(refNum).correctCentroids;
                x1=base1(i,1);
                y1=base1(i,2);
                
                %Coordinate of a centroid in every other Daas
                base2=container(revamped_sessions(j)).correctCentroids;
                x2=base2(k,1);
                y2=base2(k,2);
    
                %This is the distance between point i and point k in  their
                %respective planes. Row=Daas1 and Column=AltDaas
                distance=distanceBetween(x1,y1,x2,y2);
                temp(i,k,revamped_sessions(j))=distance;
            end
        end
    end

    %Stores distance values into container structure
    %Find a way to get rid of the unnecessary zeros in each distance struct
    
    for j=1:length(revamped_sessions)
        q=revamped_sessions(j);
        standard=temp(:,:,q);
        container(q).distance=standard;
        %container(q).distance(:,all(~container(q).distance,1))=[];
        container(q).distance(:,all(container(q).distance==0))=[];
        container(q).distance((rows+1):end,:)=[];
    end

end

end
