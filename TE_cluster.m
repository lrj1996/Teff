TEtmp=TE1000(:,:,[12,1:11]);
TEtmp(1:45,:,:)=TE1000(1:45,:,[6:12,1:5]);
for i=1:12
    tmp=TEtmp(:,:,i);
    tmp(ice_month>9)=NaN;
    TE1d(:,i)=tmp(M3d(:,:,1)==1);
end
TE1d=(TE1d-mean(TE1d,2));
[idx,c,sumd,d] = kmedoids(TE1d,3,'Distance',@dtwf);
idx2d=M3d(:,:,1)*0+NaN;
idx2d(M3d(:,:,1)==1)=idx;

function dist = dtwf(ZI,ZJ)
    m=size(ZJ,1);
    dist = zeros(m,1);
    for i=1:m
        dist(i) = dtw(ZI,ZJ(i,:));
    end
end
