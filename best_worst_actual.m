function[struct]=best_worst_actual(struct,dimension,image,data,num,refNum,revamped_sessions)
%{
Specifications:
This function should take the ROI structure of tables received from
roi_accross_day as an input and output the best and worst ROI pairing for
each Daas in terms of either distance or similarity. One should also have
the option to display an ROI that the user suspects to be the same ROI
accross sessions.

INPUT:
struct: The table of structures which consist of all the ROI pairing
combinations for a single ROI in Session 1.

dimension: The number of layers within the multidimensional image matrix.

image: The collection of cropped out images for each Daas. These cropped
images are standardized black and white pictures of each region of
interest.

data: The structure containing all relevant data calculated up until this
point.  This contains the quantitative and probablistic analysis results 
for every ROI pairing for every ROI in session 1.

num: Shows which ROI was initially selected by the user from session 1.

OUTPUT:
struct: A structure full of tables, whereby each field of the table contains
the pairing combinations for a single ROI from session 1 with every other
ROI of every other session. Three additional fields are attached to every
table. These three fields display whether a pairing meets the threshold
requirements set by the user for Distance, Jaccard Index, and Correlation 
Coefficent values. If results are within desirable thresholds then an value
of 1 will be displayed next to a pairing. Otherwise, a value of 0 will be 
displayed. 

%}

%This are the initial thresholds for the distance, jaccard index, and
%correlation. If you want to adjust these values you can.

fprintf("Default Thresholds\n")
fprintf("thresholdDist=20\n")
fprintf("thresholdJaccard=0.5\n")
fprintf("thresholdCorr=0.2\n")

res=input("Do you want to use the default thresholds? If yes press 1, otherwise press 2...\n");
yn=cast(res,"uint8");

if yn==1
    thresholdDist=20;
    thresholdJaccard=0.4;
    thresholdCorr=0.4;
elseif yn==2
    thresholdDist=input("Please input a new value for the distance threshold...\n");
    thresholdDist=cast(thresholdDist,"double");
    thresholdJaccard=input("Please input a new value for the jaccard index threshold...\n");
    thresholdJaccard=cast(thresholdJaccard,"double");
    thresholdCorr=input("Please input a new value for the correlation threshold...\n");
    thresholdCorr=cast(thresholdCorr,"double");
else
    fprintf("An ERROR HAS OCCURED: IMPROPER USER INPUT GIVEN\n");
    return;   
end

%{
%Select that the Daas for which comparison analysis will be done.
daasNum=daasSelection(dimension);
%}

%If reference image is from Session 1 execute the code below
if refNum==1
    %Create a field in all struct tables that show whether ROI is within
    %threshold values.
    
    for i=2:dimension
        
        daas='Daas';
        s=num2str(i);
        field=strcat(daas,s);
    
        tableDist=struct.(field).dist_allROI;
        tableJaccard=struct.(field).jaccard_allROI;
        tableCorr=struct.(field).corr_allROI;
        
        struct.(field).withinTresh_Dist=tableDist<=thresholdDist;
        struct.(field).withinTresh_Jaccard=tableJaccard>=thresholdJaccard;
        struct.(field).withinTresh_Correlation=tableCorr>=thresholdCorr;
    
    end
    
    %Find ROIs pairing that are the most similar and most disimilar.
    %Display along with control session.
    
    res=input("Do you want to display the most similar and dismilar ROI overlay choices? Press one for yes and two for no...\n");
    yn=cast(res,"uint8");
    
    if yn==1
        overlayDisplay_withThresholding(image,struct,data,num,refNum,revamped_sessions);
    end

%If reference image is not from Session 1 execute the code below
else

    %Create a field in all struct tables that show whether ROI is within
    %threshold values.
    
    for i=1:length(revamped_sessions)
        temp=revamped_sessions(i);
        daas='Daas';
        s=num2str(temp);
        field=strcat(daas,s);
    
        tableDist=struct.(field).dist_allROI;
        tableJaccard=struct.(field).jaccard_allROI;
        tableCorr=struct.(field).corr_allROI;
        
        struct.(field).withinTresh_Dist=tableDist<=thresholdDist;
        struct.(field).withinTresh_Jaccard=tableJaccard>=thresholdJaccard;
        struct.(field).withinTresh_Correlation=tableCorr>=thresholdCorr;
    
    end
    
    %Find ROIs pairing that are the most similar and most disimilar.
    %Display along with control session.
    
    res=input("Do you want to display the most similar and dismilar ROI overlay choices? Press one for yes and two for no...\n");
    yn=cast(res,"uint8");
    
    if yn==1
        overlayDisplay_withThresholding(image,struct,data,num,refNum,revamped_sessions);
    end

end

end
