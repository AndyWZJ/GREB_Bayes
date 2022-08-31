%Quarterly grid data to compare with simulated surface temperature
%%Bayesian network of surface temperature, the variables of interest are surface temperature, solar radiation, ocean temperature, water vapor, cloudiness
%Reading data (monthly average or annual average)
load('E:\air_quarter');
load('E:\dswrf_quarter');
load('E:\sst_quarter');
load('E:\shum_quarter');
load('E:\tcdc_quarter');
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
%%
%-----------------Launch python's natural interrupted dot method-------------------------
%%
%Read the result of the natural break point
breaks_data =xlsread('E:\GREB\Natural_breakpoint_atsurf_9class.xlsx');
%Obtain the grading results for each variable
num_class = length(breaks_data(:,1))-1;
for i=1:variable_num
degree_data_one(:,i)=classification(natural_onedim(:,i),breaks_data(:,i));
end
%Processing as a state grid of 96*48*120 for each variable
asurf_q=reshape(degree_data_one(:,1),96,48,120);
sw_r_q=reshape(degree_data_one(:,2),96,48,120);
aosurf_q=reshape(degree_data_one(:,3),96,48,120);
water_vapor_q=reshape(degree_data_one(:,4),96,48,120);
Cloud_q=reshape(degree_data_one(:,5),96,48,120);
%%From this and the previous is different, the grid is each grid to calculate, after calculating the next grid will have to retrain
%%-----------------CPT table conditional probability calculation for each node-------------------------
%There are five variables in total, surface temperature T, solar radiation S, ocean temperature O, water vapor W, and cloudiness C
%Divided into 96*48 grids
%Start Timer
t1 = clock;
for x=1:96
    for y=1:48
        
%Column number
T_num =1;S_num=2;O_num=3;W_num=4;C_num=5;        
%For nodes by serial number
C=1;S=2;O=3;W=4;T=5;
%Organize the variable data needed on the first grid to a top ------ training data
%[~,~,time_num] = size(asurf);
time_num = 40;
degree_data(:,1)=reshape(asurf_q(x,y,1:time_num),time_num,1);
degree_data(:,2)=reshape(sw_r_q(x,y,1:time_num),time_num,1);
degree_data(:,3)=reshape(aosurf_q(x,y,1:time_num),time_num,1);
degree_data(:,4)=reshape(water_vapor_q(x,y,1:time_num),time_num,1);
degree_data(:,5)=reshape(Cloud_q(x,y,1:time_num),time_num,1);
%Simulation data
time_pre_num = 80 ;
degree_pre_data(:,1)=reshape(asurf_q(x,y,time_num+1:time_num+time_pre_num),time_pre_num,1);
degree_pre_data(:,2)=reshape(sw_r_q(x,y,time_num+1:time_num+time_pre_num),time_pre_num,1);
degree_pre_data(:,3)=reshape(aosurf_q(x,y,time_num+1:time_num+time_pre_num),time_pre_num,1);
degree_pre_data(:,4)=reshape(water_vapor_q(x,y,time_num+1:time_num+time_pre_num),time_pre_num,1);
degree_pre_data(:,5)=reshape(Cloud_q(x,y,time_num+1:time_num+time_pre_num),time_pre_num,1);
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

%Save the conditional probability table
result_probability_table{x,y} =P_T;
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
num_degreedata=length(degree_pre_data);
for i=1:num_degreedata
    engine=jtree_inf_engine(bnet);
    evidence=cell(1,N);
    evidence{C}=degree_pre_data(i,C_num);  %input C 
    evidence{S}=degree_pre_data(i,S_num);  %input S 
    evidence{O}=degree_pre_data(i,O_num);  %input O 
    evidence{W}=degree_pre_data(i,W_num);  %input W 
    [engine,loglik]=enter_evidence(engine,evidence);
    m=marginal_nodes(engine,T);  %output T
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
%The state of each grid per year
pre_result_degree(x,y,:)=reshape(T_value,time_pre_num,1);
%Correct Rate
number = length(T_value);
correct_number = 0;
for i = 1:number
    if T_value(i) == degree_pre_data(i,T_num)
        correct_number = correct_number+1;
    end
end
Correct_rate(x,y) = correct_number/number;

    end
end
t2 = clock;
time=etime(t2,t1); 
save('Natural_breakpoint_atsurf_9class','Correct_rate','pre_result_degree','result_probability_table','time')
%%

%The error can be compared later with a heat map