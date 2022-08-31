%Reading Fortran's binary files, pay attention to reading when reading, because Fortran deposits single precision, if you read it as a double precision, then you must read less than half, and the data is wrong.
fid=fopen('D:\Greb_Fortran_Demo\tomn.bin','rb'); 
[A,Count]=fread(fid,inf,'single');
a1=length(A);
num =a1/96/48;
fclose(fid);
swmn_mon = reshape(A,96,48,num);

fid=fopen('G:\Greb\input\Tocean_flux_correction.bin','rb'); 
[A,Count]=fread(fid,inf,'single');
fclose(fid);
swmn_year = reshape(A,96,48,50);


%Structure hierarchy tensor 
%Set Rank value
opts.max_rank = 20;
%hierarchy tensor decomposition
swmn_mon_typhoon = htensor.truncate_ltr(swmn_mon,opts);
%Extract the weight of X, Y, and timeline
X_typhoon = swmn_mon_typhoon.U{2};
Y_typhoon = swmn_mon_typhoon.U{4};
T_typhoon = swmn_mon_typhoon.U{5};




