clear
clc
load('E:\GREB\data\Accuracy\Natural_breakpoint_atsurf_5class.mat');
IMPMT5 = Correct_rate'
load('E:\GREB\data\Accuracy\Natural_breakpoint_atsurf_7class.mat');
IMPMT7 = Correct_rate'
load('E:\GREB\data\Accuracy\Natural_breakpoint_atsurf_9class.mat');
IMPMT9 = Correct_rate'
load('E:\GREB\data\Accuracy\original_atsurf_5class.mat');
GREBT5 = Correct_rate'
load('E:\GREB\data\Accuracy\original_atsurf_7class.mat');
GREBT7 = Correct_rate'
load('E:\GREB\data\Accuracy\original_atsurf_9class.mat');
GREBT9 = Correct_rate'
load('E:\GREB\data\Accuracy\Natural_breakpoint_aosurf_5class.mat');
IMPMA5 = Correct_rate'
load('E:\GREB\data\Accuracy\Natural_breakpoint_aosurf_7class.mat');
IMPMA7 = Correct_rate'
load('E:\GREB\data\Accuracy\Natural_breakpoint_aosurf_9class.mat');
IMPMA9 = Correct_rate'
load('E:\GREB\data\Accuracy\original_aosurf_5class.mat');
GREBA5 = Correct_rate'
load('E:\GREB\data\Accuracy\original_aosurf_7class.mat');
GREBA7 = Correct_rate'
load('E:\GREB\data\Accuracy\original_aosurf_9class.mat');
GREBA9 = Correct_rate'

% axes1 = axes('Parent',Parent1);
% hold(axes1,'on');
% 
% bar1 = bar(ymatrix1,'Parent',axes1);
% set(bar1(4),'DisplayName','IMPM-T');
% set(bar1(3),'DisplayName','GREB-T');
% set(bar1(2),'DisplayName','IMPM-A');
% set(bar1(1),'DisplayName','GREB-A');
% 
% datatip(bar1(3),'DataIndex',3);
% 
% set(axes1,'ContextMenu','TickLabelInterpreter','latex','XTick',[1 2 3],...
%     'XTickLabel',{'5','7','9'});
y=[mean(mean(IMPMT5)) mean(mean(GREBT5)) mean(mean(IMPMA5)) mean(mean(GREBA5)); mean(mean(IMPMT7)) mean(mean(GREBT7)) mean(mean(IMPMA7)) mean(mean(GREBA7));mean(mean(IMPMT9)) mean(mean(GREBT9)) mean(mean(IMPMA9)) mean(mean(GREBA9));]
b=bar(y);
grid on;
ch = get(b,'children');
set(gca,'XTickLabel',{'5','7','9'})
set(gca,'TickLabelInterpreter','latex')
set(gca,'YGrid','on','YTick',[0 0.2 0.4 0.6 0.8 1],...
    'YTickLabel',{'0','0.2','0.4','0.6','0.8','1'},'ZGrid','on','XGrid','off')

% set(ch,'FaceVertexCData',[1 0 1;0 0 0;])
legend1 = legend('IMPM-T','GREB-T','IMPM-A','GREB-A');
set(legend1,'Orientation','vertical','NumColumns',1,...
    'Interpreter','latex',...
    'Location','northeastoutside',...
    'FontSize',8,...
    'EdgeColor',[1 1 1]);
 xlabel('State Classification','FontSize',10,...
      'Interpreter','latex');
 ylabel('Accuracy','FontSize',10,...
  'Interpreter','latex');
 box off
 set(gcf,'unit','centimeters','position',[10,10,17.6,4])

