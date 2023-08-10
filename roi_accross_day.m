function[struct,numpy]=roi_accross_day(data,dimension,refNum,revamped_sessions)
%{
Specifications:
1. Pick one cell from all FOVs 
2. Generate all combinations of data across all sessions for that one cell
3. Display best best choice ROI, similar ROI, and disimilar ROI

Similar ROI either shape or distance 
Dismilar ROI differ in shape or distance 
Thresholds for what is similar or dismilar (Subjective)

Conditions for Same Neuron 
{
Border: no
Distance: <threshold
jaccard: high similarity
correlation: high similarity
}

INPUT:
data: The collection of data collected up until this points. This contains
the quantitative and probablistic analysis results for every ROI pairing
for every ROI in session 1.

dimension:The number of layers which comprimise the multidimension 3d-image
matrix.

OUTPUT:
struct:A structure full of tables, whereby each field of the table contains
the pairing combinations for a single ROI from session 1 with every other
ROI of every other session.

numpy:Shows which ROI was selected by the user in session 1.

%}

%RESULT WILL BE A DOUBLE

%Select an ROI from Daas1. The data for this ROI will be tracked across
%multiple days.
result=roiSelection(data,refNum);

%If Reference image from which ROI is being selected is from Session 1
%execute the following code 

if refNum==1
    for i=2:dimension
        
        daas='Daas';
        s=num2str(i);
        field=strcat(daas,s);
        %struct.(field)=NaN;
    
        distArray=data(i).Distance;
        dist_allROI=transpose(distArray(result,:));
    
        simArray=data(i).Similarity;
        sim_allROI=transpose(simArray(result,:));
        
        l=length(sim_allROI);
        jaccard_allROI=zeros(l,1);
        corr_allROI=zeros(l,1);
    
        for j=1:length(sim_allROI)
    
            jaccard_allROI(j)=sim_allROI(j).Jaccard;
            corr_allROI(j)=sim_allROI(j).Correlation;
    
        end
    
        struct.(field)=table(dist_allROI,jaccard_allROI,corr_allROI);
        
    end
    
    numpy=result;

%If Reference image from which ROI is being selected is not from Session 1
%execute the following code
else
    
    for i=1:length(revamped_sessions)
        temp=revamped_sessions(i);
        daas='Daas';
        s=num2str(temp);
        field=strcat(daas,s);
        %struct.(field)=NaN;
    
        distArray=data(temp).Distance;
        dist_allROI=transpose(distArray(result,:));
    
        simArray=data(temp).Similarity;
        sim_allROI=transpose(simArray(result,:));
        
        l=length(sim_allROI);
        jaccard_allROI=zeros(l,1);
        corr_allROI=zeros(l,1);
    
        for j=1:l
    
            jaccard_allROI(j)=sim_allROI(j).Jaccard;
            corr_allROI(j)=sim_allROI(j).Correlation;
    
        end
    
        struct.(field)=table(dist_allROI,jaccard_allROI,corr_allROI);
        
    end
    
    numpy=result;


end

end
