function[daasNum]=daasSelection(dimension)
%{
Specification: This function will prompt you to pick a Daas from a list.
The output will be the Daas number of the chosen session.

INPUT: The number of layers within the 3d multidimensional image matrix

OUTPUT: The layer number that was selected by the user
%}

choices=zeros(dimension-1,1);
for i=2:dimension
    temp=i-1;
    choices(temp)=i;
end

choices=string(choices);

daasNum=listdlg('PromptString',{'Select a Daas Session'},'SelectionMode','single','ListString',choices);

end
