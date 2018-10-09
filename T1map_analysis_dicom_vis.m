%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Version 1.0
% modified on 10/04/2018 by Jihun Kwon
% For visualization of dicome T1map file (normalized by Bruker system)
% Email: jkwon3@bwh.harvard.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;
clear;
clc;
figure(1); clf('reset'); set(gca,'Position',[440   378   560   420]);
figure(2); clf('reset'); set(gca,'Position',[440   378   560   420]);
cb = [0 7000];
flip_cb = flipud(jet);
flip_cb(1,:)=0;
%% Whole Volume
cd('C:\Users\jihun\Documents\BioDistribution\Berbeco Data\20181002_082513_Berbeco_Bi_Gd_1_12\6\pdata\2\dicom');
[X0,map0] = dicomread('MRIm13.dcm');
cd('C:\Users\jihun\Documents\BioDistribution\Berbeco Data\20181002_092316_Berbeco_Bi_Gd_1_13\2\pdata\2\dicom');
[X15m,map15min] = dicomread('MRIm08.dcm');
cd('C:\Users\jihun\Documents\BioDistribution\Berbeco Data\20181002_101655_Berbeco_Bi_Gd_1_14\4\pdata\2\dicom');
[X1h,map1h] = dicomread('MRIm08.dcm');
cd('C:\Users\jihun\Documents\BioDistribution\Berbeco Data\20181002_132606_Berbeco_Bi_Gd_1_15\4\pdata\2\dicom');
[X5h,map05h] = dicomread('MRIm13.dcm');
cd('C:\Users\jihun\Documents\BioDistribution\Berbeco Data\20181003_094848_Berbeco_Bi_Gd_1_16\8\pdata\2\dicom');
[X24h,map24h] = dicomread('MRIm08.dcm');
margins = [.007 .007];
figure(1); hold on;
subplot_tight(1,5,1,margins), imshow(X0,map0), title('Pre')
colorbar; colormap(flip_cb); set(gca,'clim',cb);
subplot_tight(1,5,2,margins), imshow(X15m,map15min), title('15 min')
colorbar; colormap(flip_cb); set(gca,'clim',cb);
subplot_tight(1,5,3,margins), imshow(X1h,map1h), title('1.5 hour')
colorbar; colormap(flip_cb); set(gca,'clim',cb);
subplot_tight(1,5,4,margins), imshow(X5h,map05h), title('5 hour')
colorbar; colormap(flip_cb); set(gca,'clim',cb);
subplot_tight(1,5,5,margins), imshow(X24h,map24h), title('24 hour')
colorbar; colormap(flip_cb); set(gca,'clim',cb);

saveas(gcf,strcat('T1wI_unfiltered_WholeVolume.pdf'));

% %% Zoom in
% figure(2); hold on;
% xrange = 180:330;
% subplot_tight(1,5,1,margins), imshow(X0(xrange,:),map0), title('Pre')
% colormap jet; set(gca,'clim',cb);
% subplot_tight(1,5,2,margins), imshow(X15m(xrange,:),map15min), title('15 min')
% colormap jet; set(gca,'clim',cb);
% subplot_tight(1,5,3,margins), imshow(X1h(210:360,:),map1h), title('1.5 hour')
% colormap jet; set(gca,'clim',cb);
% subplot_tight(1,5,4,margins), imshow(X5h(190:340,:),map05h), title('5 hour')
% colormap jet; set(gca,'clim',cb);
% subplot_tight(1,5,5,margins), imshow(X24h(200:350,:),map24h), title('24 hour')
% colormap jet; set(gca,'clim',cb);
% 
% %colormap jet;
% %set(gca,'clim',[0 17000]);
% %colorbar;
% % Save T1map as pdf
% saveas(gcf,strcat('T1wI_unfiltered_Zoomin.pdf'));