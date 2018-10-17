%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Version 1.0
% modified on 10/10/2018 by Jihun Kwon
% Import T1wI and estimate T1map
% Contour on T1map and calculate average of ROI.
% Email: jkwon3@bwh.harvard.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;
clc;
close all;
tic;
animal_name = 'M3';
base_name = 'C:\Users\jihun\Documents\MATLAB\BioDistribution\Input_T1wI\';
base_name = strcat(base_name,animal_name);
cd(base_name);
%Folder dir. 1:Pre, 2:15m, 3:1h, 4:5h, 5:24h
%i=1;
for i=1:5 %i=1;
    %% Import DICOM
    f_num = num2str(i);
    cd(f_num);
    F = dir('MR*');

    %Mouse 3
    TR = [100 150 300 500 1000 2000 3000 5000 8000]; nSlices = 3; nTRs = 9;

    %% Estimate T1map from T1wI
    T1_est = Biodist_estT1map(F,TR,nTRs,nSlices);

    % Write Parameters
    if i==1
        T1_est_pre = T1_est;
    elseif i==2
        T1_est_15m = T1_est;
    elseif i==3
        T1_est_1h = T1_est;
    elseif i==4
        T1_est_5h = T1_est;
    else
        T1_est_24h = T1_est;
    end
    cd(base_name);

end %end of for loop
 
cd('C:\Users\jihun\Documents\MATLAB\BioDistribution\Est_T1map');
save(strcat('T1_dynamic_',animal_name,'.mat'),'T1_est_pre','T1_est_15m','T1_est_1h','T1_est_5h','T1_est_24h');

%Visualize and save T1_est
Biodist_visT1map(animal_name,T1_est_pre,T1_est_15m,T1_est_1h,T1_est_5h,T1_est_24h); 

Biodist_multi_roi_ave(animal_name);
Biodist_main_M1
%Contour T1map
%Biodist_T1map_roi(animal_name);

toc;