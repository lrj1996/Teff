load("TE_model.mat")

load('TE_Henson.mat')
[lon1,lat1]=meshgrid(lon,lat);
lon1(lon1<0)= lon1(lon1<0)+360;
b_Henson=griddata(lon1,lat1,B_Henson,grid.XT,grid.YT);
TE_Henson=20.^(b_Henson);
TE_Henson_lat=median(TE_Henson,2,'omitnan');


load('TE_Marsay.mat')
TE_Marsay=10.^(-b_Marsay);
TE_Marsay_lat=median(TE_Marsay,2,'omitnan');


figure('Position',[100 100 1000 700]);
axes('Units','normalized','Position',[0.07 0.66 0.35 0.3],'Layer','top')

FPOC100_summer(1:37,:)=mean(FPOC100(1:37,:,[12,1,2]),3);
FPOC100_summer(38:54,:)=mean(FPOC100(38:54,:,:),3);
FPOC100_summer(55:91,:)=mean(FPOC100(55:91,:,[6:8]),3);
tesample3=mean(FPOC2000,3)./FPOC100_summer;
tesample3(ice_month>9)=NaN;

clear tesample Latsample
for i=1:length(Henson12_index)
    if Henson12_index(i,1)<30 
        tesample(i)=mean(FPOC2000(Henson12_index(i,1),Henson12_index(i,2),:),3)./mean(FPOC100(Henson12_index(i,1),Henson12_index(i,2),[12,1,2]),3);
    elseif Henson12_index(i,1)>67 
        tesample(i)=mean(FPOC2000(Henson12_index(i,1),Henson12_index(i,2),:),3)./mean(FPOC100(Henson12_index(i,1),Henson12_index(i,2),6:8),3);
    else
        tesample(i)=mean(FPOC2000(Henson12_index(i,1),Henson12_index(i,2),:),3)./mean(FPOC100(Henson12_index(i,1),Henson12_index(i,2),:),3);
    end
    Latsample(i)=grid.YT(Henson12_index(i,1),Henson12_index(i,2));
end

Lat_count=ones(91,1);
teLat=zeros(91,1);
for i=1:size(tesample3,1)
    for j=1:size(tesample3,2)
        if(~isnan(tesample3(i,j)))
            teLat(i,Lat_count(i))=tesample3(i,j);
            Lat_count(i)=Lat_count(i)+1;
        end
    end
end
teLat(teLat==0)=NaN;
teLat_bar=median(teLat,2,'omitnan');
teLat_min=quantile(teLat,0.25,2);
teLat_max=quantile(teLat,0.75,2);
patch([grid.yt([15:77]),grid.yt([77:-1:15])],[teLat_min([15:77])' teLat_max([77:-1:15])'],[.75 .75 .75],'EdgeColor','none');
hold on; 
plot(Latsample,tesample,'o');
plot(Hensonteff.Latitude,Hensonteff.InSituTeff,'s');
plot(grid.yt,teLat_bar,'k--','LineWidth',1.25)
plot(grid.yt,TE_Henson_lat,'--','LineWidth',1.25)
xlim([-62.5 62.5]);
set(gca,'fontsize',12);
ylim([0 0.35])
ylabel("T_{eff} (100m\rightarrow2000m)")
xlabel("Latitude (^{o})")
title("Henson et al. (2012)")
xl=xlim;
yl=ylim;
text(xl(1),yl(2),'(a)','HorizontalAlignment','left','VerticalAlignment','top','fontsize',14)

FPOC100_summer(1:45,:)=mean(FPOC100(1:45,:,[12,1,2]),3);
FPOC100_summer(46:91,:)=mean(FPOC100(46:91,:,[6:8]),3);
FPOC1000_summer(1:45,:)=mean(FPOC1000(1:45,:,[12,1,2]),3);
FPOC1000_summer(46:91,:)=mean(FPOC1000(46:91,:,[6:8]),3);
tesample3=FPOC1000_summer./FPOC100_summer;

clear tesample2 Latsample2
for i=1:length(Marsay_index)
    tesample2(i)=FPOC1000(Marsay_index(i,1),Marsay_index(i,2),Marsay_mon(i))./FPOC100(Marsay_index(i,1),Marsay_index(i,2),Marsay_mon(i));
    Latsample2(i)=grid.YT(Marsay_index(i,1),Marsay_index(i,2));
end

Lat_count=ones(91,1);
teLat=zeros(91,1);
for i=1:size(tesample3,1)
    for j=1:size(tesample3,2)
        if(~isnan(tesample3(i,j)))
            teLat(i,Lat_count(i))=tesample3(i,j);
            Lat_count(i)=Lat_count(i)+1;
        end
    end
end
teLat(teLat==0)=NaN;
teLat_bar=median(teLat,2,'omitnan');
teLat_min=quantile(teLat,0.25,2);
teLat_max=quantile(teLat,0.75,2);
axes('Units','normalized','Position',[0.52 0.66 0.35 0.3],'Layer','top')
patch([grid.yt([15:78]),grid.yt([78:-1:15])],[teLat_min([15:78])' teLat_max([78:-1:15])'],[.75 .75 .75],'EdgeColor','none');
hold on; 
p1=plot(Latsample2,tesample2,'o');
p3=plot(Marsay_loc(:,2),(1000/100).^(-Marsay_b),'d');
plot(grid.yt,teLat_bar,'k--','LineWidth',1.25)
plot(grid.yt,TE_Marsay_lat,'--','LineWidth',1.25)
p2=plot(0,NaN,'s','Color',[0.8500 0.3250 0.0980]);
xlim([-62.5 62.5]);
ylim([0 0.4])
set(gca,'fontsize',12);
ylabel("T_{eff} (100m\rightarrow1000m)")
xlabel("Latitude (^{o})")
title("Marsay et al. (2015)")
lgd=legend([p1,p2,p3],"Model","H12","M15");
lgd.Position(1)=0.9;
xl=xlim;
yl=ylim;
text(xl(1),yl(2),'(b)','HorizontalAlignment','left','VerticalAlignment','top','fontsize',14)

load("TE_Nowicki.mat")

clear tesample tesample_nowicki
for i=1:length(Henson12_index)
    if Henson12_index(i,1)<30 
        tesample(i)=mean(FPOC1000(Henson12_index(i,1),Henson12_index(i,2),:),3)./mean(FPOC100(Henson12_index(i,1),Henson12_index(i,2),[12,1,2]),3);
    elseif Henson12_index(i,1)>67 
        tesample(i)=mean(FPOC1000(Henson12_index(i,1),Henson12_index(i,2),:),3)./mean(FPOC100(Henson12_index(i,1),Henson12_index(i,2),6:8),3);
    else
        tesample(i)=mean(FPOC1000(Henson12_index(i,1),Henson12_index(i,2),:),3)./mean(FPOC100(Henson12_index(i,1),Henson12_index(i,2),:),3);
    end
    tesample_nowicki(i)=FPOC1000_nowicki(Henson12_index(i,1),Henson12_index(i,2))./FPOC100_nowicki(Henson12_index(i,1),Henson12_index(i,2));
end
for i=1:length(Marsay_index)
    tesample(length(Henson12_index)+i)=FPOC1000(Marsay_index(i,1),Marsay_index(i,2),Marsay_mon(i))./FPOC100(Marsay_index(i,1),Marsay_index(i,2),Marsay_mon(i));
    tesample_nowicki(length(Henson12_index)+i)=FPOC1000_nowicki(Marsay_index(i,1),Marsay_index(i,2))./FPOC100_nowicki(Marsay_index(i,1),Marsay_index(i,2));
end

teobs=[(1000/100).^(log(Hensonteff.InSituTeff)/log(2000/100));(1000/100).^(-Marsay_b)];


axes('Units','normalized','Position',[0.07 0.08 0.35 0.43],'Layer','top')
scatter(teobs(1:length(Henson12_index)),tesample(1:length(Henson12_index)),100,Latsample,'square');
hold on;
scatter(teobs(length(Henson12_index)+1:length(Henson12_index)+length(Marsay_index)),tesample(length(Henson12_index)+1:length(Henson12_index)+length(Marsay_index)),80,Latsample2,'diamond');
xlim([0 0.4])
ylim([0 0.4])
plot([0 0.4],[0 0.4],'k--','LineWidth',1)
set(gca,'fontsize',12)
ylabel("Modeled T_{eff} (100m\rightarrow1000m)")
xlb=xlabel("Observed T_{eff} (100m\rightarrow1000m)");
xlb.Position(1)=0.425;
text(0.035,yl(2),'R=0.85','HorizontalAlignment','left','VerticalAlignment','top','fontsize',14)
xl=xlim;
yl=ylim;
text(xl(1),yl(2),'(c)','HorizontalAlignment','left','VerticalAlignment','top','fontsize',14)
title("Seasonal model")
caxis([-62.5 62.5])
c1=parula;%colorcet('R3');%read_nclcmp("BlueRed1.rgb");
colormap(c1(1:229,:));

axes('Units','normalized','Position',[0.5 0.08 0.35 0.43],'Layer','top')
scatter(teobs(1:length(Henson12_index)),tesample_nowicki(1:length(Henson12_index)),100,Latsample,'square');
hold on;
scatter(teobs(length(Henson12_index)+1:length(Henson12_index)+length(Marsay_index)),tesample_nowicki(length(Henson12_index)+1:length(Henson12_index)+length(Marsay_index)),80,Latsample2,'diamond');
xlim([0 0.4])
ylim([0 0.4])
plot([0 0.4],[0 0.4],'k--','LineWidth',1)
set(gca,'fontsize',12)
yticklabels("")
text(0.035,yl(2),'R=0.44','HorizontalAlignment','left','VerticalAlignment','top','fontsize',14)
text(xl(1),yl(2),'(d)','HorizontalAlignment','left','VerticalAlignment','top','fontsize',14)
title("Annual model")
hcb=colorbar;
ylabel(hcb,'Latitude','fontsize',14)
hcb.Position(1)=0.9;
caxis([-62.5 62.5])