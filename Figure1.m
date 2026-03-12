load("TE_model.mat")

Slon=[-100 43;-75 20; 20 145;43 100;145 295;100 295];
Slat= [  0  90;-90  0;-90   0; 0  90;-90   0;  0  90];

lat1=grid.yt;
lon1=-179:2:359;
[lon2,lat2]=meshgrid(lon1,lat1);

figure('Position',[100 100 1200 600]);
axes('Units','normalized','Position',[0.01 0.59 0.5 0.4],'Layer','top')
hold on
mhind=mean(FPOC1000,3)./mean(FPOC100,3);
mhind(ice_month>9)=NaN;
mhind2=[mhind(:,91:180) mhind(:,1:180)];
for l=1:6
    m_proj('mollweide','long',Slon(l,:),'lat',Slat(l,:));
    m_contourf(lon2,lat2,mhind2,[0:0.02:2],'LineStyle','none'); hold on;
    m_grid('fontsize',6,'xticklabels',[],'xtick',[],...
                'ytick',[],'yticklabels',[],'linest','none','color',[.5 .5 .5],'linewidth',0.4)
    m_coast('patch',[0.8 0.8 0.8]);
end
set(gca,'xlim',[-1.25 3.5],'ylim',[-1 1],'fontsize',14);
caxis([0 0.4])
hcb=colorbar("southoutside");
hcb.Position(2)=0.54;
ylabel(hcb,"Annual T_{eff} (100m\rightarrow1000m)")
colormap(jet)
text(-1.05,0.9,'(a)','FontSize',14,'FontWeight','bold')

axes('Units','normalized','Position',[0.49 0.59 0.5 0.4],'Layer','top')
hold on
mhind=max(TE1000,[],3)-min(TE1000,[],3);
mhind(ice_month>9)=NaN;
mhind2=[mhind(:,91:180) mhind(:,1:180)];
for l=1:6
    m_proj('mollweide','long',Slon(l,:),'lat',Slat(l,:));
    m_contourf(lon2,lat2,mhind2,[0:0.01:1],'LineStyle','none'); hold on;
    switch l
        case 5
            m_grid('fontsize',12,'xticklabels',[],'xtick',[],...
                'ytick',[-60:20:0],'yaxislocation','right', 'yticklabelrotation','none','tickdir','out','ticklength',0.02,'linest','none','linewidth',0.4,'color',[.5 .5 .5])
        case 6
            m_grid('fontsize',12,'xticklabels',[],'xtick',[],...
                'ytick',[20:20:60],'yaxislocation','right', 'yticklabelrotation','none','tickdir','out','ticklength',0.02,'linest','none','linewidth',0.4,'color',[.5 .5 .5])
        otherwise
            m_grid('fontsize',12,'xticklabels',[],'xtick',[],...
                'ytick',[],'yticklabels',[],'linest','none','tickdir','out','ticklength',0.02,'linewidth',0.4,'color',[.5 .5 .5])
    end
    m_coast('patch',[0.8 0.8 0.8]);
end
set(gca,'xlim',[-1.25 3.5],'ylim',[-1 1],'fontsize',14);
caxis([0 0.25])
hcb=colorbar("southoutside");
hcb.Position(2)=0.54;
ylabel(hcb,"Seasonal range of T_{eff}")
text(-1.05,0.9,'(b)','FontSize',14,'FontWeight','bold')

axes('Units','normalized','Position',[0.01 0.01 0.5 0.4],'Layer','top')
hold on
mhind=idx2d;
mhind2=[mhind(:,91:180) mhind(:,1:180)];
for l=1:6
    m_proj('mollweide','long',Slon(l,:),'lat',Slat(l,:)); 
    m_pcolor(lon2,lat2,mhind2);hold on;
    m_grid('fontsize',6,'xticklabels',[],'xtick',[],...
                'ytick',[],'yticklabels',[],'linest','none','color',[.5 .5 .5],'linewidth',0.4)
    m_coast('patch',[.8 .8 .8]);
    hold on;
end
set(gca,'xlim',[-1.25 3.5],'ylim',[-1 1],'fontsize',14);
hcb=colorbar("eastoutside");
hcb.Position(1)=0.94;
hcb.Ticks=1.5:3.5;
hcb.TickLabels={'summer\newline   max';'winter\newline max';'     weak\newlineseasonality'};
hcb.Ruler.TickLabelRotation=90;
caxis([1  4])
title(hcb,'Type')
cm=[0 114 189;119 172 48;237 177 32]/255;
colormap(gca,cm)
text(-1.05,0.9,'(c)','FontSize',14,'FontWeight','bold')


axes('Units','normalized','Position',[0.59 0.05 0.32 0.35],'Layer','top')
for i=1:3
    tmp=TE1d(find(idx==i),:);
    plot(0:13,mean(tmp(:,[12,1:12,1])),'Color',cm(i,:),'LineWidth',1.25);hold on;
    set(gca,'fontsize',14);
end
xlim([0.5 12.5])
xticks([0.5:3:12.5])
xticklabels("")
ylim([-0.075 0.075])
yl=ylim;
text(2,yl(1)*1.25,'Winter','fontsize',14,'HorizontalAlignment','center','VerticalAlignment','bottom')
text(5,yl(1)*1.25,'Spring','fontsize',14,'HorizontalAlignment','center','VerticalAlignment','bottom')
text(8,yl(1)*1.25,'Summer','fontsize',14,'HorizontalAlignment','center','VerticalAlignment','bottom')
text(11,yl(1)*1.25,'Fall','fontsize',14,'HorizontalAlignment','center','VerticalAlignment','bottom')
ylabel("Seasonal anamoly of T_{eff}",'fontsize',14)
xl=xlim;
yl=ylim;
text(xl(1),yl(2),'(d)','FontSize',14,'FontWeight','bold','HorizontalAlignment','left','VerticalAlignment','top')