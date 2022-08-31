clear
clc
load('E:\GREB\data\Accuracy\Natural_breakpoint_atsurf_5class.mat');
IMPM_T_5 = Correct_rate'
load('E:\GREB\data\Accuracy\Natural_breakpoint_atsurf_7class.mat');
IMPM_T_7 = Correct_rate'
load('E:\GREB\data\Accuracy\Natural_breakpoint_atsurf_9class.mat');
IMPM_T_9 = Correct_rate'
load('E:\GREB\data\Accuracy\original_atsurf_5class.mat');
GREB_T_5 = Correct_rate'
load('E:\GREB\data\Accuracy\original_atsurf_7class.mat');
GREB_T_7 = Correct_rate'
load('E:\GREB\data\Accuracy\original_atsurf_9class.mat');
GREB_T_9 = Correct_rate'
load('E:\GREB\data\Accuracy\Natural_breakpoint_aosurf_5class.mat');
IMPM_A_5 = Correct_rate'
load('E:\GREB\data\Accuracy\Natural_breakpoint_aosurf_7class.mat');
IMPM_A_7 = Correct_rate'
load('E:\GREB\data\Accuracy\Natural_breakpoint_aosurf_9class.mat');
IMPM_A_9 = Correct_rate'
load('E:\GREB\data\Accuracy\original_aosurf_5class.mat');
GREB_A_5 = Correct_rate'
load('E:\GREB\data\Accuracy\original_aosurf_7class.mat');
GREB_A_7 = Correct_rate'
load('E:\GREB\data\Accuracy\original_aosurf_9class.mat');
GREB_A_9 = Correct_rate'
% % 
% % DSCM_T_5 = mean(DSCMT5,2);
% % DSCM-T-7 = mean(DSCMT7,2);
% % DSCM-T-9 = mean(DSCMT9,2);
% % GREB-T-5 = mean(GREBT5,2);
% % GREB-T-7 = mean(GREBT7,2);
% % GREB-T-9 = mean(GREBT9,2);
% % DSCM-A-5 = mean(DSCMA5,2);
% % DSCM-A-7 = mean(DSCMA7,2);
% % DSCM-A-9 = mean(DSCMA9,2);
% % GREB-A-5 = mean(GREBA5,2);
% % GREB-A-7 = mean(GREBA7,2);
% % GREB-A-9 = mean(GREBA9,2);
% 
tiledlayout(1,2);

nexttile
plot(mean(IMPM_T_5,2),'r');

hold on;
plot(mean(IMPM_T_7,2),'g');
hold on;
plot(mean(IMPM_T_9,2),'b');
hold on;
plot(mean(GREB_T_5,2),'--r');
hold on;
plot(mean(GREB_T_7,2),'--g');
hold on;
plot(mean(GREB_T_9,2),'--b');
hold on;
set(gca,'xtick',[1 16 32 48] ,'xticklabel',{'90°N','30°N','30°S','90°S'},'fontsize',8, 'fontname','Times New Roman','tickdir','out');
set(gca,'YGrid','on','YTick',[0 0.2 0.4 0.6 0.8 1],...
    'YTickLabel',{'0','0.2','0.4','0.6','0.8','1'},'ZGrid','on','XGrid','off')

legend1 = legend('IMPM-T-5','IMPM-T-7','IMPM-T-9','GREB-T-5','GREB-T-7','GREB-T-9');
set(legend1,'Orientation','vertical','NumColumns',2,...
    'Location','southoutside',...
    'Interpreter','latex',...
    'FontSize',8,...
    'EdgeColor',[1 1 1]);
box off
 xlabel('Latitude','FontSize',8,...
     'Interpreter','latex');
ylabel('Accuracy','FontSize',8,...
  'Interpreter','latex');
title('(a)')

nexttile
plot(mean(IMPM_A_5,2),'r');
hold on;
plot(mean(IMPM_A_7,2),'g');
hold on;
plot(mean(IMPM_A_9,2),'b');
hold on;
plot(mean(GREB_A_5,2),'--r');
hold on;
plot(mean(GREB_A_7,2),'--g');
hold on;
plot(mean(GREB_A_9,2),'--b');
hold on;
set(gca,'xtick',[1 16 32 48] ,'xticklabel',{'90°N','30°N','30°S','90°S'},'fontsize',8, 'fontname','Times New Roman','tickdir','out');
 set(gca,'YGrid','on','YTick',[0 0.2 0.4 0.6 0.8 1],...
    'YTickLabel',{'0','0.2','0.4','0.6','0.8','1'},'ZGrid','on','XGrid','off')

xlabel('Latitude','FontSize',8,...
     'Interpreter','latex');
ylabel('Accuracy','FontSize',8,...
  'Interpreter','latex');

% legend('IMPMA5','IMPMA7','IMPMA9','GREBA5','GREBA7','GREBA9',...
% 'location','Southout','FontSize',6)
legend2 = legend('IMPM-A-5','IMPM-A-7','IMPM-A-9','GREB-A-5','GREB-A-7','GREB-A-9');
set(legend2,'Orientation','vertical','NumColumns',2,...
    'Location','southoutside',...
    'Interpreter','latex',...
    'FontSize',8,...
    'EdgeColor',[1 1 1]);
box off
title('(b)')

set(gcf,'unit','centimeters','position',[10,10,17.6,5.5])

% hold on;
% plot(DSCM-T-7);
% hold on;





