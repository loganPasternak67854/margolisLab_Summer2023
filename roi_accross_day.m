function[struct,numpy]=roi_accross_day(data,dimension)
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

%}

%RESULT WILL BE A DOUBLE
result=roiSelection(data,1);

for i=2:dimension
    
    daas='Daas';
    s=num2str(i);
    field=strcat(daas,s);
    %struct.(field)=NaN;

    distArray=data(i).Distance;
    dist_allROI=transpose(distArray(result,:));

    simArray=data(i).Similarity;
    sim_allROI=simArray(result,:);
    
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

end
