%Process the downloaded data as month data, annual data, quarter data
%Treatment as a monthly average
%Suppose a folder has a total of 50 years of daily data (x*y) a total of (50*12*365), input daily data, output to 50 years. MAT file, x*y*(50*12)
clear
for j=1:30
value = 'sst.day.mean.';  %Need to change the amount name ***
nc = '.nc';
num = num2str(1984+j);   %What is needed is the 40 years after 1950, here is 1 need to add 1 here
filename=[value,num,nc];
read_data = ncread(filename,'sst'); %Need to change the parameter of the variable  ***
%j is years


%%After reading the annual data, the daily data is converted to month data

mon_p =[1 -2 1 0 1 0 1 1 0 1 0 1];
mon_r =[1 -1 1 0 1 0 1 1 0 1 0 1];
[~,~,len] = size(read_data);
%One year is 365
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
%One year is 366
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

%Data pile up monthly
    sst_mon(:,:,1+(j-1)*12:12+(j-1)*12) = out_data;  %Modify the change name  ***
end
%Save as MAT table data
save('sst_mon','sst_mon');  %The variable name of the deposit .mat    ***

%%



%%
clear
%Treatment to an average annual
%Suppose a folder has a total of 50 years of daily data (x*y) a total of (50*12*365), input daily data, output to 50 years. MAT file, x*y*50 50 50
value = 'sst.day.mean.';  %Need to change the amount name   ***
nc = '.nc';
%i is year
for i=1:30
    num = num2str(1984+i);
    filename=[value,num,nc];
    read_data = ncread(filename,'sst'); %Need to change the parameter of the variable ***
    sst_year(:,:,i) = mean(read_data,3);  %Modify the change name      ***
end

save('sst_year','sst_year');  %The variable name of the deposit .mat    ***


%%
%The following is the data that is useless
load('vwnd_year');
a =max(vwnd_year(:));
b =min(vwnd_year(:));
%After checking the abnormal value, process it
s1 =uwnd_year(:,:,1);
sst_year(find(sst_year==-inf))=0;

%Cover the original file
save('sst_year','sst_year');

%%
%In the last step, process these data as the same size of the size, and use the scala_threedim function
load('vwnd_mon');
vwnd_mon =scala_threedim(vwnd_mon,[96 48]);
save('vwnd_mon','vwnd_mon');



%%
%Processing to average quarterly123.456.789.101112
load('vwnd_mon');
for i=1:120
    vwnd_quarter(:,:,i)=mean(vwnd_mon(:,:,(i-1)*3+1:3*i),3);
end
save('vwnd_quarter','vwnd_quarter')