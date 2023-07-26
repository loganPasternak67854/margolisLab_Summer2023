function[]=show_ROILayer(data)

%DESCRIPTION: Shows a Daas with centroids labeled 
%INPUT: Main data structure from csvReader.m
%OUTPUT:Displays image of session along with centroids

x=input("Which image do you want to visualize?\n");
x=cast(x,"uint8");
    
imshow(data(x).LayerROIData);
    
standard=data(x).Centroids;
    
hold on
plot(standard(:,1),standard(:,2),'*b')
hold off

end
