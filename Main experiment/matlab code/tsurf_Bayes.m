%%Bayesian network of surface temperature, the variables of interest are surface temperature, solar radiation, ocean temperature, water vapor, cloudiness
%Read data (monthly average or annual average)
load('dswrf_year');
load('sst_year');
load('shum_year');
load('tcdc_year');
%Assignment
asurf=air_year;
sw_r=dswrf_year;
aosurf=sst_year;
water_vapor=shum_year;
Cloud =tcdc_year;
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
xlswrite('natural_onedim.xlsx',natural_onedim);
%%
%-----------------Launch python's natural interrupted dot method-------------------------
%%
%Read the result of the natural break point
breaks_data =xlsread('Natural_breakpoint');
%Obtain the grading results for each variable
num_class = length(breaks_data(:,1))-1;
for i=1:num_class
degree_data(:,i)=classification(natural_onedim(:,i),breaks_data(:,i));
end
%%
%%-----------------CPT table conditional probability calculation for each node-------------------------
%There are five variables in total, surface temperature T, solar radiation S, ocean temperature O, water vapor W, and cloudiness C
%Column number
T_num =1;S_num=2;O_num=3;W_num=4;C_num=5;
%For nodes by serial number
C=1;S=2;O=3;W=4;T=5;
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

%---------------------------Bayesian network building----------------------
N=5;
dag=zeros(N,N);
C=1;S=2;O=3;W=4;T=5;
dag(C,T)=1;
dag(S,[O W T])=1;
dag(O,T)=1;
dag(W,T)=1;

discrete_nodes=1:N;
node_sizes=num_class*ones(1,N);
bnet=mk_bnet(dag,node_sizes,'names',{'C','S','O','W','T'},'discrete',discrete_nodes);
bnet.CPD{C}=tabular_CPD(bnet,C,P_C);
bnet.CPD{S}=tabular_CPD(bnet,S,P_S);
bnet.CPD{O}=tabular_CPD(bnet,O,P_O);
bnet.CPD{W}=tabular_CPD(bnet,W,P_W);
bnet.CPD{T}=tabular_CPD(bnet,T,P_T);

%---------------------------Simulation or prediction------------------------------
%Read the hydrological data to be simulated or predicted
num_degreedata=length(degree_data);
for i=1:num_degreedata
    engine=jtree_inf_engine(bnet);
    evidence=cell(1,N);
    evidence{C}=degree_data(i,C_num);  %input R
    evidence{S}=degree_data(i,S_num);  %input E
    evidence{O}=degree_data(i,O_num);  %input P
    evidence{W}=degree_data(i,W_num);  %input P
    [engine,loglik]=enter_evidence(engine,evidence);
    m=marginal_nodes(engine,T);  %Find the value of T
    X=m.T();
    T_P=find(X==max(X));
    if length(T_P)>1
        T_value(i)=T_P(2);
    elseif length(T_P)==0
        T_value(i)=1;  
    else
        T_value(i)=T_P(1);
    end
end
T_value=T_value';

%Correct Rate
number = length(T_value);
correct_number = 0;
for i = 1:number
    if T_value(i) == degree_data(i,T_num)
        correct_number = correct_number+1;
    end
end
Correct_rate = correct_number/number;


%Later, you can compare the error with a heat map, or you can take the state of the two maps and compare them directly.
real_value = reshape(degree_data(:,T_num),96,48,30);
model_value = reshape(T_value,96,48,30);
error_value =abs(real_value-model_value);

heatmap(error_value);

a=error_value(:,:,1);

h=HeatMap(a,'Colormap',redbluecmap); 
h.Annotate = true;%Displaying data values in a heat map