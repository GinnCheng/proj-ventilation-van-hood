clear all; close all; clc;
%% colormap
%%% blue
CmapArray       = linspace(0,1,400)';
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
% CmapRandB       = flip(CmapRandB,1);

%% pcolor a colorbar for xy plane
figure%('visible','off')
colorRange          = linspace(0,3,100);
colorMapBar         = cat(1,colorRange,colorRange);
colorBarPlot        = pcolor(colorRange,[0,1],colorMapBar);
caxis([colorRange(1) colorRange(end)])
colormap(CmapRandB);
axis([colorRange(1) colorRange(end) 0 1])
set(gca,'ytick',[])
set(gca,'xtick',[])
set(colorBarPlot,'linestyle','none')
set(gca,'xtick',[0 3],'xticklabel',[0 0.2],'Fontsize',10)
% xLabel = xlabel('$k^+_1k^+_2\left<\eta\right>^+_{11}$','Fontsize',10,'Interpreter','latex');
% %             set(xLabel, 'Units', 'Normalized', 'Position', [0.5, -0.115, 0]); 

xLabel = xlabel('$\left|\bar{U}\right| \left(m/s\right)$','Fontsize',10,'Interpreter','latex');
            set(xLabel, 'Units', 'Normalized', 'Position', [0.5, -0.115, 0]); 

shading interp
set(gcf, 'position', [100 100 500 50])
print(gcf,'D:\kevinProject\postProcessing\00figures\colorBar_xy','-dpng','-r1200');

%% pcolor a colorbar for yz plane
figure%('visible','off')
colorRange          = linspace(0,3,100);
colorMapBar         = cat(1,colorRange,colorRange);
colorBarPlot        = pcolor(colorRange,[0,1],colorMapBar);
caxis([colorRange(1) colorRange(end)])
colormap(CmapRandB);
axis([colorRange(1) colorRange(end) 0 1])
set(gca,'ytick',[])
set(gca,'xtick',[])
set(colorBarPlot,'linestyle','none')
set(gca,'xtick',[0 3],'xticklabel',[0 1.5],'Fontsize',10)
% xLabel = xlabel('$k^+_1k^+_2\left<\eta\right>^+_{11}$','Fontsize',10,'Interpreter','latex');
% %             set(xLabel, 'Units', 'Normalized', 'Position', [0.5, -0.115, 0]); 

xLabel = xlabel('$\left|\bar{U}\right| \left(m/s\right)$','Fontsize',10,'Interpreter','latex');
            set(xLabel, 'Units', 'Normalized', 'Position', [0.5, -0.115, 0]); 

shading interp
set(gcf, 'position', [100 100 500 50]) 
print(gcf,'D:\kevinProject\postProcessing\00figures\colorBar_yz','-dpng','-r1200');
