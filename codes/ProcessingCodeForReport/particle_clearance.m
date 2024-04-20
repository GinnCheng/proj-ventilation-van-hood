%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% script to plot particles clearance
 %  coded by ginn
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; close all; clc;
addpath('D:\kevinProject\postProcessing\00function')
folder_loc  = 'D:\kevinProject\suction_phase\';
higher_loc  = 'nas_fan_inc';
lower80_loc = 'nas_fan_loflo_80';
lower67_loc = 'nas_fan_loflo_67';
lower50_loc = 'nas_fan_loflo_50';
%% get the number of particles
[t,num_floating_org,num_remain_org,num_suction_org] = countFloatingParticles(folder_loc,higher_loc);
[~,num_floating_80,num_remain_80,num_suction_80]    = countFloatingParticles(folder_loc,lower80_loc);
[~,num_floating_67,num_remain_67,num_suction_67]    = countFloatingParticles(folder_loc,lower67_loc);
[~,num_floating_50,num_remain_50,num_suction_50]    = countFloatingParticles(folder_loc,lower50_loc);

t = t-60;
%% now plot the number of particles decays
% figure
percentage_particles_org = num_remain_org./num_floating_org(1);
percentage_particles_80  = num_remain_80./num_floating_80(1);
percentage_particles_67  = num_remain_67./num_floating_67(1);
percentage_particles_50  = num_remain_50./num_floating_50(1);
% plot(t,percentage_particles_org,'color',[0 0 0],'linestyle','-','linewidth',1.2)
% hold on
% plot(t,percentage_particles_80,'color',[1 0 0],'linestyle','-','linewidth',1.2)
% plot(t,percentage_particles_67,'color',[0 0 1],'linestyle','-','linewidth',1.2)
% plot(t,percentage_particles_50,'color',[0.5 0.5 0.5],'linestyle','-','linewidth',1.2)
% xlabel('$t\left(s\right)$','Interpreter','latex')
% ylabel('$C/C_{0}\left(\%\right)$','Interpreter','latex')
% yticks([0:0.2:1])
% yticklabels({'0%','20%','40%','60%','80%','100%'})
% % print(gcf,'C:\Users\Gene\Dropbox\ventilation hood project\figures\suction_particles','-dpng','-r1200');
%% now plot the comparison between each loads with the baseline
% figure
% diff_particles_80  = abs(num_remain_80./num_floating_80(1) - num_remain_org./num_floating_org(1));
% diff_particles_67  = abs(num_remain_67./num_floating_67(1) - num_remain_org./num_floating_org(1));
% diff_particles_50  = abs(num_remain_50./num_floating_50(1) - num_remain_org./num_floating_org(1));
% hold on
% plot(t,diff_particles_80,'k-','linewidth',1.2)
% plot(t,diff_particles_67,'r-','linewidth',1.2)
% plot(t,diff_particles_50,'b-','linewidth',1.2)
% 
% xlabel('$t\left(s\right)$','Interpreter','latex')
% ylabel('$C/C_{0}\left(\%\right)$','Interpreter','latex')
% yticks([0:0.02:0.1])
% yticklabels({'0%','2%','4%','6%','8%','10%'})
% set(gca,'ylim',[0 0.11])
% % print(gcf,'C:\Users\Gene\Dropbox\ventilation hood project\figures\suction_particles_diff','-dpng','-r1200');

%% plot the decay vs. fan rate at each clearance rate
time_clearance_vs_fan_rate(t,percentage_particles_50,percentage_particles_67,percentage_particles_80,percentage_particles_org)
print(gcf,'C:\Users\Gene\Dropbox\ventilation hood project\figures\DecayFitting_vs_fan_rate','-dpng','-r1200');