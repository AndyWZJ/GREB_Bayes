%FORTRAN binary files must be read in Single precision, because FORTRAN storage is Single precision, if read in double precision, then inevitably read half, and the data is wrong
fid=fopen('D:\Learning_documents\docking_work\Greb_fortran_demo\tomn.bin','rb'); 
[A,Count]=fread(fid,inf,'single');
a1=length(A);
num =a1/96/48;
fclose(fid);
swmn_mon = reshape(A,96,48,num);

fid=fopen('G:\Greb\input\Tocean_flux_correction.bin','rb'); 
[A,Count]=fread(fid,inf,'single');
fclose(fid);
swmn_year = reshape(A,96,48,50);


%Construct the hierarchical tensor
%Set Rank value
opts.max_rank = 20;
%Layer tensor decomposition
swmn_mon_typhoon = htensor.truncate_ltr(swmn_mon,opts);
%Extract the weight of X, Y, and timeline
X_typhoon = swmn_mon_typhoon.U{2};
Y_typhoon = swmn_mon_typhoon.U{4};
T_typhoon = swmn_mon_typhoon.U{5};




