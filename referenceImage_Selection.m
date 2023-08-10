function[result]=referenceImage_Selection(dimension)
%{
Function Specifications:
This function will allow the user to select the specific session image they
want to use as the reference image for ROI distance and similarity
analysis.
INPUT: The number of sessions that are available within the 3d image matrix
%}

statement1='Select a reference image.';

choices=zeros(dimension,1);
for i=1:length(choices)
    choices(i)=i;
end

choices=string(choices);

result=listdlg('PromptString',{statement1},'SelectionMode','single','ListString',choices);

end
