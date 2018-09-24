%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Version 1.0
% modified on 09/19/2018 by Jihun Kwon
% this function calculate average of ROI on T1 map
% Email: jkwon3@bwh.harvard.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear;
clc;
%% Import T1map
tarname = '3'; %Change only this
% Chose from 2,2b,3,4,5,6,7,7b,8,9,10,11...6FISP

basefolder = 'C:\Users\jihun\Documents\MATLAB\BioDistribution\JihunAnalysis\Input\T1wI\';
%basefolder = 'C:\Users\jihun\Documents\MATLAB\BioDistribution\JihunAnalysis\Input\T1map\';
basefolder = strcat(basefolder, tarname);
%Outfolder = 'C:\Users\jihun\Documents\MATLAB\BioDistribution\JihunAnalysis\Output\G1\T1map';
Outfolder = 'C:\Users\jihun\Documents\MATLAB\BioDistribution\JihunAnalysis\Output\T1wI_G0.5\';
Outfolder = strcat(Outfolder, tarname);
figure('Position', [391 1 473 405]);
%for i=1:21 %21 is max file number
i=7;
    ft1_pre = sprintf('MRIm%02d.dcm', i);
    fname = fullfile(basefolder, ft1_pre);
    %if (rem(i,5)==0 || rem(i,5)==2)&&(exist(fname, 'file') == 2)%For T1map
    if exist(fname, 'file') == 2 %For T1wI
        [X,map] = dicomread(fname);
        %figure;
        %imshow(X);colormap jet;caxis('auto');colorbar;
        imshow(X);colormap jet;set(gca,'clim',[0 17000]);colorbar;
        % Save T1map as pdf
        saveas(gcf,strcat('T1wI_folder',num2str(tarname),'_',num2str(i),'_unfiltered.pdf'));
        info = dicominfo(fname);
        % Apply Gaussian Filter
        %X_gfilt = imgaussfilt(X,0.5);
        %ft1_gfilt = sprintf('MRIgfilt%02d.dcm', i);
        %imshow(X_gfilt);colormap jet;caxis('auto');colorbar;
        %imshow(X_gfilt);colormap jet;set(gca,'clim',[0 12000]);colorbar;
        % Save filtered T1map as tif
        %saveas(gcf,strcat('T1map_folder',num2str(tarname),'_',num2str(i),'_filtered.pdf'));
        % Change directory to save filtered dicom files
        cd(Outfolder);
        % Save new dicom
        %dicomwrite(X_gfilt, ft1_gfilt, info);
        %cd ../T1map
        cd ../pdf
    else
        disp('No such file!');
    end
%end

%% Show T1 map in color map


%% Contouring of ROI