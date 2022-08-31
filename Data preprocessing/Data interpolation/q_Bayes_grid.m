%The quarterly data of grid network is with the simulation surface temperature
%%The Bayes network of water vapor, related variables include wind speed (via wind, weft wind), rainfall, soil humidity, water vapor (wet)
%(Humidity is also known as humidity, which is a measurement standard for the overall moisture content in the air, that is, the amount of water steam contained in the air per kilogram of dry air).
%Reading data (quarterly data or monthly average or annual average)
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
%Change the matrix to a one -dimensional array and export the form
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
[~,variable_num]=size(natural_onedim);
% xlswrite('natural_onedim_aosurf.xlsx',natural_onedim);
% Due to the long time, it does not need to be divided into a natural break point without quarter data.£¬natural_breakpoint_readydata.m
%%
%-----------------Start the natural interval point of Python-------------------------
%%
%Read the result of natural interval
breaks_data =xlsread('Natural_breakpoint_q_9class.xlsx');
%Get the grading results of each variable
num_class = length(breaks_data(:,1))-1;
for i=1:variable_num
degree_data_one(:,i)=classification(natural_onedim(:,i),breaks_data(:,i));
end
%The state grid for each variable 96*48*120 ------ this is quarterly data
uwind_q=reshape(degree_data_one(:,1),96,48,120);
vwind_q=reshape(degree_data_one(:,2),96,48,120);
rain_q=reshape(degree_data_one(:,3),96,48,120);
soil_q=reshape(degree_data_one(:,4),96,48,120);
Q_q=reshape(degree_data_one(:,5),96,48,120);
%%This is not the same as before. The grid is calculated by each grid. After calculating the next grid, you must re -train
%%-----------------CPT Table of each node condition probability calculation-------------------------
%There are five variables in total, latitudinal wind U, longitudinal wind V, precipitation R, soil moisture S, and water vapor W
%Divided into 96*48 grid nets
%start the timer
t1 = clock;
for x=1:96
    for y=1:48
        
%Column number
U_num =1;V_num=2;R_num=3;S_num=4;W_num=5;        
%For nodes by serial number
U=1;V=2;R=3;S=4;W=5;
%Organize the variable data needed on the first grid to a top ------ training data
%[~,~,time_num] = size(uwind);
time_num = 40;
degree_data(:,1)=reshape(uwind_q(x,y,1:time_num),time_num,1);
degree_data(:,2)=reshape(vwind_q(x,y,1:time_num),time_num,1);
degree_data(:,3)=reshape(rain_q(x,y,1:time_num),time_num,1);
degree_data(:,4)=reshape(soil_q(x,y,1:time_num),time_num,1);
degree_data(:,5)=reshape(Q_q(x,y,1:time_num),time_num,1);
%Simulation data
time_pre_num = 80;
degree_pre_data(:,1)=reshape(uwind_q(x,y,time_num+1:time_num+time_pre_num),time_pre_num,1);
degree_pre_data(:,2)=reshape(vwind_q(x,y,time_num+1:time_num+time_pre_num),time_pre_num,1);
degree_pre_data(:,3)=reshape(rain_q(x,y,time_num+1:time_num+time_pre_num),time_pre_num,1);
degree_pre_data(:,4)=reshape(soil_q(x,y,time_num+1:time_num+time_pre_num),time_pre_num,1);
degree_pre_data(:,5)=reshape(Q_q(x,y,time_num+1:time_num+time_pre_num),time_pre_num,1);
%U Nodes CPT
for i=1:num_class
P_U(i)=sum(degree_data(:,U_num)==i)/length(degree_data(:,U_num));
end
%V Nodes CPT
for i=1:num_class
P_V(i)=sum(degree_data(:,V_num)==i)/length(degree_data(:,V_num));
end
%R Nodes CPT
for i=1:num_class
P_R(i)=sum(degree_data(:,R_num)==i)/length(degree_data(:,R_num));
end
%S Nodes CPT
for i=1:num_class
    for j=1:num_class
        position = (degree_data(:,R_num)==i);
        P_S(i,j)=sum(degree_data(position,S_num)==j)/length(degree_data(position,S_num));
    end
end
%W Nodes
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
result_probability_table{x,y} =P_W;
%---------------------------Bayesian network building----------------------
N=5;
dag=zeros(N,N);
U=1;V=2;R=3;S=4;W=5;
dag(U,W)=1;
dag(V,W)=1;
dag(R,[S W])=1;
dag(S,W)=1;



discrete_nodes=1:N;
node_sizes=num_class*ones(1,N);
bnet=mk_bnet(dag,node_sizes,'names',{'U','V','R','S','W'},'discrete',discrete_nodes);
bnet.CPD{U}=tabular_CPD(bnet,U,P_U);
bnet.CPD{V}=tabular_CPD(bnet,V,P_V);
bnet.CPD{R}=tabular_CPD(bnet,R,P_R);
bnet.CPD{S}=tabular_CPD(bnet,S,P_S);
bnet.CPD{W}=tabular_CPD(bnet,W,P_W);

%---------------------------Simulation or prediction------------------------------
%Read the hydrological data to be simulated or predicted
num_degreedata=length(degree_pre_data);
for i=1:num_degreedata
    engine=jtree_inf_engine(bnet);
    evidence=cell(1,N);
    evidence{U}=degree_pre_data(i,U_num);  %InputR
    evidence{V}=degree_pre_data(i,V_num);  %InputE
    evidence{R}=degree_pre_data(i,R_num);  %InputP
    evidence{S}=degree_pre_data(i,S_num);  %InputP
    [engine,loglik]=enter_evidence(engine,evidence);
    m=marginal_nodes(engine,W);  %Request T
    X=m.T();
    T_P=find(X==max(X));
    if length(T_P)>1
        T_value(i)=T_P(2);
    elseif length(T_P)==0
        T_value(i)=1;  %The back needs improvement
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
    if T_value(i) == degree_pre_data(i,W_num)
        correct_number = correct_number+1;
    end
end
Correct_rate(x,y) = correct_number/number;

    end
end
t2 = clock;
time=etime(t2,t1); 
save('Natural_breakpoint_q_9class','Correct_rate','pre_result_degree','result_probability_table','time')
%%

%Later, you can compare the error with a heat map, or you can take the state of the two maps and compare them directly.
heatmap(Correct_rate);

