function [T1_est] = Biodist_estT1map(F,TR,nTRs,nSlices)
% Import T1wI and estimate T1map

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
            if mask(xx,yy,zz)==1;
            
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

%{
plot(ims(:,:,2,5)); axis off;
% Specify pixel of interest on the figure
x = 307;
y = 28;
z = 2;

% Plot both data points and fitted line
for i = 1:5
    a(i) = ims(x,y,z,i);
end
figure
F = A_est(x,y,z)*(1-exp(-xdata/T1_est(x,y,z)));
plot(xdata(:),a(:),'ko',xdata(:),F(:),'b-'); 

% Show T1map
imagesc(T1_est(:,:,1),[0,2000]);set(gca,'dataAspectRatio',[1 1 1]);axis off;
colorbar;colormap jet;
%}
end