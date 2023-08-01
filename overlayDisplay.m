function[]=overlayDisplay(images,data)
%{
Function Specifications:

INPUT:
images: The collection of cropped out images for each Daas. These cropped
images are standardized black and white pictures of each region of
interest.

data: The structure containing all relevant data calculated up until this
point. This contains the quantitative and probablistic analysis results 
for every ROI pairing for every ROI in session 1.


OUTPUT: NaN

%}

%Choose which mask in Daas1 you want to use for comparison
in=input("Please select a mask in Daas 1...\n");

in_1=cast(in,"uint8");

%Choose which Daas to use in comparison

in=input("Please select a Daas other than Daas1...\n");

in_2=cast(in,"uint8");

%Choose which mask in the selected Daas to use in comparison

in=input("Please select a mask from the selected Daas...\n");

in_3=cast(in,"uint8");

%Used to visualize overlay between masks and display distance and
%similarity values.

img1=cast(images(1,in_1).window,"uint8");
mask= img1~=0;
img1(mask)=255;
img2=cast(images(in_2,in_3).window,"uint8");
rgbImage=labeloverlay(img1,img2);
%jljljljljl
figure
imshow(rgbImage,'InitialMagnification',800)

formatSpec='Distance = %d';
%Distances between Daas1 and Daas5 centroids array
distArray=data(in_2).Distance;
%Distance between Daas1 centroid 1 and Daas5 centroid 2
A1=distArray(in_1,in_3);
StringA=sprintf(formatSpec,A1);

formatSpec='Jaccard = %d';
%Jaccard Similarity Index between Daas1 - centroid 1 and Daas5 centroid 2
A2=data(in_2).Similarity(in_1,in_3).Jaccard;
StringB=sprintf(formatSpec,A2);

formatSpec='Correlation = %d';
%Simple 2d correlation between Daas1 - centroid 1 and Daas 5 centroid 2
A3=data(in_2).Similarity(in_1,in_3).Correlation;
StringC=sprintf(formatSpec,A3);

title({StringA,StringB,StringC})

end
