function Biodist_T1map_roi(animal_name)
%% load data and header information
%dirname=uigetdir; % location of dicom files
cd('C:\Users\jihun\Documents\MATLAB\BioDistribution\Est_T1map');
parameter = strcat('T1_dynamic_',num2str(animal_name),'.mat');
%load(parameter)

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
    saveas(gcf,strcat(dirname,'\plot_',num2str(animal_name),'_tp',num2str(num),'.tif'))
    out(num) = (values(:,:,1));
end
xlswrite(strcat('\ROI_values_',num2str(animal_name),'.xlsx'),out(:));
save(strcat('T1map_ROI_tumor_',num2str(animal_name),'.mat'),'out');

%draw average T1
figure
plot(1:5,out(:),'bo-');
xlabel('Time Points');
ylabel('Average T1(ms)');
title('Average T1 values');
saveas(gcf,strcat('T1map_roi_tumor_',num2str(animal_name),'.pdf'));

%draw relative change(%)
out_rel = (out(1)-out(:))./out(1)*100;
figure
plot(1:5,out_rel(:),'bo-');
xlabel('Time Points');
ylabel('Relative change(%)');
title('Relative Change of T1 value(%)');
saveas(gcf,strcat('T1map_roi_relative_tumor_',num2str(animal_name),'.pdf'));
end

