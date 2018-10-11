function Biodist_visT1map(animal_name,T1_est_pre,T1_est_15m,T1_est_1h,T1_est_5h,T1_est_24h); 
%visuaize and save T1_est
out_name = 'C:\Users\jihun\Documents\MATLAB\BioDistribution\Input_T1wI';
out_name = strcat(out_name,animal_name);
cd(out_name);

figure(1); clf('reset'); set(gca,'Position',[440   378   560   420]);
figure(2); clf('reset'); set(gca,'Position',[440   378   560   420]);
figure(3); clf('reset'); set(gca,'Position',[440   378   560   420]);

margins = [.007 .007];
cb_range = [0 2000];
cb_inv_range = [1400 2600]; %tumor window:[1400 2600];
flip_cb = flipud(jet);
flip_cb(1,:)=0;

%Change target slice accordingly.
z_pre = 3;
z_15m = 2;
z_1h  = 2;
z_5h  = 3;
z_24h = 2;

%% Whole Volume
figure(1); hold on;
subplot_tight(1,5,1,margins), imshow(T1_est_pre(:,:,z_pre,1)), title('Pre')
colorbar; colormap jet; set(gca,'clim',cb_range);
subplot_tight(1,5,2,margins), imshow(T1_est_15m(:,:,z_15m,2)), title('15 min')
colorbar; colormap jet; set(gca,'clim',cb_range);
subplot_tight(1,5,3,margins), imshow(T1_est_1h(:,:,z_1h)), title('1.5 hour')
colorbar; colormap jet; set(gca,'clim',cb_range);
subplot_tight(1,5,4,margins), imshow(T1_est_5h(:,:,z_5h)), title('5 hour')
colorbar; colormap jet; set(gca,'clim',cb_range);
subplot_tight(1,5,5,margins), imshow(T1_est_24h(:,:,z_24h)), title('24 hour')
colorbar; colormap jet; set(gca,'clim',cb_range);

saveas(gcf,strcat('T1wI_',animal_name,'_WholeVolume_jet.pdf'));

%Flip color jet
figure(2); hold on;
subplot_tight(1,5,1,margins), imshow(T1_est_pre(:,:,z_pre)), title('Pre')
colorbar; colormap(flip_cb); set(gca,'clim',cb_inv_range);
subplot_tight(1,5,2,margins), imshow(T1_est_15m(:,:,z_15m)), title('15 min')
colorbar; colormap(flip_cb); set(gca,'clim',cb_inv_range);
subplot_tight(1,5,3,margins), imshow(T1_est_1h(:,:,z_1h)), title('1.5 hour')
colorbar; colormap(flip_cb); set(gca,'clim',cb_inv_range);
subplot_tight(1,5,4,margins), imshow(T1_est_5h(:,:,z_5h)), title('5 hour')
colorbar; colormap(flip_cb); set(gca,'clim',cb_inv_range);
subplot_tight(1,5,5,margins), imshow(T1_est_24h(:,:,z_24h)), title('24 hour')
colorbar; colormap(flip_cb); set(gca,'clim',cb_inv_range);

saveas(gcf,strcat('T1wI_',animal_name,'_WholeVolume_flipjet.pdf'))

%Show all slices
figure(3); axis off; hold on;
subplot_tight(3,5,1), imshow(T1_est_pre(:,:,1)); title('Z1 Pre');
colorbar; colormap(flip_cb); set(gca,'clim',cb_inv_range);
subplot_tight(3,5,2), imshow(T1_est_15m(:,:,1)); title('Z1 15min');
colorbar; colormap(flip_cb); set(gca,'clim',cb_inv_range);
subplot_tight(3,5,3), imshow(T1_est_1h(:,:,1)); title('Z1 1.5hour');
colorbar; colormap(flip_cb); set(gca,'clim',cb_inv_range);
subplot_tight(3,5,4), imshow(T1_est_5h(:,:,1)); title('Z1 5hour');
colorbar; colormap(flip_cb); set(gca,'clim',cb_inv_range);
subplot_tight(3,5,5), imshow(T1_est_24h(:,:,1)); title('Z1 24hour');
colorbar; colormap(flip_cb); set(gca,'clim',cb_inv_range);
subplot_tight(3,5,6), imshow(T1_est_pre(:,:,2)); title('Z2 Pre');
colorbar; colormap(flip_cb); set(gca,'clim',cb_inv_range);
subplot_tight(3,5,7), imshow(T1_est_15m(:,:,2)); title('Z2 15min');
colorbar; colormap(flip_cb); set(gca,'clim',cb_inv_range);
subplot_tight(3,5,8), imshow(T1_est_1h(:,:,2)); title('Z2 1.5hour');
colorbar; colormap(flip_cb); set(gca,'clim',cb_inv_range);
subplot_tight(3,5,9), imshow(T1_est_5h(:,:,2)); title('Z2 5hour');
colorbar; colormap(flip_cb); set(gca,'clim',cb_inv_range);
subplot_tight(3,5,10), imshow(T1_est_24h(:,:,2)); title('Z2 24hour');
colorbar; colormap(flip_cb); set(gca,'clim',cb_inv_range);
subplot_tight(3,5,11), imshow(T1_est_pre(:,:,3)); title('Z3 Pre');
colorbar; colormap(flip_cb); set(gca,'clim',cb_inv_range);
subplot_tight(3,5,12), imshow(T1_est_15m(:,:,3)); title('Z3 15min');
colorbar; colormap(flip_cb); set(gca,'clim',cb_inv_range);
subplot_tight(3,5,13), imshow(T1_est_1h(:,:,3)); title('Z3 1.5hour');
colorbar; colormap(flip_cb); set(gca,'clim',cb_inv_range);
subplot_tight(3,5,14), imshow(T1_est_5h(:,:,3)); title('Z3 5hour');
colorbar; colormap(flip_cb); set(gca,'clim',cb_inv_range);
subplot_tight(3,5,15), imshow(T1_est_24h(:,:,3)); title('Z3 24hour');
colorbar; colormap(flip_cb); set(gca,'clim',cb_inv_range);
saveas(gcf,strcat('T1wI_,animal_name,_WholeVolume_flipjet_allfig.pdf'));

end

