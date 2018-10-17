
%This code calculates the average of ROI value

load('T1_dynamic_M1.mat');
%Pre:1, 15min:2, 1h:3, 5h:4, 24h:5
slice_id = zeros(6);
Brain_id = [2 1 1 1 1];
Liver_id = [1 2 2 1 1];
LKid_id = [1 1 2 1 1];
RKid_id = [1 1 1 1 1];
Muscle_id = [2 2 2 1 2];
Tumor_id = [3 2 2 3 2];

tumor_vol = [0 0 0 0 0]; tmr_sum = [0 0 0 0 0]; tmr_ave = [0 0 0 0 0];
brain_vol = [0 0 0 0 0]; brn_sum = [0 0 0 0 0]; brn_ave = [0 0 0 0 0];
liver_vol = [0 0 0 0 0]; liv_sum = [0 0 0 0 0]; liv_ave = [0 0 0 0 0];
rkid_vol = [0 0 0 0 0]; rkd_sum = [0 0 0 0 0]; rkd_ave = [0 0 0 0 0];
lkid_vol = [0 0 0 0 0]; lkd_sum = [0 0 0 0 0]; lkd_ave = [0 0 0 0 0];
muscle_vol = [0 0 0 0 0]; msc_sum = [0 0 0 0 0]; msc_ave = [0 0 0 0 0];
i=5;
%for i=1:5
    tumor = 0;  tmr = 0;
    brain = 0;  brn = 0;
    liver = 0;  liv = 0;
    lkidney = 0;lkd = 0;
    rkidney = 0;rkd = 0;
    muscle = 0; msc = 0;
    
    Tumor_name = sprintf('%01d_Tumor-label.nrrd',i);
    Brain_name = sprintf('%01d_Brain-label.nrrd',i);
    Liver_name = sprintf('%01d_Liver-label.nrrd',i);
    RKidney_name = sprintf('%01d_RKidney-label.nrrd',i);
    LKidney_name = sprintf('%01d_LKidney-label.nrrd',i);
    Muscle_name = sprintf('%01d_Muscle-label.nrrd',i);
    
    if exist(Tumor_name,'file')
        [tumor,tumor_info] = nrrdread2(Tumor_name);
    else
        fprintf('Tumor file %01d not found!!', i);
    end
    
    if exist(Brain_name,'file')
        [brain,brain_info] = nrrdread2(Brain_name);
    else
        fprintf('Brain file %01d not found!!', i);
    end
    
    if exist(Liver_name,'file')
        [liver,liver_info] = nrrdread2(Liver_name);
    else
        fprintf('Liver file %01d not found!!', i);
    end
    
    if exist(RKidney_name,'file')
        [rkidney,rkid_info] = nrrdread2(RKidney_name);
    else
        fprintf('RKidney file %01d not found!!', i);
    end
    
    if exist(LKidney_name,'file')
        [lkidney,lkid_info] = nrrdread2(LKidney_name);
    else
        fprintf('LKidney file %01d not found!!', i);
    end
    
    if exist(Muscle_name,'file')
        [muscle,muscle_info] = nrrdread2(Muscle_name);
    else
        fprintf('Muscle file %01d not found!!', i);
    end
    
    %Apply mask
    if i==1 %Pre
        tmr = T1_est_pre(:,:,Tumor_id(i)).*tumor;
        brn = T1_est_pre(:,:,Brain_id(i)).*brain;
        liv = T1_est_pre(:,:,Liver_id(i)).*liver;
        lkd = T1_est_pre(:,:,LKid_id(i)).*lkidney;
        rkd = T1_est_pre(:,:,RKid_id(i)).*rkidney;
        msc = T1_est_pre(:,:,Muscle_id(i)).*muscle;
    elseif i==2 %15min
        tmr = T1_est_15m(:,:,Tumor_id(i)).*tumor;
        brn = T1_est_15m(:,:,Brain_id(i)).*brain;
        liv = T1_est_15m(:,:,Liver_id(i)).*liver;
        lkd = T1_est_15m(:,:,LKid_id(i)).*lkidney;
        rkd = T1_est_15m(:,:,RKid_id(i)).*rkidney;
        msc = T1_est_15m(:,:,Muscle_id(i)).*muscle;
    elseif i==3 %1hour
        tmr = T1_est_1h(:,:,Tumor_id(i)).*tumor;
        brn = T1_est_1h(:,:,Brain_id(i)).*brain;
        liv = T1_est_1h(:,:,Liver_id(i)).*liver;
        lkd = T1_est_1h(:,:,LKid_id(i)).*lkidney;
        rkd = T1_est_1h(:,:,RKid_id(i)).*rkidney;
        msc = T1_est_1h(:,:,Muscle_id(i)).*muscle;
    elseif i==4 %5hour
        tmr = T1_est_5h(:,:,Tumor_id(i)).*tumor;
        brn = T1_est_5h(:,:,Brain_id(i)).*brain;
        liv = T1_est_5h(:,:,Liver_id(i)).*liver;
        lkd = T1_est_5h(:,:,LKid_id(i)).*lkidney;
        rkd = T1_est_5h(:,:,RKid_id(i)).*rkidney;
        msc = T1_est_5h(:,:,Muscle_id(i)).*muscle;
    else %24hour
        tmr = T1_est_24h(:,:,Tumor_id(i)).*tumor;
        brn = T1_est_24h(:,:,Brain_id(i)).*brain;
        liv = T1_est_24h(:,:,Liver_id(i)).*liver;
        lkd = T1_est_24h(:,:,LKid_id(i)).*lkidney;
        rkd = T1_est_24h(:,:,RKid_id(i)).*rkidney;
        msc = T1_est_24h(:,:,Muscle_id(i)).*muscle;
    end
    
    figure;
    imshow(T1_est_pre(:,:,Tumor_id(i)));
    figure;
    imshow(tmr);
    figure;
    imshow(T1_est_pre(:,:,Liver_id(i)));
    figure;
    imshow(liv);
    
    %Get number of nonzero element of tumor mask, which corresponds to tumor volume
    tumor_vol(i) = nnz(tumor);
    brain_vol(i) = nnz(brain);
    liver_vol(i) = nnz(liver);
    rkid_vol(i) = nnz(rkidney);
    lkid_vol(i) = nnz(lkidney);
    muscle_vol(i) = nnz(muscle);
    
    %total value of tumor ROI
    tmr_sum(i) = sum(sum(sum(tmr)));
    brn_sum(i) = sum(sum(sum(brn)));
    liv_sum(i) = sum(sum(sum(liv)));
    lkd_sum(i) = sum(sum(sum(lkd)));
    rkd_sum(i) = sum(sum(sum(rkd)));
    msc_sum(i) = sum(sum(sum(msc)));
    
    %Calculate average
    tmr_ave(i) = tmr_sum(i)/tumor_vol(i);
    brn_ave(i) = brn_sum(i)/brain_vol(i);
    liv_ave(i) = liv_sum(i)/liver_vol(i);
    lkd_ave(i) = lkd_sum(i)/rkid_vol(i);
    rkd_ave(i) = rkd_sum(i)/lkid_vol(i);
    msc_ave(i) = msc_sum(i)/muscle_vol(i);
%end

figure
x = [0 0.25 1 5 24];
plot(x,tmr_ave,x,brn_ave,x,liv_ave,x,rkd_ave,x,lkd_ave,x,msc_ave);
legend('Tumor','Brain','Liver','R kidney','L kidney','Muscle');
figure;
plot(x,tmr_sum,x,liv_sum);
figure;
plot(x,tumor_vol,x,liver_vol);