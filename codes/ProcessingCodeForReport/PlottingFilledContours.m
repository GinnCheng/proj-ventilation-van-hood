%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% code for hood simulation postProcessing
 %%%  coded by 
  %   ginn
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; close all; clc;
addpath('D:\kevinProject\postProcessing\00function')
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
func_to_plot_xy_plane_data(data_xy_50)
set(gcf, 'position', [100 100 400 400]) 
print(gcf,'C:\Users\Gene\Dropbox\ventilation hood project\figures\contourxy_U_50','-dpng','-r1200');

%% at yz plane
figure%('visible','off')
func_to_plot_yz_plane_data(data_yz_50)
set(gcf, 'position', [100 100 500 400]) 
print(gcf,'C:\Users\Gene\Dropbox\ventilation hood project\figures\contouryz_U_50','-dpng','-r1200');