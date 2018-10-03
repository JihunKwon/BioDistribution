%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Version 1.0
% modified on 09/24/2018 by Jihun Kwon
% Get ROI contoured by Slicer and return average
% Email: jkwon3@bwh.harvard.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear;
clc;
%tmr_vol = zeros(10);      %tumor volume
tmr = zeros(10,384,192);      %tumor with index value
%tmr_sum = 1:10;      %total index value of tumor
%tmr_ave = zeros(10);      %average index value of tumor

for i=1:10
    total_raw = sprintf('MRImF%02d.nrrd', i);
    tmr_fname = sprintf('MRImF%02d_tumor-label.nrrd', i);
    %total_raw = sprintf('MRImF02.nrrd');

    %tmr_fname = sprintf('MRImF02_tumor-label.nrrd');
    if exist(tmr_fname,'file')
        [total,total_info] = nrrdread2(total_raw);
        imshow(total);
        [tmr_mask,tmr_info] = nrrdread2(tmr_fname);
        imshow(tmr_mask);
        
        %Get number of nonzero element of tumor mask, which corresponds to tumor volume
        tmr_vol(i) = nnz(tmr_mask); 
        %Apply mask to total and segment tumor
        tmr(i,:,:) = total.*tmr_mask;
        %imshow(tmr(i,:,:));
        %total value of tumor ROI
        tmr_sum(i) = sum(sum(sum(tmr)));
        tmr_ave(i) = tmr_sum(i)/tmr_vol(i);
        
    else
        fprintf('Folder %02d not found!!', i);
    end


end

