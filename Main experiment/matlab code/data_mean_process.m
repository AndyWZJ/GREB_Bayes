% Processing of downloaded data into monthly, annual, quarterly data
%Processing as monthly average
% Assume a folder with 50 years of daily data (x*y) totaling (50*12*365), input daily data, output as a .mat file for 50 years, x*y*(50*12)clear
for j=1:30
value = 'sst.day.mean.';  %Need to change the volume name ***
nc = '.nc';
num = num2str(1984+j);   %What is needed is the 40 years after 1950, here 1949 needs to be added 1
filename=[value,num,nc];
read_data = ncread(filename,'sst'); %The parameter that needs to be changed is the variable  ***
%j is year 


%%Convert daily data to monthly data after reading in annual data

mon_p =[1 -2 1 0 1 0 1 1 0 1 0 1];
mon_r =[1 -1 1 0 1 0 1 1 0 1 0 1];
[~,~,len] = size(read_data);
%The time of year is 365
if len ==365
    for i =1:12
        [a1,a2,len_mon] =size(read_data);
        out_data(:,:,i)=mean(read_data(:,:,1:30+mon_p(i)),3);
        if len_mon>32
        [~,~,len_read] =size(read_data);
        read_data = read_data(:,:,30+mon_p(i)+1:len_read);
        end    
    end
end
(read_data);
%The time of year is 366
if len ==366
    for i =1:12
        [~,~,len_mon] =size(read_data);
        out_data(:,:,i)=mean(read_data(:,:,1:30+mon_r(i)),3);
        if len_mon>32
        [~,~,len_read] =size(read_data);
        read_data = read_data(:,:,30+mon_r(i)+1:len_read);
        end    
    end
end

%Monthly data pile up
    sst_mon(:,:,1+(j-1)*12:12+(j-1)*12) = out_data;  %Modify variable name    ***
end
%Save as mat table data
save('sst_mon','sst_mon');  %The variable name of the stored .mat    ***

%%



%%
clear
%Process as annual average
% Assume a folder with 50 years of daily data (x*y) totaling (50*12*365), input daily data, output as a .mat file for 50 years, x*y*50value = 'sst.day.mean.';  %需要改变量名称   ***
nc = '.nc';
%i is year
for i=1:30
    num = num2str(1984+i);
    filename=[value,num,nc];
    read_data = ncread(filename,'sst'); %The parameter that needs to be changed is the variable   ***
    sst_year(:,:,i) = mean(read_data,3);  %Modify variable name      ***
end

save('sst_year','sst_year');  %The variable name of the stored .mat      ***


%%
%Here are the data that are not useful to eliminate
load('vwnd_year');
a =max(vwnd_year(:));
b =min(vwnd_year(:));
%Processing after checking for outliers
s1 =uwnd_year(:,:,1);
sst_year(find(sst_year==-inf))=0;

%Overwrite the original file
save('sst_year','sst_year');

%%
%In the final step, this data is processed into a raster of the same size, using the scala_threedim function
load('vwnd_mon');
vwnd_mon =scala_threedim(vwnd_mon,[96 48]);
save('vwnd_mon','vwnd_mon');



%%
%Processed as quarterly average 123.456.789.101112
load('vwnd_mon');
for i=1:120
    vwnd_quarter(:,:,i)=mean(vwnd_mon(:,:,(i-1)*3+1:3*i),3);
end
save('vwnd_quarter','vwnd_quarter')