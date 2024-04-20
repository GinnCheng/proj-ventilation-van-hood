%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% function to plot xy plane data
 %  coded by ginn
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function func_to_plot_xy_plane_data(data_xy_org)
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

%% contour levels
% levels  = unique(cat(2,linspace(-0.03,0.05,10),linspace(0.05,0.1,10),linspace(0.1,0.7,10)));
colorRange = unique(cat(2,linspace(0.001,0.2,40)));

%%% remove y below 1.05
[indx,~,~] = find(data_xy_org(:,2) < 1.05);
data_xy_org(indx,:) = [];

%%% get the boundary of the two clips
x_xy        = data_xy_org(:,1);
y_xy        = data_xy_org(:,2);
k_xy        = boundary(x_xy,y_xy,0.5);
plot(x_xy(k_xy),y_xy(k_xy),'k-','linewidth',2)

%%% make the data on the boundary zero
data_xy_org(k_xy,4:6) = 0;

data_xy_tot = zeros(size(data_xy_org,1) + size(k_xy,1),size(data_xy_org,2));
data_xy_tot(1:size(data_xy_org,1),:) = data_xy_org;
data_xy_tot(size(data_xy_org,1)+1:end,1) = x_xy(k_xy);
data_xy_tot(size(data_xy_org,1)+1:end,2) = y_xy(k_xy);
data_xy_tot(size(data_xy_org,1)+1:end,3) = data_xy_org(1,3);

%%% fill in the data with the boundary

[xq,yq] = meshgrid(linspace(-0.14,1,200),linspace(1,2.24,200));
Umag_xy = sqrt(data_xy_tot(:,4).^2 + data_xy_tot(:,5).^2 + data_xy_tot(:,6).^2);
Func    = scatteredInterpolant(data_xy_tot(:,1),data_xy_tot(:,2),Umag_xy);
vq      = Func(xq,yq);
h = contourf(xq,yq,vq,colorRange,'color','black','linestyle','none','linewidth',1.2);

hold on

axis tight

xlabel('$x\left(m\right)$','fontsize',12,'Interpreter','latex')
ylabel('$y\left(m\right)$','fontsize',12,'Interpreter','latex')

caxis([colorRange(1) colorRange(end)])
colormap(CmapRandB);
axis([-0.2 1.05 1 2.4])
set(gca,'xtick',[-0.2:0.2:1],'xticklabel',[-0.2:0.2:1] + 0.2)
set(gca,'ytick',[1 1.5 2 2.5],'yticklabel',[1 1.5 2 2.5] - 1)
% set(gcf,'linestyle','none')
% daspect([1 1 1])

end