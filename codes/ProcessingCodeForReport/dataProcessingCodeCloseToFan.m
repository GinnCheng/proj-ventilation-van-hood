%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% code for hood simulation postProcessing
 %%%  coded by 
  %   ginn
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; close all; clc;
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

%% read the data
data_dir   = '/media/ginn/storage/kevinProject/postProcessing/';
name_xy    = 'clip_xy_closeToFan00.csv';
name_xy_lo = 'clip_xy_loflo_closeToFan00.csv';

%%% "Q","U:0","U:1","U:2","ddt0(epsilon)","ddt0(k)","epsilon","epsilon_0",
%%% "k","k_0","nut","p","vorticity:0","vorticity:1","vorticity:2","Points:0","Points:1","Points:2"

data_xy    = csvread([data_dir,name_xy],1,0);
data_xy_lo = csvread([data_dir,name_xy_lo],1,0);

%% plot the data
%%% at xy plane
figure%('visible','off')
[xq,yq] = meshgrid(linspace(-0.14,1,100),linspace(1,2.24,100));
Umag_xy = sqrt(data_xy(:,2).^2 + data_xy(:,3).^2);
Func    = scatteredInterpolant(data_xy(:,end-2),data_xy(:,end-1),Umag_xy);
vq      = Func(xq,yq);
levels  = unique(cat(2,linspace(0,0.05,10),linspace(0.05,0.1,10),linspace(0.1,0.26,10)));
contour(xq,yq,vq,levels,'color','red')

hold on

Umag_xy_lo = sqrt(data_xy_lo(:,2).^2 + data_xy_lo(:,3).^2);
Func_lo    = scatteredInterpolant(data_xy_lo(:,end-2),data_xy_lo(:,end-1),Umag_xy_lo);
vq_lo      = Func(xq,yq);
contour(xq,yq,vq_lo,levels,'color','blue','linestyle','--')

xlabel('$x$','Interpreter','latex')
ylabel('$y$','Interpreter','latex')

% print(gcf,'/media/ginn/storage/kevinProject/postProcessing/contourxy_Umagxy','-dpng','-r1200');
