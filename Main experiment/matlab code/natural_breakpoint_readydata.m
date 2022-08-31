%Use the year data to divide the natural interruption point, because the other data is too large, the time will be long when divided
%Atmospheric temperature
load('air_tropp_year');
load('tcdc_year');
load('uwnd_year');
load('vwnd_year');
load('shum_year');
%Assignment
aosurf=air_tropp_year;
Cloud=tcdc_year;
uwind=uwnd_year;
vwind=vwnd_year;
Q =shum_year;
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
xlswrite('natural_onedim_aosurf.xlsx',natural_onedim);

%Water vapor
load('uwnd_year');
load('vwnd_year');
load('pr_year');
load('soilw_year');
load('shum_year');
%Assignment
uwind=uwnd_year;
vwind=vwnd_year;
rain=pr_year;
soil=soilw_year;
Q =shum_year;
%Turning matrices into 1-dimensional arrays and exporting tables
[xx yy zz]=size(uwind);
uwind_onedim = reshape(uwind,xx*yy*zz,1,1);
vwind_onedim = reshape(vwind,xx*yy*zz,1,1);
rain_onedim = reshape(rain,xx*yy*zz,1,1);
soil_onedim = reshape(soil,xx*yy*zz,1,1);
Q_onedim = reshape(Q,xx*yy*zz,1,1);
natural_onedim(:,1)=uwind_onedim;
natural_onedim(:,2)=vwind_onedim;
natural_onedim(:,3)=rain_onedim;
natural_onedim(:,4)=soil_onedim;
natural_onedim(:,5)=Q_onedim;
xlswrite('natural_onedim_q.xlsx',natural_onedim);