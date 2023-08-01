function[maxIndex]=mostSimilar(struct,choice)
%{
Function Specifictations: 
This function takes the list of tables which represent the combinations of
pairings for a single ROI in session 1 and finds the pairing within
selected session that exhibits the best similarity scaling. The location
of this most similar pairing is output as the result of the function.

INPUT: 
struct: The structure of tables which contain the data for the specific ROI
combinations.
choice: The selected session, excluding the first, that is the domain for
the best pair search. 

OUTPUT:
maxIndex: The location of the best pairing within the chosen session.
%}
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

%Find the indices in which the Jaccard and Correlation values are above the
%preset thresholds.

l=length(table_withinTresh_Correlation);
max=0;
maxIndex=0;
for i=1:l
    if (tableJaccard(i)+tableCorr(i)>max)
        max=tableJaccard(i)+tableCorr(i);
        maxIndex=i;
    end
end

end
