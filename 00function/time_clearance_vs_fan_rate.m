function time_clearance_vs_fan_rate(t,percentage_particles_50,percentage_particles_67,percentage_particles_80,percentage_particles_org)
%% now plot the time curvature for each one for 33% decay
fan_run_rate   = [0.5 0.67 0.8 1];
t_1rdDecay = zeros(1,4);
[~,indx] = min(abs(percentage_particles_50 - 0.33));
t_1rdDecay(1) = t(indx);
[~,indx] = min(abs(percentage_particles_67 - 0.33));
t_1rdDecay(2) = t(indx);
[~,indx] = min(abs(percentage_particles_80 - 0.33));
t_1rdDecay(3) = t(indx);
[~,indx] = min(abs(percentage_particles_org - 0.33));
t_1rdDecay(4) = t(indx);
%%% fitting
coeff = polyfit(fan_run_rate,t_1rdDecay,10);
fan_rate_exp = linspace(0.1,1,100);
Decay1rd_rate_exp = polyval(coeff,fan_rate_exp);
figure
plot(fan_run_rate,t_1rdDecay,'r^','markersize',8)
hold on
plot(fan_rate_exp,Decay1rd_rate_exp,'r-','linewidth',1.2)
text(0.8,55,'$C/C_{0} = 33\%$','color','r','Interpreter','latex')

%% now plot the time curvature for each one for 50% decay
fan_run_rate   = [0.5 0.67 0.8 1];
t_halfDecay = zeros(1,4);
[~,indx] = min(abs(percentage_particles_50 - 0.5));
t_halfDecay(1) = t(indx);
[~,indx] = min(abs(percentage_particles_67 - 0.5));
t_halfDecay(2) = t(indx);
[~,indx] = min(abs(percentage_particles_80 - 0.5));
t_halfDecay(3) = t(indx);
[~,indx] = min(abs(percentage_particles_org - 0.5));
t_halfDecay(4) = t(indx);
%%% fitting
coeff = polyfit(fan_run_rate,t_halfDecay,10);
fan_rate_exp = linspace(0.1,1,100);
halfDecay_rate_exp = polyval(coeff,fan_rate_exp);
plot(fan_run_rate,t_halfDecay,'b^','markersize',8)
hold on
plot(fan_rate_exp,halfDecay_rate_exp,'b-','linewidth',1.2)
text(0.8,40,'$C/C_{0} = 50\%$','color','b','Interpreter','latex')
% xlabel('$C/C_{0}\left(\%\right)$','Interpreter','latex')
% ylabel('$t\left(s\right)$','Interpreter','latex')
% xticks([0.1:0.1:1])
% xticklabels({'10%','20%','30%','40%','50%','60%','70%','80%','90%','100%'})
% axis([0.1 1 28 40])
% print(gcf,'C:\Users\Gene\Dropbox\ventilation hood project\figures\halfDecayFitting','-dpng','-r1200');
%% now plot the time curvature for each one for 75% decay
t_threeDecay = zeros(1,4);
[~,indx] = min(abs(percentage_particles_50 - 0.25));
t_threeDecay(1) = t(indx);
[~,indx] = min(abs(percentage_particles_67 - 0.25));
t_threeDecay(2) = t(indx);
[~,indx] = min(abs(percentage_particles_80 - 0.25));
t_threeDecay(3) = t(indx);
[~,indx] = min(abs(percentage_particles_org - 0.25));
t_threeDecay(4) = t(indx);

%%% fitting
coeff = polyfit(fan_run_rate,t_threeDecay,10);
fan_rate_exp = linspace(0.1,1,100);
threeDecay_rate_exp = polyval(coeff,fan_rate_exp);

plot(fan_run_rate,t_threeDecay,'k^','markersize',8)
hold on
plot(fan_rate_exp,threeDecay_rate_exp,'k-','linewidth',1.2)
text(0.8,75,'$C/C_{0} = 25\%$','color','k','Interpreter','latex')
xlabel('$Q/Q_{0}\left(\%\right)$','Interpreter','latex')
ylabel('$t\left(s\right)$','Interpreter','latex')
xticks([0.1:0.1:1])
xticklabels({'10%','20%','30%','40%','50%','60%','70%','80%','90%','100%'})
% axis([0.1 1 50 90])