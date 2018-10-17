function Biodist_multi_roi_ave(animal_name)
%This code calculates the average of ROI value

fname_base = 'C:\Users\jihun\Documents\MATLAB\BioDistribution\Est_T1map\';
cd(fname_base);

param_name = strcat('T1_dynamic_',animal_name,'_new.mat');
load(param_name);
%load('T1_dynamic_M1_new.mat');

fname = strcat(fname_base,animal_name);
cd(fname);
%Pre:1, 15min:2, 1h:3, 5h:4, 24h:5
Brain_id = [2 1 1 1 1];
Liver_id = [3 2 2 2 2];
LKid_id = [1 1 2 1 1];
RKid_id = [1 1 1 1 1];
Muscle_id = [2 2 2 1 2];
Tumor_id = [3 2 2 3 2];

for j = 1:5
    tumor_vol(j)=0; tmr_sum(j)=0; tmr_ave(j)=0; tmr_rel(j)=0; tmr_rel_net(j)=0;
    brain_vol(j)=0; brn_sum(j)=0; brn_ave(j)=0; brn_rel(j)=0; brn_rel_net(j)=0;
    liver_vol(j)=0; liv_sum(j)=0; liv_ave(j)=0; liv_rel(j)=0; liv_rel_net(j)=0;
    rkidney_vol(j)=0;  rkd_sum(j)=0; rkd_ave(j)=0; rkd_rel(j)=0; rkd_rel_net(j)=0;
    lkidney_vol(j)=0;  lkd_sum(j)=0; lkd_ave(j)=0; lkd_rel(j)=0; lkd_rel_net(j)=0;
    kidney_vol(j)=0;   kd_sum(j)=0;  kd_ave(j)=0;  kd_rel(j)=0;  kd_rel_net(j)=0;
    muscle_vol(j)=0;msc_sum(j)=0; msc_ave(j)=0; msc_rel(j)=0; msc_rel_net(j)=0;
end

%i=5;
for i=1:5
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
        [tumor] = nrrdread2(Tumor_name);
    else
        fprintf('Tumor file %01d not found!!\n', i);
    end
    
    if exist(Brain_name,'file')
        [brain] = nrrdread2(Brain_name);
    else
        fprintf('Brain file %01d not found!!\n', i);
    end
    
    if exist(Liver_name,'file')
        [liver] = nrrdread2(Liver_name);
    else
        fprintf('Liver file %01d not found!!\n', i);
    end
    
    if exist(RKidney_name,'file')
        [rkidney] = nrrdread2(RKidney_name);
    else
        fprintf('RKidney file %01d not found!!\n', i);
    end
    
    if exist(LKidney_name,'file')
        [lkidney] = nrrdread2(LKidney_name);
    else
        fprintf('LKidney file %01d not found!!\n', i);
    end
    
    if exist(Muscle_name,'file')
        [muscle] = nrrdread2(Muscle_name);
    else
        fprintf('Muscle file %01d not found!!\n', i);
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
    
%     figure; imshow(T1_est_pre(:,:,Tumor_id(i)));
%     figure; imshow(tmr);
%     figure; imshow(T1_est_pre(:,:,Liver_id(i)));
%     figure; imshow(liv);
    
    %Get number of nonzero element of tumor mask, which corresponds to tumor volume
    tumor_vol(i) = nnz(tumor);
    brain_vol(i) = nnz(brain);
    liver_vol(i) = nnz(liver);
    rkidney_vol(i) = nnz(rkidney);
    lkidney_vol(i) = nnz(lkidney);
    kidney_vol(i) = rkidney_vol(i) + lkidney_vol(i);
    muscle_vol(i) = nnz(muscle);
    
    %total value of tumor ROI
    tmr_sum(i) = sum(sum(sum(tmr)));
    brn_sum(i) = sum(sum(sum(brn)));
    liv_sum(i) = sum(sum(sum(liv)));
    rkd_sum(i) = sum(sum(sum(rkd)));
    lkd_sum(i) = sum(sum(sum(lkd)));
    kd_sum(i) = rkd_sum(i)+lkd_sum(i);
    msc_sum(i) = sum(sum(sum(msc)));
    
    %Calculate average
    tmr_ave(i) = tmr_sum(i)/tumor_vol(i);
    brn_ave(i) = brn_sum(i)/brain_vol(i);
    liv_ave(i) = liv_sum(i)/liver_vol(i);
    rkd_ave(i) = rkd_sum(i)/rkidney_vol(i);
    lkd_ave(i) = lkd_sum(i)/lkidney_vol(i);
    kd_ave(i) = rkd_ave(i) + lkd_ave(i);
    msc_ave(i) = msc_sum(i)/muscle_vol(i);
    
    %Calculate net average (X - background(muscle))
    tmr_ave_net(i) = tmr_ave(i) - msc_ave(i);
    brn_ave_net(i) = brn_ave(i) - msc_ave(i);
    liv_ave_net(i) = liv_ave(i) - msc_ave(i);
    rkd_ave_net(i) = rkd_ave(i) - msc_ave(i);
    lkd_ave_net(i) = lkd_ave(i) - msc_ave(i);
    kd_ave_net(i) = kd_ave(i) - msc_ave(i);
    msc_ave_net(i) = msc_ave(i) - msc_ave(i);
end

%Calculate Relative Change
tmr_rel = abs(tmr_ave(1)-tmr_ave(:))./tmr_ave(1)*100;
brn_rel = abs(brn_ave(1)-brn_ave(:))./brn_ave(1)*100;
liv_rel = abs(liv_ave(1)-liv_ave(:))./liv_ave(1)*100;
rkd_rel = abs(rkd_ave(1)-rkd_ave(:))./rkd_ave(1)*100;
lkd_rel = abs(lkd_ave(1)-lkd_ave(:))./lkd_ave(1)*100;
kd_rel  = abs(kd_ave(1)-kd_ave(:))./kd_ave(1)*100;
msc_rel = abs(msc_ave(1)-msc_ave(:))./msc_ave(1)*100;

%Calculate net Relative Change
tmr_rel_net = abs(tmr_ave_net(1)-tmr_ave_net(:))./tmr_ave_net(1)*100;
brn_rel_net = abs(brn_ave_net(1)-brn_ave_net(:))./brn_ave_net(1)*100;
liv_rel_net = abs(liv_ave_net(1)-liv_ave_net(:))./liv_ave_net(1)*100;
rkd_rel_net = abs(rkd_ave_net(1)-rkd_ave_net(:))./rkd_ave_net(1)*100;
lkd_rel_net = abs(lkd_ave_net(1)-lkd_ave_net(:))./lkd_ave_net(1)*100;
kd_rel_net  = abs(kd_ave_net(1)-kd_ave_net(:))./kd_ave_net(1)*100;
msc_rel_net = abs(msc_ave_net(1)-msc_ave_net(:))./msc_ave_net(1)*100;

figure(1)
x = [0 0.25 1 5 24];
plot(x,tmr_ave,'-o',x,brn_ave,'--+',x,kd_ave,'--*',x,liv_ave,'--s',x,msc_ave,'--x');
legend('Tumor','Brain','Kidney','Liver','Muscle');
title('Average');
xlabel('Time after injection (h)');
ylabel('Average T1 (ms)');
set(findall(gca, 'Type', 'Line'),'LineWidth',1.5);
saveas(gcf,strcat('ROI_',animal_name,'_ave_liver.pdf'));

figure(2);
plot(x,tmr_rel,'-o',x,brn_rel,'--+',x,kd_rel,'--*',x,liv_rel,'--s',x,msc_rel,'--x');
legend('Tumor','Brain','Kidney','Liver','Muscle');
title('Relative Change');
xlabel('Time after injection (h)');
ylabel('Relative change of T1 (%)');
set(findall(gca, 'Type', 'Line'),'LineWidth',1.5);
saveas(gcf,strcat('ROI_',animal_name,'_rel_liver.pdf'));

figure(3)
plot(x,tmr_ave_net,'-o',x,brn_ave_net,'--+',x,kd_ave_net,'--*',x,liv_ave_net,'--s',x,msc_ave_net,'--x');
legend('Tumor','Brain','Kidney','Liver','Muscle');
title('Contrast (background subtracted)');
xlabel('Time after injection (h)');
ylabel('Contrast (ms)');
set(findall(gca, 'Type', 'Line'),'LineWidth',1.5);
saveas(gcf,strcat('ROI_',animal_name,'_net_liver.pdf'));

figure(4);
plot(x,tmr_rel_net,'-o',x,brn_rel_net,'--+',x,kd_rel_net,'--*',x,liv_rel_net,'--s');
legend('Tumor','Brain','Kidney','Liver');
title('Relative Change of Contrast');
xlabel('Time after injection (h)');
ylabel('Relative change of contrast (%)');
ylim([-50 150]);
set(findall(gca, 'Type', 'Line'),'LineWidth',1.5);
saveas(gcf,strcat('ROI_',animal_name,'_rel_net_liver.pdf'));


% figure(10)
% plot(x,tumor_vol,'-o',x,brain_vol,'--+',x,kidney_vol,'--*',x,muscle_vol,'--x');
% legend('Tumor','Brain','Kidney','Muscle');
% title('Volume');
% 
% figure(11)
% plot(x,tmr_sum,'-o',x,brn_sum,'--+',x,kd_sum,'--*',x,msc_sum,'--x');
% legend('Tumor','Brain','Kidney','Muscle');
% ylim([0 1000000000]);
title('Total');