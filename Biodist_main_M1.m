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
animal_name = 'M1';

i=2;
%for i=1:3 %Folder dir. 1:Pre, 2:15m, 3:1h, 4:5h, 5:24h
    tar = num2str(i);
    base = 'C:\Users\jihun\Documents\MATLAB\BioDistribution\Input_T1wI\M1\';
    base = strcat(base,tar);
    cd(base);
    
    if (i==1)
        TR = [90 270 810 2430 7290]; nSlices = 3;
    elseif (i==2)
        TR = [100 300 900 2700 8400]; nSlices = 3;
    elseif (i==3)
        TR = [120 300 900 2700 8400]; nSlices = 4;
    else
        TR = [100 200 400 800 1600 3200 7000]; nSlices = 3;
    end
    
    % Import T1wI and estimate T1map
    F = dir('MR*'); 
    nTRs = size(TR,2);
    counter = 1;
    clear ims

    %Changed specifically for Biodistribution datasets.
    %Because 1~3:TR1,different slices. 4~6:TR2,dfferent slices...
    for ii=1:nTRs
        for jj=1:nSlices
            ims(:,:,jj,ii) = dicomread(F(counter).name);
            counter = counter+1;
        end
    end


    T1_est = zeros(size(ims,1),size(ims,2),nSlices);
    mask = ims(:,:,:,1)*0;
    gg = find(ims(:,:,:,end)>.2*mean(mean(mean(ims(:,:,:,end),1),2),3));
    mask(gg)=1;

    xdata = TR;

    for xx=1:size(ims,1)
        for yy = 1:size(ims,2)
            for zz = 1:size(ims,3)
                if mask(xx,yy,zz)==1

                    ydata = double(squeeze((ims(xx,yy,zz,:))))';

                    x0 = [ydata(end) 1500];

                    options = optimoptions('lsqcurvefit','Display','none');
                    [params,resnorm,resid,exitflag] = lsqcurvefit(@myfun_Exp_Increase,x0,xdata,ydata,[],[],options);

                    T1_est(xx,yy,zz) = params(2);
                    A_est(xx,yy,zz) = params(1);
                    %A_est(xx,yy,zz) = params(1);
                    Error(xx,yy,zz) = resnorm;
                    exflg = exitflag;
                end
            end
        end
        disp(xx); %up to 384
    end
    
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
%end
cd('C:\Users\jihun\Documents\MATLAB\BioDistribution\Est_T1map');
save(strcat('T1_dynamic_',animal_name,'.mat'),'T1_est_pre','T1_est_15m','T1_est_1h','T1_est_5h','T1_est_24h');
%save(strcat('T1_dynamic_',animal_name,'.mat'),'T1_est_pre','T1_est_15m','T1_est_1h','T1_est_5h','T1_est_24h');

%{
plot(ims(:,:,2,5)); axis off;
% Specify pixel of interest on the figure
x = 306;
y = 29;
z = 2;

% Plot both data points and fitted line
for i = 1:7
    a(i) = ims(x,y,z,i);
end
figure
F = A_est(x,y,z)*(1-exp(-xdata/T1_est(x,y,z)));
plot(xdata(:),a(:),'ko',xdata(:),F(:),'b-'); 

% Show T1map
figure
imagesc(T1_est(:,:,2),[0,2000]);set(gca,'dataAspectRatio',[1 1 1]);axis off;
colorbar;colormap jet;
%}
%{
info1_1 = dicominfo('MRIm01.dcm');
info1_2 = dicominfo('MRIm02.dcm');
info1_3 = dicominfo('MRIm03.dcm');
info1_4 = dicominfo('MRIm04.dcm');
info1_5 = dicominfo('MRIm05.dcm');
info1_6 = dicominfo('MRIm06.dcm');
info1_7 = dicominfo('MRIm07.dcm');
info1_8 = dicominfo('MRIm08.dcm');
info1_9 = dicominfo('MRIm09.dcm');
info1_10 = dicominfo('MRIm10.dcm');
info1_11 = dicominfo('MRIm11.dcm');
info1_12 = dicominfo('MRIm12.dcm');
info1_13 = dicominfo('MRIm13.dcm');
info1_14 = dicominfo('MRIm14.dcm');
info1_15 = dicominfo('MRIm15.dcm');
info1_16 = dicominfo('MRIm16.dcm');
info1_17 = dicominfo('MRIm17.dcm');
info1_18 = dicominfo('MRIm18.dcm');
info1_19 = dicominfo('MRIm19.dcm');
info1_20 = dicominfo('MRIm20.dcm');
%}