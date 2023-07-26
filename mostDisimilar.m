function[minIndex]=mostDisimilar(struct,choice)

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

%Find the indices in which both the Jaccard and Correlation values are below the
%preset thresholds.

l=length(table_withinTresh_Jaccard);
min=999;
minIndex=0;
for i=1:l
   if ((tableJaccard(i)+tableCorr(i))<min)
       min=tableJaccard(i)+tableCorr(i);
       minIndex=i;
   end
end


end
