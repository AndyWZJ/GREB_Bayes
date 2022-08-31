clear
clc
load('E:\GREB\data\Accuracy\Natural_breakpoint_atsurf_5class.mat');
DSCM5 = Correct_rate'
load('E:\GREB\data\Accuracy\Natural_breakpoint_atsurf_7class.mat');
DSCM7 = Correct_rate'
load('E:\GREB\data\Accuracy\Natural_breakpoint_atsurf_9class.mat');
DSCM9 = Correct_rate'
load('E:\GREB\data\Accuracy\original_atsurf_5class.mat');
GREB5 = Correct_rate'
load('E:\GREB\data\Accuracy\original_atsurf_7class.mat');
GREB7 = Correct_rate'
load('E:\GREB\data\Accuracy\original_atsurf_9class.mat');
GREB9 = Correct_rate'

tiledlayout(2,3);

nexttile
% subplot(2,3,1)
imagesc(DSCM5)
colormap(jet);
caxis([0 1])
set(gca,'ytick',[1 16 32 48] ,'yticklabel',{'90°N','30°N','30°S','90°S'},'fontsize',8, 'fontname','Times New Roman','tickdir','out');
set(gca,'xtick',[1 24 48 72 96] ,'xticklabel',{'0°','90°E','180°','90°W','0°'},'fontsize',8, 'fontname','Times New Roman','tickdir','out');
% title('(a)','position',[48,64])
title('(a)')



nexttile
% subplot(2,3,2)
imagesc(DSCM7)
colormap(jet);
caxis([0 1])
set(gca,'ytick',[1 16 32 48] ,'yticklabel',{'90°N','30°N','30°S','90°S'},'fontsize',8, 'fontname','Times New Roman','tickdir','out');
set(gca,'xtick',[1 24 48 72 96] ,'xticklabel',{'0°','90°E','180°','90°W','0°'},'fontsize',8, 'fontname','Times New Roman','tickdir','out');
title('(b)')

nexttile
% subplot(2,3,3)
imagesc(DSCM9)
colormap(jet);
caxis([0 1])
set(gca,'ytick',[1 16 32 48] ,'yticklabel',{'90°N','30°N','30°S','90°S'},'fontsize',8, 'fontname','Times New Roman','tickdir','out');
set(gca,'xtick',[1 24 48 72 96] ,'xticklabel',{'0°','90°E','180°','90°W','0°'},'fontsize',8, 'fontname','Times New Roman','tickdir','out');
title('(c)')

nexttile
% subplot(2,3,4)
imagesc(GREB5)
colormap(jet);
caxis([0 1])
set(gca,'ytick',[1 16 32 48] ,'yticklabel',{'90°N','30°N','30°S','90°S'},'fontsize',8, 'fontname','Times New Roman','tickdir','out');
set(gca,'xtick',[1 24 48 72 96] ,'xticklabel',{'0°','90°E','180°','90°W','0°'},'fontsize',8, 'fontname','Times New Roman','tickdir','out');
title('(d)')

nexttile
% subplot(2,3,5)
imagesc(GREB7)
colormap(jet);
caxis([0 1])
set(gca,'ytick',[1 16 32 48] ,'yticklabel',{'90°N','30°N','30°S','90°S'},'fontsize',8, 'fontname','Times New Roman','tickdir','out');
set(gca,'xtick',[1 24 48 72 96] ,'xticklabel',{'0°','90°E','180°','90°W','0°'},'fontsize',8, 'fontname','Times New Roman','tickdir','out');
title('(e)')

nexttile
% subplot(2,3,6)
imagesc(GREB9)
colormap(jet);
caxis([0 1])

set(gca,'ytick',[1 16 32 48] ,'yticklabel',{'90°N','30°N','30°S','90°S'},'fontsize',8, 'fontname','Times New Roman','tickdir','out');
set(gca,'xtick',[1 24 48 72 96] ,'xticklabel',{'0°','90°E','180°','90°W','0°'},'fontsize',8, 'fontname','Times New Roman','tickdir','out');
title('(f)')


% colorbar('location','South')
cb = colorbar;
cb.Layout.Tile = 'east';
set(get(cb,'title'),'string','Accuracy','FontSize',8);

set(gcf,'unit','centimeters','position',[10,10,17.6,6.5])


% Position_Bar = get(cb, 'Position')
% Position_Bar = Position_Bar + [0  -10  0  0 ]     % Set Colorbar to move to the right                                  
% set(cb, 'Position',Position_Bar) % Reset the colorbar position 
% get(cb, 'Position')

