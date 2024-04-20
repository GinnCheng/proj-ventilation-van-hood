%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% script to plot particles clearance
 %  coded by ginn
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; close all; clc;
addpath('D:\kevinProject\postProcessing\00function')
folder_loc  = 'D:\kevinProject\dispersion\';
case_loc    = 'nas_flat_cub';

%% get the number of particles
%%% select section
xlim = [-2 2];
ylim = [0 3];
zlim = [2 4];
[t,num_floating,tot_num_par,num_in_region] = arbitraryLocCountFloatingParticles(folder_loc,case_loc,xlim,ylim,zlim);
t = t-1000;
%% now plot the number of particles decays
figure
percentage_particles = tot_num_par;
semilogy(t, percentage_particles)
hold on
semilogy(t, num_floating)
% axis([0 1500 1 10^8])

%% plot the decay vs. fan rate at each clearance rate
% time_clearance_vs_fan_rate(t,percentage_particles_50,percentage_particles_67,percentage_particles_80,percentage_particles_org)
% print(gcf,'C:\Users\Gene\Dropbox\ventilation hood project\figures\DecayFitting_vs_fan_rate','-dpng','-r1200');