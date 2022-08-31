%Process data output from the GREB model and process GREB data to quarter data 1985-2014, not downloaded data
clear
fid=fopen('qmn_mon.bin',"rb"); 
[A,Count]=fread(fid,inf,'single');
fclose(fid);
bianliang = reshape(A,96,48,600);

bianliang = bianliang(:,:,181:540);

for i=1:120
    qmn_greb_quarter(:,:,i)=mean(bianliang(:,:,(i-1)*3+1:3*i),3);
end
save('qmn_greb_quarter','qmn_greb_quarter')

qmn_greb_quarter(:,:,1);

