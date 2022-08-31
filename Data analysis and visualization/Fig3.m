clc
clear

tiledlayout(1,3);

nexttile
load('E:\GREB\data\Accuracy\Natural_breakpoint_aosurf_5class')
[x,y,z,v] = flow;
sx = linspace(min(min(min(x)))+1.5,max(max(max(x))),5);
sy = [1,-1]; sz = [1,-1];
slice(x,y,z,v,sx,sy,sz);
shading interp;
colormap  GRAY
%%96*48 figure
for i=1:48
    for j=1:96
        for k=1:80
            lon(i,j,k) =j;
            lat(i,j,k) =i;
            time(i,j,k)=k;
        end
    end
end
a1 =rot90(pre_result_degree(:,:,:));
% [lon,lat,time,a1] = flow;
sx = linspace(min(min(min(lon))),max(max(max(lon))),7);
sy = linspace(min(min(min(lat))),max(max(max(lat))),4); 
sz = linspace(min(min(min(time))),max(max(max(time))),4);
slice(lon,lat,time,a1,sx,sy,sz);
set(gca,'ytick',[8 24 40] ,'yticklabel',{'60°N','0','60°S'},'fontsize',8,'fontname','Times New Roman','tickdir','out');
 xtickangle(0)
set(gca,'xtick',[12 48 84] ,'xticklabel',{'30°E','180°','30°W'},'fontsize',8,'fontname','Times New Roman','tickdir','out');
set(gca,'ztick',[0 20 40 60 80] ,'zticklabel',{'0','20','40','60','80'},'fontsize',8,'fontname','Times New Roman','tickdir','out');ytickangle(0)
title('(a)')

zlabel('Seasons','Interpreter','latex');
% ylabel('Lititude','VerticalAlignment','baseline','Interpreter','latex','rotation',330,'fontsize',8,'position',[-15 20 -25]);
% xlabel('longtitude','VerticalAlignment','baseline','Interpreter','latex',...
%     'HorizontalAlignment','left',...
%     'rotation',15,'fontsize',8,'position',[30 -8 -27]);
shading interp;
colormap jet
colorbar('southoutside','TickLabelInterpreter','latex');



nexttile
load('E:\GREB\data\Accuracy\Natural_breakpoint_aosurf_7class')
[x,y,z,v] = flow;
sx = linspace(min(min(min(x)))+1.5,max(max(max(x))),5);
sy = [1,-1]; sz = [1,-1];
slice(x,y,z,v,sx,sy,sz);
shading interp;
colormap  GRAY
%%96*48 figure
for i=1:48
    for j=1:96
        for k=1:80
            lon(i,j,k) =j;
            lat(i,j,k) =i;
            time(i,j,k)=k;
        end
    end
end
a1 =rot90(pre_result_degree(:,:,:));
% [lon,lat,time,a1] = flow;
sx = linspace(min(min(min(lon))),max(max(max(lon))),7);
sy = linspace(min(min(min(lat))),max(max(max(lat))),4); 
sz = linspace(min(min(min(time))),max(max(max(time))),4);
slice(lon,lat,time,a1,sx,sy,sz);
set(gca,'ytick',[8 24 40] ,'yticklabel',{'60°N','0','60°S'},'fontsize',8,'fontname','Times New Roman','tickdir','out');
 xtickangle(0)
set(gca,'xtick',[12 48 84] ,'xticklabel',{'30°E','180°','30°W'},'fontsize',8,'fontname','Times New Roman','tickdir','out');
set(gca,'ztick',[0 20 40 60 80] ,'zticklabel',{'0','20','40','60','80'},'fontsize',8,'fontname','Times New Roman','tickdir','out');ytickangle(0)
title('(b)')
zlabel('Seasons','Interpreter','latex');
shading interp;
colormap jet
colorbar('southoutside','Ticks',[1 2 3 4 5 6 7],'TickLabelInterpreter','latex');

nexttile
load('E:\GREB\data\Accuracy\Natural_breakpoint_aosurf_9class')
[x,y,z,v] = flow;
sx = linspace(min(min(min(x)))+1.5,max(max(max(x))),5);
sy = [1,-1]; sz = [1,-1];
slice(x,y,z,v,sx,sy,sz);
shading interp;
colormap  GRAY
%%96*48 figure
for i=1:48
    for j=1:96
        for k=1:80
            lon(i,j,k) =j;
            lat(i,j,k) =i;
            time(i,j,k)=k;
        end
    end
end
a1 =rot90(pre_result_degree(:,:,:));
% [lon,lat,time,a1] = flow;
sx = linspace(min(min(min(lon))),max(max(max(lon))),7);
sy = linspace(min(min(min(lat))),max(max(max(lat))),4); 
sz = linspace(min(min(min(time))),max(max(max(time))),4);
slice(lon,lat,time,a1,sx,sy,sz);
set(gca,'ytick',[8 24 40] ,'yticklabel',{'60°N','0','60°S'},'fontsize',8,'fontname','Times New Roman','tickdir','out');
 xtickangle(0)
set(gca,'xtick',[12 48 84] ,'xticklabel',{'30°E','180°','30°W'},'fontsize',8,'fontname','Times New Roman','tickdir','out');
set(gca,'ztick',[0 20 40 60 80] ,'zticklabel',{'0','20','40','60','80'},'fontsize',8,'fontname','Times New Roman','tickdir','out');ytickangle(0)
title('(c)')
zlabel('Seasons','Interpreter','latex');
shading interp;
colormap jet
colorbar('southoutside','Ticks',[1 2 3 4 5 6 7 8 9],'TickLabelInterpreter','latex');


% set(get(cb,'title'),'string','Accuracy','FontSize',8);
set(gcf,'unit','centimeters','position',[10,10,17.6,5.5])
