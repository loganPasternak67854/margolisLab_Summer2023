function[result]=roiSelection(data,x)
%{
Specification: This function will open a window that will prompt the user
to select one of the ROIs from Daas1. The result of function is the number
of ROI that will be tracked in the roi_accross_day function. 

INPUT: User input
OUTPUT: The number of the ROI in Daas1 that you want to track. 
%}

[row,col]=size(data(x).Centroids);
statement1='Select an ROI in Daas';
statement2=num2str(x);
statement3=' to Track';
trueStatement=strcat(statement1,statement2,statement3);

choices=zeros(row,1);
for i=1:row
    choices(i)=i;
end

choices=string(choices);

result=listdlg('PromptString',{trueStatement},'SelectionMode','single','ListString',choices);

end
