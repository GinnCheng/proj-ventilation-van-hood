%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% code the post-process the data of ventilation hood
 %  coded by ginn
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; close all; clc;
addpath('D:\kevinProject\postProcessing\00function')
folder_loc = 'G:\ventilation_hood_project\dispersion\';
case_loc   = 'base_flow';
%% create new coord x = -0.146859,1.0018; y = 1.02913,2.24986; z = 2.12904,3.50368;
x_coord = linspace(-0.2,1.1,200);
y_coord = linspace(1.02913,2.24986,200);
z_coord = 2.3;
[new_coord,mesh_indx] = clip_plane_creator(x_coord,y_coord,z_coord);
yq              = new_coord(:,1);
yq              = yq(mesh_indx);
zq              = new_coord(:,2);
zq              = zq(mesh_indx);
%% reading the cell centres of the mesh
coord      = ofReadingCellCentres(folder_loc,case_loc);
%% find the boundary
cut_loc     = z_coord;
N_cutDir    = 3;
tol_cut_loc = 0.03; %%% tol_cut_loc is the tolerance of the cutting plane
% X_smooth = unique([linspace(2,2.16,50),linspace(2.16,2.5,150)]);
% Y_smooth = linspace(1,3.5,500);
X_smooth = linspace(-0.2,1.1,1000);
Y_smooth = linspace(1.02913,2.24986,1000);
% Y_smooth = unique([linspace(2,2.16,30),linspace(2.16,4,150)]);
[bound_slice, k_bound, indx_in] = ofFindSliceBoundary(coord,cut_loc,N_cutDir,tol_cut_loc,X_smooth,Y_smooth);
%% reading the velocity field from each processors
[U_fin,p_fin] = ofVelocityReading(folder_loc,case_loc);
%% scattered interp
U_mag           = sqrt(U_fin(:,1).^2 + U_fin(:,2).^2 + U_fin(:,3).^2);
[Ux_slice,Func] = ofScatteredInterpolation(coord,U_mag,new_coord);
logic_in        = inpolygon(new_coord(:,1),new_coord(:,2),bound_slice(k_bound,1),bound_slice(k_bound,2));
Ux_slice        = Ux_slice.*logic_in;
Ux_slice        = Ux_slice(mesh_indx);
%% plot the datacontour(mesh_slice,Ux_slice,levels,'color','red','linestyle','--','linewidth',1.2)
%% at yz plane
figure%('visible','off')
%%% contour levels
levels  = unique(cat(2,linspace(0.05,0.1,4),linspace(0.1,2.2,3)));
% levels  = [1,2];
% contour(yq,zq,Ux_slice,levels,'color','red','linestyle','--','linewidth',1.2)
contourf(yq,zq,Ux_slice,levels)
hold on
plot(bound_slice(k_bound,1),bound_slice(k_bound,2),'k-','linewidth',0.8)
% axis tight
% 
% xlabel('$z\left(m\right)$','fontsize',12,'Interpreter','latex')
% ylabel('$y\left(m\right)$','fontsize',12,'Interpreter','latex')
% 
% axis([2 3.6 1 2.3])
% set(gca,'xtick',[2 2.5 3 3.5],'xticklabel',[2 2.5 3 3.5] - 2)
% set(gca,'ytick',[1 1.5 2 2.5],'yticklabel',[1 1.5 2 2.5] - 1)
% % set(gcf,'linestyle','none')
% % daspect([1 1 1])
% set(gcf, 'position', [100 100 500 400]) 
% % % print(gcf,'C:\Users\Gene\Dropbox\ventilation hood project\figures\contouryz_U','-dpng','-r1200');