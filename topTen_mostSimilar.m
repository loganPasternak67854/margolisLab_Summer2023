function[topTen]=topTen_mostSimilar(structure,dimension)
%{
Specifications:
This function should sift through the ROI selection structure of tables for
the 10 ROI pairings that exhibit the highest similarity values and compile
them into a list.

INPUT:
struct: The table of structures which consist of all the ROI pairing
combinations for a single ROI in Session 1.

choice: The session selected by the user Data will be collected from.

OUTPUT: 
topTen: A list of 10 ROI pairings that exhibit high similarity scaling.
%}

topTen=struct;

for i=2:dimension

    %Collects the data for a single table/session
    daas='Daas';
    s=num2str(i);
    field=strcat(daas,s);
    
    
    tableDist=structure.(field).dist_allROI;
    tableJaccard=structure.(field).jaccard_allROI;
    tableCorr=structure.(field).corr_allROI;
    tableDist_tf=structure.(field).withinTresh_Dist;
    tableJaccard_tf=structure.(field).withinTresh_Jaccard;
    tableCorr_tf=structure.(field).withinTresh_Correlation;
    
    %Finds the locations of the top ten most similar ROI pairs. 
    simAdd=tableJaccard+tableCorr;
    
    [vals,locations]=maxk(simAdd,10);
    
    %Find the data values that correspond to the top ten most similar ROI pairs
    %and store them into separate lists.
    
    Dist=zeros(length(locations),1);
    Jaccard=zeros(length(locations),1);
    Corr=zeros(length(locations),1);
    Dist_TF=zeros(length(locations),1);
    Jaccard_TF=zeros(length(locations),1);
    Corr_TF=zeros(length(locations),1);
    roi_NUM=zeros(length(locations),1);
    
    for j=1:length(locations)
    
        Dist(j)=tableDist(locations(j));
        Jaccard(j)=tableJaccard(locations(j));
        Corr(j)=tableCorr(locations(j));
        Dist_TF(j)=tableDist_tf(locations(j));
        Jaccard_TF(j)=tableJaccard_tf(locations(j));
        Corr_TF(j)=tableCorr_tf(locations(j));
        roi_NUM(j)=locations(j);
    
    end
    
    %Creates struct of tables where the data for the top ten best pairings are stored
    
    topTen.(field)=table(Dist,Jaccard,Corr,Dist_TF,Jaccard_TF,Corr_TF,roi_NUM);
    

end

end
