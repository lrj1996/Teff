load("TE_model.mat")
load("ocnmasks.mat")

TE1000_1d=reshape(TE1000,[91*180,12]);
PL1d=reshape(PL2d_mon,[91*180,12]);
PS1d=reshape(PS2d_mon,[91*180,12]);
ZL1d=reshape(ZL2d_mon,[91*180,12]);
ZS1d=reshape(ZS2d_mon,[91*180,12]);
POCL_prod1d=reshape(POCL_prod,[91*180,12]);
POCS_prod1d=reshape(POCS_prod,[91*180,12]);
mld1d=reshape(mld,[91*180,12]);

figure('Position',[100 100 800 800]);
ha=tight_subplot(4,2,[0.04 0.02],[0.05 0.04],[0.12 0.2]);

tmp_idx=find((idx2d==1 & regionmsk==1) | (idx2d==1 & regionmsk==2));
tmp_TE=mean(TE1000_1d(tmp_idx,:));
tmp_PL=mean(PL1d(tmp_idx,:));
tmp_PS=mean(PS1d(tmp_idx,:));
tmp_ZL=mean(ZL1d(tmp_idx,:));
tmp_ZS=mean(ZS1d(tmp_idx,:));
tmp_POCL=mean(POCL_prod1d(tmp_idx,:));
tmp_POCS=mean(POCS_prod1d(tmp_idx,:));
tmp_mld=mean(mld1d(tmp_idx,:));

axes(ha(1))
plot(tmp_TE,'LineWidth',1.5,'Color',[0 114 189]/255);
set(gca,'fontsize',12,'box','off','TickLength',[0.03 0.03])
hold on
ylabel("T_{eff} (100m\rightarrow1000m)",'fontsize',14)
xticks([1:1:12])
xticklabels("")
xlim([1 12])
ylim([0.05 0.35])
yticks([0:0.05:0.35])
title(['Subpolar N.H. ',char(8212),' summer max'])
xl=xlim;
yl=ylim;
text(xl(1),yl(2),'(a)','FontSize',12,'FontWeight','bold','HorizontalAlignment','left','VerticalAlignment','top')

axes(ha(3))
yyaxis left
plot([1:12],tmp_POCL./(tmp_POCL+tmp_POCS),'LineWidth',1.5,'Color',[1 0.41 0.16]);hold on;
set(gca,'fontsize',12,'box','off','layer','top','TickLength',[0.03 0.03],'YColor',[1 0.41 0.16])
xlim([1 12])
xticks([1:1:12])
xticklabels("")
ylabel({"fraction of large POC";"in net POC production"},'fontsize',14)
ylim([0 0.5])
yticks([0:0.1:0.5])
%ylim([0 0.15])
%yticks([0:0.05:0.15])
xl=xlim;
yl=ylim;
text(xl(1),yl(2),'(b)','FontSize',12,'FontWeight','bold','HorizontalAlignment','left','VerticalAlignment','top')
yyaxis right
plot([1:12],tmp_PL./(tmp_PL+tmp_PS),'LineWidth',1.5,'Color',[0 0.6 0],'LineStyle','--');hold on;
plot([1:12],tmp_ZL./(tmp_ZL+tmp_ZS),'LineWidth',1.5,'Color',[128, 91, 56]/255,'LineStyle','--');
set(gca,'fontsize',12,'box','off','layer','top','TickLength',[0.03 0.03])
ylim([0 1])
yticks([0:0.25:1])
yticklabels("");
set(gca,'YColor','none')

axes(ha(5))
patch([1,1:12,12],[0,tmp_PL*12,0],[0 0.6 0],'EdgeColor','none');
set(gca,'fontsize',12,'box','off','TickLength',[0.03 0.03],'layer','top');hold on
patch([1:12,12:-1:1],[tmp_PL*12,(tmp_PL(12:-1:1)+tmp_PS(12:-1:1))*12],[0 0.8 0],'EdgeColor','none');
ylabel({"Phytoplankton";"(mg C m^{-2})"},'fontsize',14)
xticks([1:1:12])
xlim([1 12])
xticklabels('');
set(gca,"XTickLabelRotation",0)
yticks([0:1000:4000])
ylim([0 4000])
xl=xlim;
yl=ylim;
text(xl(1),yl(2),'(c)','FontSize',12,'FontWeight','bold','HorizontalAlignment','left','VerticalAlignment','top')

axes(ha(7))
plot([1:12],tmp_mld,'LineWidth',1.5); hold on;
set(gca,'fontsize',12,'box','off','layer','top','TickLength',[0.03 0.03])
plot([1 12],[100 100],'k--','LineWidth',1.5)
xlim([1 12])
xticks([1:1:12])
ylim([0 200])
yticks([0:50:200])
ylabel({"Mixed layer depth";"(m)"})
xticklabels({"J","F","M","A","M","J","J","A","S","O","N","D"});
set(gca,"XTickLabelRotation",0)
xl=xlim;
yl=ylim;
text(xl(1),yl(2),'(d)','FontSize',12,'FontWeight','bold','HorizontalAlignment','left','VerticalAlignment','top')

tmp_idx=find(idx2d==2 & regionmsk==8);
tmp_TE=mean(TE1000_1d(tmp_idx,:));
tmp_PL=mean(PL1d(tmp_idx,:));
tmp_PS=mean(PS1d(tmp_idx,:));
tmp_ZL=mean(ZL1d(tmp_idx,:));
tmp_ZS=mean(ZS1d(tmp_idx,:));
tmp_POCL=mean(POCL_prod1d(tmp_idx,:));
tmp_POCS=mean(POCS_prod1d(tmp_idx,:));
tmp_mld=mean(mld1d(tmp_idx,:));

axes(ha(2))
plot(tmp_TE,'LineWidth',1.5,'Color',[119 172 48]/255);
set(gca,'fontsize',12,'box','off','TickLength',[0.03 0.03])
hold on
xticks([1:1:12])
xticklabels("")
xlim([1 12])
ylim([0.05 0.35])
yticks([0:0.05:0.35])
yticklabels("")
title(['Southern Ocean ',char(8212),' winter max'])
xl=xlim;
yl=ylim;
text(xl(1),yl(2),'(e)','FontSize',12,'FontWeight','bold','HorizontalAlignment','left','VerticalAlignment','top')

axes(ha(4))
yyaxis left
%plot([1:12],tmp_POCL./(tmp_POCL+tmp_POCS),'Color',[1 0.41 0.16],'LineWidth',1.5);
set(gca,'fontsize',12,'box','off','layer','top','TickLength',[0.03 0.03])
xlim([1 12])
xticks([1:1:12])
xticklabels("")
ylim([0 0.5])
yticks([0:0.1:0.5])
%ylim([0 0.15])
%yticks([0:0.05:0.15])
yticklabels("");
set(gca,'YColor','none')
xl=xlim;
yl=ylim;
text(xl(1),yl(2),'(f)','FontSize',12,'FontWeight','bold','HorizontalAlignment','left','VerticalAlignment','top')
yyaxis right
plot([1:12],tmp_PL./(tmp_PL+tmp_PS),'LineWidth',1.5,'Color',[0 0.6 0],'LineStyle','--');;hold on;
%plot([1:12],tmp_ZL./(tmp_ZL+tmp_ZS),'LineWidth',1.5,'Color',[128, 91, 56]/255,'LineStyle','--');
set(gca,'fontsize',12,'box','off','layer','top','TickLength',[0.03 0.03],'YColor',[0 0.6 0])
ylim([0 1])
yticks([0:0.25:1])
ylabel("fraction of large phytoplankton")
pos = get(ha(4), 'Position');
pos(1)=pos(1)+0.11;
ax2 = axes('Position',pos,'Color','none','fontsize',12,'TickLength',[0.03 0.03],'XColor','none','YAxisLocation','right','YColor',[128, 91, 56]/255);
%yyaxis right
ylim([0 1])
yticks([0:0.25:1])
ylabel("fraction of large zooplankton")

axes(ha(6))
p1=patch([1,1:12,12],[0,tmp_PL*12,0],[0 0.6 0],'EdgeColor','none');
set(gca,'fontsize',12,'box','off','TickLength',[0.03 0.03],'layer','top');hold on
p2=patch([1:12,12:-1:1],[tmp_PL*12,(tmp_PL(12:-1:1)+tmp_PS(12:-1:1))*12],[0 0.8 0],'EdgeColor','none');
xticks([1:1:12])
xlim([1 12])
xticklabels('');
set(gca,"XTickLabelRotation",0)
yticks([0:1000:4000])
yticklabels('');
ylim([0 4000])
xl=xlim;
yl=ylim;
text(xl(1),yl(2),'(g)','FontSize',12,'FontWeight','bold','HorizontalAlignment','left','VerticalAlignment','top')
lgd=legend([p1,p2],"Large","Small",'box','off');
lgd.Position(1)=0.82;
lgd.Position(2)=lgd.Position(2)-0.05;

axes(ha(8))
plot([1:12],tmp_mld,'LineWidth',1.5); hold on;
set(gca,'fontsize',12,'box','off','layer','top','TickLength',[0.03 0.03])
plot([1 12],[100 100],'k--','LineWidth',1.5)
xlim([1 12])
xticks([1:1:12])
ylim([0 200])
yticks([0:50:200])
yticklabels("");
xticklabels({"J","F","M","A","M","J","J","A","S","O","N","D"});
set(gca,"XTickLabelRotation",0)
xl=xlim;
yl=ylim;
text(xl(1),yl(2),'(h)','FontSize',12,'FontWeight','bold','HorizontalAlignment','left','VerticalAlignment','top')
