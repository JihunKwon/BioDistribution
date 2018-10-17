

F = dir('MR*');

TR = [100 300 900 2700 6500];

nSlices = 3;
nTRs = 5;
counter = 1;
clear ims
for ii=1:nTRs
    for jj=1:nSlices
        ims(:,:,jj,ii) = dicomread(F(counter).name);
        counter = counter+1;
    end
end


T1_est = zeros(size(ims,1),size(ims,2),size(ims,3));
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

                [params,resnorm,resid,exitflag] = lsqcurvefit(@myfun_Exp_Increase,x0,xdata,ydata);

                T1_est(xx,yy,zz) = params(2);
                A_est(xx,yy,zz) = params(1);
                A_est(xx,yy,zz) = params(1);
                Error(xx,yy,zz) = resnorm;
            end
        end
    end
end

info1 = dicominfo('MRIm01.dcm');
