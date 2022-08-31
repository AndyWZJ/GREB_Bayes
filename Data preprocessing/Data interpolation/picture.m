

clc
clear
%Draw a three -dimensional slice chart
%Case
%%
load('D:\Learning_file\dockingwork\bayes_matlab_demo\pre_result_degree')
[x,y,z,v] = flow;
sx = linspace(min(min(min(x)))+1.5,max(max(max(x))),5);
sy = [1,-1]; sz = [1,-1];
slice(x,y,z,v,sx,sy,sz);
shading interp;
colormap  GRAY
%%96*48µÄÍ¼
for i=1:96
    for j=1:48
        for k=1:80
            lon(i,j,k) =j;
            lat(i,j,k) =i;
            time(i,j,k)=k;
        end
    end
end
a1 =pre_result_degree(:,:,:);
% [lon,lat,time,a1] = flow;
sx = linspace(min(min(min(lon))),max(max(max(lon))),7);
sy = linspace(min(min(min(lat))),max(max(max(lat))),4); 
sz = linspace(min(min(min(time))),max(max(max(time))),4);
slice(lon,lat,time,a1,sx,sy,sz);
shading interp;
colormap  GRAY
colorbar


%%
%%48*96 figure 
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
shading interp;
colormap jet


%%
%Call color
colormap(Mymap);
%Save custom color
mymap = colormap;%gcf is abbreviation of get current figureµÄËõÐ´
save('Mymap','Mymap');%Save the MyMap variable as mycolorMaps.Mat, position in the MATLAB current directory
%%
%Condition probability table
%They are the Asian Europe, the African sector, the Indian Ocean, the Pacific sector, the American section, and the Antarctica plate
place1=[8,24];place2=[19,6];place3=[35,16];place4=[24,56];place5=[14,72];place6=[46,16];
%Read the condition probability table and draw pictures
table =rot90(result_probability_table);
%%%
place7=[7,1];
place=place7;   %Every time you can modify 1, 2, 3 to draw different sectors
place_table=table{place(1),place(2)};
imagesc(place_table); %# Create a colored plot of the matrix values
colormap(flipud(gray)); %# Change the colormap to gray (so higher values are
%%

%Statistics non -0 number
table=rot90(result_probability_table);
for i=1:48
    for j=1:96
        tongji(i,j)=length(nonzeros(table{i,j}));
    end
end