%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% function to plot velocity on yz plane
 %  coded by ginn
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function func_to_plot_yz_plane_data(data_yz_org)
%% colormap
%%% blue
CmapArray       = linspace(0,1,20)';
CmapBlue        = cat(2,CmapArray,CmapArray,ones(size(CmapArray)));
CmapUltraBlue   = cat(2,zeros(size(CmapArray)),zeros(size(CmapArray)),CmapArray);
CmapUltraBlue   = CmapUltraBlue([end-8:end-2],:);
%%% red
CmapArray       = flip(CmapArray);
CmapRed         = cat(2,ones(size(CmapArray)),CmapArray,CmapArray);
CmapUltraRed    = cat(2,CmapArray,zeros(size(CmapArray)),zeros(size(CmapArray)));
CmapUltraRed    = CmapUltraRed([2:8],:);
%%% together
CmapRandB       = cat(1,CmapUltraBlue,CmapBlue,CmapRed([2:end],:),CmapUltraRed);

%%% contour levels
% levels  = unique(cat(2,linspace(-0.18,0.05,10),linspace(0.05,0.1,10),linspace(0.1,2.2,30)));
colorRange = unique(cat(2,linspace(1e-6,1.5,40)));

%%% remove y below 1.05 (for xy plane)
% [indx,~,~] = find(data_yz_org(:,2) < 1.05);
% data_yz_org(indx,:) = [];

%%% get the boundary of the two clips
y_yz        = data_yz_org(:,2);
z_yz        = data_yz_org(:,3);
k_yz        = boundary(y_yz,z_yz,1);
plot(z_yz(k_yz),y_yz(k_yz),'k-','linewidth',2)

%%% make the data on the boundary zero
data_yz_org(k_yz,4:6) = 0;

data_yz_tot = zeros(size(data_yz_org,1) + size(k_yz,1),size(data_yz_org,2));
data_yz_tot(1:size(data_yz_org,1),:) = data_yz_org;
data_yz_tot(size(data_yz_org,1)+1:end,1) = data_yz_org(1,1);
data_yz_tot(size(data_yz_org,1)+1:end,2) = y_yz(k_yz);
data_yz_tot(size(data_yz_org,1)+1:end,3) = z_yz(k_yz);

%%% plot the contour
[zq,yq] = meshgrid(linspace(2,3.5,200),linspace(1,2.25,200));
Umag_yz = sqrt(data_yz_tot(:,4).^2 + data_yz_tot(:,5).^2 + data_yz_tot(:,6).^2);
Func    = scatteredInterpolant(data_yz_tot(:,3),data_yz_tot(:,2),Umag_yz);
vq      = Func(zq,yq);
h = contourf(zq,yq,vq,colorRange,'color','black','linestyle','none','linewidth',1.2);

hold on

%%% get the boundary of the two clips

axis tight

caxis([colorRange(1) colorRange(end)])
colormap(CmapRandB);
axis([2 3.6 1 2.3])
set(gca,'xtick',[2 2.5 3 3.5],'xticklabel',[2 2.5 3 3.5] - 2)
set(gca,'ytick',[1 1.5 2 2.5],'yticklabel',[1 1.5 2 2.5] - 1)
% set(gcf,'linestyle','none')
% daspect([1 1 1])

xlabel('$z\left(m\right)$','fontsize',12,'Interpreter','latex')
ylabel('$y\left(m\right)$','fontsize',12,'Interpreter','latex')
end