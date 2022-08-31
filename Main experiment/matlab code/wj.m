pathname='E:\';
files=dir([pathname,'*.nc']);
for i=1:length(files)
    filename=[pathname,files(i).name];
    SST=ncread(filename,'u');
%     SST=SST(6961:7441,1152:1584);
%     sst(:,:,i)=SST;
    save('u.mat','SST')
end
