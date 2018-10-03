%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Version 1.0
% modified on 10/02/2018 by Jihun Kwon
% Import T1map and contour ROI on matlab. Calculate average value of ROI.
% Email: jkwon3@bwh.harvard.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;
clc;
close all;
%% load data and header information
%dirname=uigetdir; % location of dicom files
dirname = '\Users\jihun\Documents\MATLAB\BioDistribution\JihunAnalysis\Input\T1map\EstimatedFromT1WI';
load('T1_dynamic.mat')

cb = [0 2000];
flip_cb = flipud(jet);
flip_cb(1,:)=0;
%% calulate ROI values and plot
flag=1;
while flag
    try 
        numofrois=uint8(input('number of ROI: '));
        flag=0;
    catch em
    end
end

%tar: target slice
for num=1:5
    if num==1
        tar = T1_pre;
    elseif num==2
        tar = T1_15m;
    elseif num==3
        tar = T1_1h;
    elseif num==4
        tar = T1_5h;
    elseif num==5
        tar = T1_24h;
    else
        disp('no such file!')
    end

    [values(:,:,1),b(:,:,1),p{1}]=roi_values_J(tar,tar(:,:,1),numofrois);
    clf;set(gcf,'Units','normalized','OuterPosition',[0 0 1 1]);
    imagesc(tar(:,:,1));colormap(flip_cb);img_setting1;title('ROI');hold on
    set(gca,'clim',cb);
    roi_para_drawing_J(p{1},numofrois)
    saveas(gcf,strcat(dirname,'\plot_s',num2str(num),'.tif'))

    out(num) = (values(:,:,1));
end
xlswrite(strcat('\ROI_values.xlsx'),out(:));
save('T1map_ROI.mat','out');

%draw average T1
figure
plot(1:5,out(:),'bo-');
xlabel('Time Points');
ylabel('Average T1(ms)');
title('Average T1 values');
saveas(gcf,strcat('T1map_roi_tumor.pdf'));

%draw relative change(%)
out_rel = (out(1)-out(:))./out(1)*100;
figure
plot(1:5,out_rel(:),'bo-');
xlabel('Time Points');
ylabel('Relatice change(%)');
title('Relative Change of T1 value(%)');
saveas(gcf,strcat('T1map_roi_relative_tumor.pdf'));