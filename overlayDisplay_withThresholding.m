function[]=overlayDisplay_withThresholding(images,struct,data,num)
%{
Function Specifications:
This function displays the most and least similar ROI pairings for a single
ROI from Session 1 alongside a control pairing. This control pairing is
selected by the user and compares an ROI from session 1 with an user selected
ROI from a previously selected session. The best and worst pairings are
found by looking through the ROI combinations within a specific session
table in struct and finding the values that exhibit the most and least
similarity. The three figures are displayed with their associated distance,
jaccard index, correlation coefficent value, and thesholding checkmarks.

INPUT:
images: The collection of cropped out images for each Daas. These cropped
images are standardized black and white pictures of each region of
interest.

struct: The table of structures which consist of all the ROI pairing
combinations for a single ROI in Session 1.

data: The structure containing all relevant data calculated up until this
point. This contains the quantitative and probablistic analysis results 
for every ROI pairing for every ROI in session 1.

num: Shows which ROI was initially selected by the user from session 1.

OUTPUT: NaN

%}

%Select that Daas and ROI that you want to set as a control
in=input("Select a Session other than Daas1\n");
choice=cast(in,"uint8");
fprintf("Choose an ROI in the selected Daas\n");
result=roiSelection(data,choice);

daas='Daas';
s=num2str(choice);
field=strcat(daas,s);
 
%Select the data for that Daas ROI pairing along with the image of the ROI
tableDist=struct.(field).dist_allROI;
tableJaccard=struct.(field).jaccard_allROI;
tableCorr=struct.(field).corr_allROI;
table_withinTresh_Dist=struct.(field).withinTresh_Dist;
table_withinTresh_Jaccard=struct.(field).withinTresh_Jaccard;
table_withinTresh_Correlation=struct.(field).withinTresh_Correlation;

result_tableDist=tableDist(result);
result_tableJaccard=tableJaccard(result);
result_tableCorr=tableCorr(result);
result_treshDist=table_withinTresh_Dist(result);
result_treshJaccard=table_withinTresh_Jaccard(result);
result_treshCorr=table_withinTresh_Correlation(result);
img2=images(choice,result).window;

%Prep for overlay
img1=cast(images(1,num).window,"uint8");
mask= img1~=0;
img1(mask)=255;
img2=cast(img2,"uint8");
rgbImage=labeloverlay(img1,img2);

%Find the ROI pairing that is the most similar (checks off both Jaccard and Correlation Thresholds)
maxIndex_Similar=mostSimilar(struct,choice);

%Collect the data corresponding to the similar pairing

result_tableDist1=tableDist(maxIndex_Similar);
result_tableJaccard1=tableJaccard(maxIndex_Similar);
result_tableCorr1=tableCorr(maxIndex_Similar);
result_treshDist1=table_withinTresh_Dist(maxIndex_Similar);
result_treshJaccard1=table_withinTresh_Jaccard(maxIndex_Similar);
result_treshCorr1=table_withinTresh_Correlation(maxIndex_Similar);

temp=images(choice,maxIndex_Similar).window;
resultImage1=labeloverlay(img1,temp);

%Find the ROI pairing that is the most disimilar (doesn't check off both Jaccard
%and Correlation Thresholds)

minIndex_Disimilar=mostDisimilar(struct,choice);

%Collect the data corresponding to the disimilar pairing

result_tableDist2=tableDist(minIndex_Disimilar);
result_tableJaccard2=tableJaccard(minIndex_Disimilar);
result_tableCorr2=tableCorr(minIndex_Disimilar);
result_treshDist2=table_withinTresh_Dist(minIndex_Disimilar);
result_treshJaccard2=table_withinTresh_Jaccard(minIndex_Disimilar);
result_treshCorr2=table_withinTresh_Correlation(minIndex_Disimilar);

temp=images(choice,minIndex_Disimilar).window;
resultImage2=labeloverlay(img1,temp);


tiledlayout(1,3)
%Display Overlay of ROI of Daas1 with known control ROI from Selected Daas
nexttile

imshow(rgbImage,'InitialMagnification',800)

String0='ROI Overlay Control';

formatSpec='Distance = %d';
A1=result_tableDist;
StringA=sprintf(formatSpec,A1);

formatSpec='Jaccard = %d';
A2=result_tableJaccard;
StringB=sprintf(formatSpec,A2);

formatSpec='Correlation = %d';
A3=result_tableCorr;
StringC=sprintf(formatSpec,A3);

formatSpec='Within Dist Threshold = %d';
A4=result_treshDist;
StringD=sprintf(formatSpec,A4);

formatSpec='Within Jaccard Threshold = %d';
A5=result_treshJaccard;
StringE=sprintf(formatSpec,A5);

formatSpec='Within Correlation Threshold = %d';
A6=result_treshCorr;
StringF=sprintf(formatSpec,A6);

title({String0,StringA,StringB,StringC,StringD,StringE,StringF})

%Display Overlay of ROI of Daas1 with known ROI that is most similar
%(checks off Jaccard and Correlation Thresholds)
nexttile

imshow(resultImage1,'InitialMagnification',800)

String0='ROI Overlay Similar';

formatSpec='Distance = %d';
A1=result_tableDist1;
StringA=sprintf(formatSpec,A1);

formatSpec='Jaccard = %d';
A2=result_tableJaccard1;
StringB=sprintf(formatSpec,A2);

formatSpec='Correlation = %d';
A3=result_tableCorr1;
StringC=sprintf(formatSpec,A3);

formatSpec='Within Dist Threshold = %d';
A4=result_treshDist1;
StringD=sprintf(formatSpec,A4);

formatSpec='Within Jaccard Threshold = %d';
A5=result_treshJaccard1;
StringE=sprintf(formatSpec,A5);

formatSpec='Within Correlation Threshold = %d';
A6=result_treshCorr1;
StringF=sprintf(formatSpec,A6);

title({String0,StringA,StringB,StringC,StringD,StringE,StringF})

%Displays Overalay of ROI of Daas1 with known ROI of separate Daas that is
%most disimlar (does not check of Jaccard or Correlation Thresholds)
nexttile

imshow(resultImage2,'InitialMagnification',800)

String0='ROI Overlay Disimilar';

formatSpec='Distance = %d';
A1=result_tableDist2;
StringA=sprintf(formatSpec,A1);

formatSpec='Jaccard = %d';
A2=result_tableJaccard2;
StringB=sprintf(formatSpec,A2);

formatSpec='Correlation = %d';
A3=result_tableCorr2;
StringC=sprintf(formatSpec,A3);

formatSpec='Within Dist Threshold = %d';
A4=result_treshDist2;
StringD=sprintf(formatSpec,A4);

formatSpec='Within Jaccard Threshold = %d';
A5=result_treshJaccard2;
StringE=sprintf(formatSpec,A5);

formatSpec='Within Correlation Threshold = %d';
A6=result_treshCorr2;
StringF=sprintf(formatSpec,A6);

title({String0,StringA,StringB,StringC,StringD,StringE,StringF})

end
