%Find the conditional probability table of surface temperature, atmospheric temperature and atmospheric humidity
load('air_quarter');
load('dswrf_quarter');
load('sst_quarter');
load('shum_quarter');
load('tcdc_quarter');
%Assignment
asurf=air_quarter;
sw_r=dswrf_quarter;
aosurf=sst_quarter;
water_vapor=shum_quarter;
Cloud =tcdc_quarter;
%Turning matrices into 1-dimensional arrays and exporting tables
[x y z]=size(asurf);
asurf_onedim = reshape(asurf,x*y*z,1,1);
sw_r_onedim = reshape(sw_r,x*y*z,1,1);
aosurf_onedim = reshape(aosurf,x*y*z,1,1);
water_vapor_onedim = reshape(water_vapor,x*y*z,1,1);
Cloud_onedim = reshape(Cloud,x*y*z,1,1);
natural_onedim(:,1)=asurf_onedim;
natural_onedim(:,2)=sw_r_onedim;
natural_onedim(:,3)=aosurf_onedim;
natural_onedim(:,4)=water_vapor_onedim;
natural_onedim(:,5)=Cloud_onedim;
[~,variable_num]=size(natural_onedim);
% xlswrite('natural_onedim.xlsx',natural_onedim);


%Read the result of the natural break point
breaks_data =xlsread('Natural_breakpoint_atsurf_5class.xlsx');
%Obtain the grading results for each variable
num_class = length(breaks_data(:,1))-1;
for i=1:variable_num
degree_data_one(:,i)=classification(natural_onedim(:,i),breaks_data(:,i));
end

%%-----------------CPT table conditional probability calculation for each node-------------------------
%There are five variables in total, surface temperature T, solar radiation S, ocean temperature O, water vapor W, and cloudiness C
%Column number
T_num =1;S_num=2;O_num=3;W_num=4;C_num=5;        
%For nodes by serial number
C=1;S=2;O=3;W=4;T=5;
%Organize the variable data needed on the first grid to a top ------ training data
%[~,~,time_num] = size(asurf);
time_num = 40;
degree_data(:,1)=degree_data_one(1:x*y*time_num,1);
degree_data(:,2)=degree_data_one(1:x*y*time_num,2);
degree_data(:,3)=degree_data_one(1:x*y*time_num,3);
degree_data(:,4)=degree_data_one(1:x*y*time_num,4);
degree_data(:,5)=degree_data_one(1:x*y*time_num,5);

%C nodes CPT
for i=1:num_class
P_C(i)=sum(degree_data(:,C_num)==i)/length(degree_data(:,C_num));
end
%S nodes CPT
for i=1:num_class
P_S(i)=sum(degree_data(:,S_num)==i)/length(degree_data(:,S_num));
end
%O nodes CPT
for i=1:num_class
    for j=1:num_class
        position = (degree_data(:,S_num)==i);
        P_O(i,j)=sum(degree_data(position,O_num)==j)/length(degree_data(position,O_num));
    end
end
%W nodes CPT
for i=1:num_class
    for j=1:num_class
        position = (degree_data(:,S_num)==i);
        P_W(i,j)=sum(degree_data(position,W_num)==j)/length(degree_data(position,W_num));
    end
end
%T nodes CPT
for i=1:num_class
    for j=1:num_class
        for k=1:num_class
            for m=1:num_class
                for n=1:num_class
                    position = (degree_data(:,C_num)==m)&(degree_data(:,S_num)==k)&(degree_data(:,O_num)==j)&(degree_data(:,W_num)==i);
                    P_T((i-1)*(num_class^3)+(j-1)*(num_class^2)+(k-1)*num_class+m,n)=sum(degree_data(position,T_num)==n)/length(degree_data(position,T_num));
                end
            end
        end
    end
end
P_C(isnan(P_C))=0;
P_O(isnan(P_O))=0;
P_S(isnan(P_S))=0;
P_T(isnan(P_T))=0;
P_W(isnan(P_W))=0;

save('probability_table_atsurf_5','P_T')
imagesc(P_T); %# Create a colored plot of the matrix values
colormap(flipud(gray)); %# Change the colormap to gray (so higher values are
%%
%Find the probability table of atmospheric temperature conditions
%%Bayesian network of atmospheric temperature, the variables of interest are atmospheric temperature, cloud cover, wind speed (meridional wind, latitudinal wind), water vapor (specific humidity)
load('air_tropp_quarter');
load('tcdc_quarter');
load('uwnd_quarter');
load('vwnd_quarter');
load('shum_quarter');
%Assignment
aosurf=air_tropp_quarter;
Cloud=tcdc_quarter;
uwind=uwnd_quarter;
vwind=vwnd_quarter;
Q =shum_quarter;
%Turning matrices into 1-dimensional arrays and exporting tables
[x y z]=size(aosurf);
aosurf_onedim = reshape(aosurf,x*y*z,1,1);
Cloud_onedim = reshape(Cloud,x*y*z,1,1);
uwind_onedim = reshape(uwind,x*y*z,1,1);
vwind_onedim = reshape(vwind,x*y*z,1,1);
Q_onedim = reshape(Q,x*y*z,1,1);
natural_onedim(:,1)=aosurf_onedim;
natural_onedim(:,2)=Cloud_onedim;
natural_onedim(:,3)=uwind_onedim;
natural_onedim(:,4)=vwind_onedim;
natural_onedim(:,5)=Q_onedim;
[~,variable_num]=size(natural_onedim);

%Read the result of the natural break point
breaks_data =xlsread('Natural_breakpoint_aosurf_5class.xlsx');
%Obtain the grading results for each variable
num_class = length(breaks_data(:,1))-1;
for i=1:variable_num
degree_data_one(:,i)=classification(natural_onedim(:,i),breaks_data(:,i));
end
%%-----------------CPT table conditional probability calculation for each node-------------------------
%There are five variables in total, cloudiness C, longitudinal wind V, latitudinal wind U, water vapor W, and atmospheric temperature A
%Column number
A_num =1;C_num=2;U_num=3;V_num=4;W_num=5;        
%For nodes by serial number
C=1;U=2;V=3;W=4;A=5;
%Organize the variable data needed on the first grid to a top ------ training data
%[~,~,time_num] = size(aosurf);
time_num = 40;
degree_data(:,1)=degree_data_one(1:x*y*time_num,1);
degree_data(:,2)=degree_data_one(1:x*y*time_num,2);
degree_data(:,3)=degree_data_one(1:x*y*time_num,3);
degree_data(:,4)=degree_data_one(1:x*y*time_num,4);
degree_data(:,5)=degree_data_one(1:x*y*time_num,5);
%C nodes CPT
for i=1:num_class
P_C(i)=sum(degree_data(:,C_num)==i)/length(degree_data(:,C_num));
end
%U nodes CPT
for i=1:num_class
P_U(i)=sum(degree_data(:,U_num)==i)/length(degree_data(:,U_num));
end
%V nodes CPT
for i=1:num_class
P_V(i)=sum(degree_data(:,V_num)==i)/length(degree_data(:,V_num));
end
%W nodes CPT
for i=1:num_class
    for j=1:num_class
        for k=1:num_class
        position = (degree_data(:,U_num)==j)&(degree_data(:,V_num)==i);
        P_W((i-1)*num_class+j,k)=sum(degree_data(position,W_num)==k)/length(degree_data(position,W_num));
        end
    end
end
%A nodes CPT
for i=1:num_class
    for j=1:num_class
        for k=1:num_class
            for m=1:num_class
                for n=1:num_class
                    position = (degree_data(:,C_num)==m)&(degree_data(:,U_num)==k)&(degree_data(:,V_num)==j)&(degree_data(:,W_num)==i);
                    P_A((i-1)*(num_class^3)+(j-1)*(num_class^2)+(k-1)*num_class+m,n)=sum(degree_data(position,A_num)==n)/length(degree_data(position,A_num));
                end
            end
        end
    end
end
P_C(isnan(P_C))=0;
P_U(isnan(P_U))=0;
P_V(isnan(P_V))=0;
P_W(isnan(P_W))=0;
P_A(isnan(P_A))=0;

%Save the conditional probability table
save('probability_table_aosurf_5','P_A')
imagesc(P_A); %# Create a colored plot of the matrix values
colormap(flipud(gray)); %# Change the colormap to gray (so higher values are

%%
%Table of conditional probabilities for finding atmospheric humidity
load('uwnd_quarter');
load('vwnd_quarter');
load('pr_quarter');
load('soilw_quarter');
load('shum_quarter');
%Assignment
uwind=uwnd_quarter;
vwind=vwnd_quarter;
rain=pr_quarter;
soil=soilw_quarter;
Q =shum_quarter;
%Turning matrices into 1-dimensional arrays and exporting tables
[x y z]=size(uwind);
uwind_onedim = reshape(uwind,x*y*z,1,1);
vwind_onedim = reshape(vwind,x*y*z,1,1);
rain_onedim = reshape(rain,x*y*z,1,1);
soil_onedim = reshape(soil,x*y*z,1,1);
Q_onedim = reshape(Q,x*y*z,1,1);
natural_onedim(:,1)=uwind_onedim;
natural_onedim(:,2)=vwind_onedim;
natural_onedim(:,3)=rain_onedim;
natural_onedim(:,4)=soil_onedim;
natural_onedim(:,5)=Q_onedim;
[~,variable_num]=size(natural_onedim);
%Read the result of the natural break point
breaks_data =xlsread('Natural_breakpoint_q_5class.xlsx');
%Obtain the grading results for each variable
num_class = length(breaks_data(:,1))-1;
for i=1:variable_num
degree_data_one(:,i)=classification(natural_onedim(:,i),breaks_data(:,i));
end
%%-----------------CPT table conditional probability calculation for each node-------------------------
%There are five variables in total, latitudinal wind U, longitudinal wind V, precipitation R, soil moisture S, and water vapor W   
%Column number
U_num =1;V_num=2;R_num=3;S_num=4;W_num=5;        
%For nodes by serial number
U=1;V=2;R=3;S=4;W=5;
%Organize the variable data needed on the first grid to a top ------ training data
%[~,~,time_num] = size(uwind);
time_num = 40;
degree_data(:,1)=degree_data_one(1:x*y*time_num,1);
degree_data(:,2)=degree_data_one(1:x*y*time_num,2);
degree_data(:,3)=degree_data_one(1:x*y*time_num,3);
degree_data(:,4)=degree_data_one(1:x*y*time_num,4);
degree_data(:,5)=degree_data_one(1:x*y*time_num,5);
%U nodes CPT
for i=1:num_class
P_U(i)=sum(degree_data(:,U_num)==i)/length(degree_data(:,U_num));
end
%V nodes CPT
for i=1:num_class
P_V(i)=sum(degree_data(:,V_num)==i)/length(degree_data(:,V_num));
end
%R nodes CPT
for i=1:num_class
P_R(i)=sum(degree_data(:,R_num)==i)/length(degree_data(:,R_num));
end
%S nodes CPT
for i=1:num_class
    for j=1:num_class
        position = (degree_data(:,R_num)==i);
        P_S(i,j)=sum(degree_data(position,S_num)==j)/length(degree_data(position,S_num));
    end
end
%W nodes CPT
for i=1:num_class
    for j=1:num_class
        for k=1:num_class
            for m=1:num_class
                for n=1:num_class
                    position = (degree_data(:,U_num)==m)&(degree_data(:,V_num)==k)&(degree_data(:,R_num)==j)&(degree_data(:,S_num)==i);
                    P_W((i-1)*(num_class^3)+(j-1)*(num_class^2)+(k-1)*num_class+m,n)=sum(degree_data(position,W_num)==n)/length(degree_data(position,W_num));
                end
            end
        end
    end
end
P_U(isnan(P_U))=0;
P_V(isnan(P_V))=0;
P_R(isnan(P_R))=0;
P_S(isnan(P_S))=0;
P_W(isnan(P_W))=0;

%Save the conditional probability table
save('probability_table_q_5','P_W')
imagesc(P_W); %# Create a colored plot of the matrix values
colormap(flipud(gray)); %# Change the colormap to gray (so higher values are

