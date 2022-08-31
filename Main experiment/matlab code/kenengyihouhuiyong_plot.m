clear all;
close all;
clc;

pc = pcread('rabbit.pcd');
pcshow(pc);

pc_point = pc.Location;
xlimit = pc.XLimits;
ylimit = pc.YLimits;
zlimit = pc.ZLimits;

cellsize = 0.005;   %Define the grid size
%Set the number of grids
W = floor((xlimit(2) - xlimit(1))/cellsize)+1;
H = floor((ylimit(2) - ylimit(1))/cellsize)+1;
D = floor((zlimit(2) - zlimit(1))/cellsize)+1;

%Fill the grid with numbers
voxel = cell(W,H,D);
for i =1:length(pc_point)
    I = floor((pc_point(i,1)-xlimit(1))/cellsize)+1;
    J = floor((pc_point(i,2)-ylimit(1))/cellsize)+1;
    K = floor((pc_point(i,3)-zlimit(1))/cellsize)+1;
    voxel{I,J,K} = [voxel{I,J,K};pc_point(i,:)];
end

%Downsample the origin point cloud with the first point in the grid
pointre =[];
for i=1:W
    for j=1:H
        for k=1:D
            if isempty(voxel{i,j,k})==0
                pointre=[pointre;voxel{i,j,k}(1,:)];
            end
        end
    end
end
pcre = pointCloud(pointre);

figure;
pcshow(pcre);