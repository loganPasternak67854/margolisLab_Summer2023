function[]=display_topTen(topTen,images,refNum,revamped_sessions)
%{
Function Description:
Display all the image overlays for the top ten picks for every session.
This should be 10x20 overlay images for Romero. There should be 20 columns
representing the number of sessions in Romero, and there should be 10 rows
which represent the top ten roi picks from that session.

INPUT:
topTen: This is a structure of tables which contains the top ten roi pairs.
The pairs consist of a selected roi within a reference session and an roi 
from another session.

OUTPUT: NaN

USE Subplot
%}

%Get the data for the selected roi from the reference image

%If the reference image is for session 1 then execute the code bellow
if refNum==1
    
    refROI=topTen.Daas2.ref_roi; %This portion of the code needs to be tweaked
    refROI=refROI(1);
    refImage=images(refNum,refROI).window;
    refImage=cast(refImage,"uint8");
    refImage(refImage==1)=254;
    
    val=1;
    for i=1:10
        for j=2:(length(fieldnames(topTen))+1)
    
            temp=num2str(j); %Turns the session number into a character
            daas="Daas"; 
            field=append(daas,temp); %Combines 'Daas' and session number to create field
            roiTop=topTen.(field).roi_NUM; %Collects the ROI data for the given field
            roiLocation=roiTop(i);%Location of the ROI which represents the ith best pick
            topImage=images(j,roiLocation).window; %Extracts the image data of the jth session and ith best pick
            topImage=cast(topImage,"uint8");%Converts image data to uint8
            topImage(topImage==1)=254;
            topImage_overlay=labeloverlay(refImage,topImage); %Label overlay reference image with top image pick
            subplot(10,19,val), imshow(topImage_overlay);
            val=val+1.;
    
        end
    end

%If the reference image is not from Session 1 execute the code below
else

    refROI=topTen.Daas1.ref_roi; %This portion of the code needs to be tweaked
    refROI=refROI(1);
    refImage=images(refNum,refROI).window;
    refImage=cast(refImage,"uint8");
    refImage(refImage==1)=254;
    
    val=1;
    for i=1:10
        for j=1:length(revamped_sessions)
            
            trueIndex=revamped_sessions(j);
            temp=num2str(trueIndex); %Turns the session number into a character
            daas="Daas"; 
            field=append(daas,temp); %Combines 'Daas' and session number to create field
            roiTop=topTen.(field).roi_NUM; %Collects the ROI data for the given field
            roiLocation=roiTop(i);%Location of the ROI which represents the ith best pick
            topImage=images(trueIndex,roiLocation).window; %Extracts the image data of the jth session and ith best pick
            topImage=cast(topImage,"uint8");%Converts image data to uint8
            topImage(topImage==1)=254;
            topImage_overlay=labeloverlay(refImage,topImage); %Label overlay reference image with top image pick

            %Gives a short title showing which ROIs are being paired and
            %their respective Daas'
            statement1='Daas';
            statement2=num2str(refNum);
            statement3=' ROI: ';
            statement4=num2str(refROI);
            statement5='Daas';
            statement6=num2str(trueIndex);
            statement7=' ROI: ';
            statement8=num2str(roiLocation);
            completeStatement1=append(statement1,statement2,statement3,statement4);
            completeStatement2=append(statement5,statement6,statement7,statement8);


            subplot(10,19,val), imshow(topImage_overlay), title({completeStatement1,completeStatement2},'FontSize',6);
            val=val+1.;
    
        end
    end

end


end
