%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% code for hood simulation postProcessing
 %%%  coded by 
  %   ginn
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; close all; clc;
addpath('D:\kevinProject\postProcessing\00function')
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
data_dir    = 'D:\kevinProject\postProcessing\';
name_xy_org = 'nas_fan_inc\clip_xy.csv';
name_xy_80  = 'nas_fan_loflo_80\clip_xy.csv';
name_xy_67  = 'nas_fan_loflo_67\clip_xy.csv';
name_xy_50  = 'nas_fan_loflo_50\clip_xy.csv';
name_yz_org = 'nas_fan_inc\clip_yz.csv';
name_yz_80  = 'nas_fan_loflo_80\clip_yz.csv';
name_yz_67  = 'nas_fan_loflo_67\clip_yz.csv';
name_yz_50  = 'nas_fan_loflo_50\clip_yz.csv';
%%% "Points:0","Points:1","Points:2","U:0","U:1","U:2","ddt0(epsilon)","ddt0(k)","epsilon","k","nut","p"

data_xy_org = csvread([data_dir,name_xy_org],1,0);
data_xy_80  = csvread([data_dir,name_xy_80],1,0);
data_xy_67  = csvread([data_dir,name_xy_67],1,0);
data_xy_50  = csvread([data_dir,name_xy_50],1,0);

data_yz_org = csvread([data_dir,name_yz_org],1,0);
data_yz_80  = csvread([data_dir,name_yz_80],1,0);
data_yz_67  = csvread([data_dir,name_yz_67],1,0);
data_yz_50  = csvread([data_dir,name_yz_50],1,0);

%% plot the data
%% at xy plane
figure%('visible','off')
%%% contour levels
% levels  = unique(cat(2,linspace(-0.03,0.05,10),linspace(0.05,0.1,10),linspace(0.1,0.7,10)));
levels  = 0.05:0.05:0.1;

[xq,yq] = meshgrid(linspace(-0.14,1,100),linspace(1,2.24,100));
Umag_xy = sqrt(data_xy_org(:,4).^2 + data_xy_org(:,5).^2 + data_xy_org(:,6).^2);
Func    = scatteredInterpolant(data_xy_org(:,1),data_xy_org(:,2),Umag_xy);
vq      = Func(xq,yq);
contour(xq,yq,vq,levels,'color','black','linestyle','-','linewidth',1.2)

hold on

Umag_xy_80 = sqrt(data_xy_80(:,4).^2 + data_xy_80(:,5).^2 + data_xy_80(:,6).^2);
Func_80    = scatteredInterpolant(data_xy_80(:,1),data_xy_80(:,2),Umag_xy_80);
vq_80      = Func_80(xq,yq);
contour(xq,yq,vq_80,levels,'color','red','linestyle','-','linewidth',1.2)

Umag_xy_67 = sqrt(data_xy_67(:,4).^2 + data_xy_67(:,5).^2 + data_xy_67(:,6).^2);
Func_67    = scatteredInterpolant(data_xy_67(:,1),data_xy_67(:,2),Umag_xy_67);
vq_67      = Func_67(xq,yq);
contour(xq,yq,vq_67,levels,'color','blue','linestyle','-','linewidth',1.2)

Umag_xy_50 = sqrt(data_xy_50(:,4).^2 + data_xy_50(:,5).^2 + data_xy_50(:,6).^2);
Func_50    = scatteredInterpolant(data_xy_50(:,1),data_xy_50(:,2),Umag_xy_50);
vq_50      = Func_50(xq,yq);
contour(xq,yq,vq_50,levels,'color','green','linestyle','-','linewidth',1.2)

%%% get the boundary of the two clips
x_xy        = data_xy_org(:,1);
y_xy        = data_xy_org(:,2);
k_xy        = boundary(x_xy,y_xy);
plot(x_xy(k_xy),y_xy(k_xy),'k-','linewidth',2)
axis tight

xlabel('$x\left(m\right)$','fontsize',12,'Interpreter','latex')
ylabel('$y\left(m\right)$','fontsize',12,'Interpreter','latex')

axis([-0.2 1.05 1 2.4])
set(gca,'xtick',[-0.2:0.2:1],'xticklabel',[-0.2:0.2:1] + 0.2)
set(gca,'ytick',[1 1.5 2 2.5],'yticklabel',[1 1.5 2 2.5] - 1)
% set(gcf,'linestyle','none')
% daspect([1 1 1])
set(gcf, 'position', [100 100 400 400]) 
print(gcf,'C:\Users\Gene\Dropbox\ventilation hood project\figures\contourxy_U','-dpng','-r1200');

%% at yz plane
figure%('visible','off')
%%% contour levels
% levels  = unique(cat(2,linspace(-0.18,0.05,10),linspace(0.05,0.1,10),linspace(0.1,2.2,30)));
levels  = 0.25:0.25:1;

[zq,yq] = meshgrid(linspace(2,3.5,100),linspace(1,2.25,100));
Umag_yz = sqrt(data_yz_org(:,4).^2 + data_yz_org(:,5).^2 + data_yz_org(:,6).^2);
Func    = scatteredInterpolant(data_yz_org(:,3),data_yz_org(:,2),Umag_yz);
vq      = Func(zq,yq);
contour(zq,yq,vq,levels,'color','black','linestyle','-','linewidth',1.2)

hold on

Umag_zy_80 = sqrt(data_yz_80(:,4).^2 + data_yz_80(:,5).^2 + data_yz_80(:,6).^2);
Func_80    = scatteredInterpolant(data_yz_80(:,3),data_yz_80(:,2),Umag_zy_80);
vq_80      = Func_80(zq,yq);
contour(zq,yq,vq_80,levels,'color','red','linestyle','-','linewidth',1.2)

Umag_zy_67 = sqrt(data_yz_67(:,4).^2 + data_yz_67(:,5).^2 + data_yz_67(:,6).^2);
Func_67    = scatteredInterpolant(data_yz_67(:,3),data_yz_67(:,2),Umag_zy_67);
vq_67      = Func_67(zq,yq);
contour(zq,yq,vq_67,levels,'color','blue','linestyle','-','linewidth',1.2)

Umag_zy_50 = sqrt(data_yz_50(:,4).^2 + data_yz_50(:,5).^2 + data_yz_50(:,6).^2);
Func_50    = scatteredInterpolant(data_yz_50(:,3),data_yz_50(:,2),Umag_zy_50);
vq_50      = Func_50(zq,yq);
contour(zq,yq,vq_50,levels,'color','green','linestyle','-','linewidth',1.2)

%%% get the boundary of the two clips
y_yz        = data_yz_org(:,2);
z_yz        = data_yz_org(:,3);
k_yz        = boundary(y_yz,z_yz,1);
plot(z_yz(k_yz),y_yz(k_yz),'k-','linewidth',2)
axis tight

xlabel('$z\left(m\right)$','fontsize',12,'Interpreter','latex')
ylabel('$y\left(m\right)$','fontsize',12,'Interpreter','latex')

axis([2 3.6 1 2.3])
set(gca,'xtick',[2 2.5 3 3.5],'xticklabel',[2 2.5 3 3.5] - 2)
set(gca,'ytick',[1 1.5 2 2.5],'yticklabel',[1 1.5 2 2.5] - 1)
% set(gcf,'linestyle','none')
% daspect([1 1 1])
set(gcf, 'position', [100 100 500 400]) 
print(gcf,'C:\Users\Gene\Dropbox\ventilation hood project\figures\contouryz_U','-dpng','-r1200');