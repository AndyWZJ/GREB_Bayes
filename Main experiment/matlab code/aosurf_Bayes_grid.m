%The quarterly data of grid network is with the simulation surface temperature
%%Atmospheric temperature Bayes network, related variables include atmospheric temperature, cloud volume, wind speed (wind speed, weft wind), water vapor (wet)

%(Humidity is also known as humidity, which is a measurement standard for the overall moisture content in the air, that is, the amount of water steam contained in the air per kilogram of dry air).
%Reading data (quarterly data or monthly average or annual average)
load('E:\GREB\air_tropp_quarter');
load('E:\GREB\tcdc_quarter');
load('E:\GREB\uwnd_quarter');
load('E:\GREB\vwnd_quarter');
load('E:\GREB\shum_quarter');

%Assign to related variables
aosurf=air_tropp_quarter;
Cloud=tcdc_quarter;
uwind=uwnd_quarter;
vwind=vwnd_quarter;
Q =shum_quarter;

%Drop the matrix into one -dimensional array and export as the form
[xx yy zz]=size(aosurf);
aosurf_onedim = reshape(aosurf,xx*yy*zz,1,1);
Cloud_onedim = reshape(Cloud,xx*yy*zz,1,1);
uwind_onedim = reshape(uwind,xx*yy*zz,1,1);
vwind_onedim = reshape(vwind,xx*yy*zz,1,1);
Q_onedim = reshape(Q,xx*yy*zz,1,1);
natural_onedim(:,1)=aosurf_onedim;
natural_onedim(:,2)=Cloud_onedim;
natural_onedim(:,3)=uwind_onedim;
natural_onedim(:,4)=vwind_onedim;
natural_onedim(:,5)=Q_onedim;
[~,variable_num]=size(natural_onedim);
xlswrite('natural_onedim_aosurf.xlsx',natural_onedim);
% Due to the long time, it does not need to be divided into a natural break point without quarter data£¬natural_breakpoint_readydata.m
%%



%-----------------Start the natural interval point of Python-------------------------
%%

%Read the result of natural interval
breaks_data =xlsread('E:\GREB\Natural_breakpoint_aosurf_7class.xlsx');


%Get the grading results of each variable
num_class = length(breaks_data(:,1))-1;
for i=1:5%:variable_num
degree_data_one(:,i)=classification(natural_onedim(:,i),breaks_data(:,i));
end


%The state grid for each variable 96*48*120
aosurf_q=reshape(degree_data_one(:,1),96,48,120);
Cloud_q=reshape(degree_data_one(:,2),96,48,120);
uwind_q=reshape(degree_data_one(:,3),96,48,120);
vwind_q=reshape(degree_data_one(:,4),96,48,120);
Q_q=reshape(degree_data_one(:,5),96,48,120);

%%This is not the same as before. The grid is calculated by each grid. After calculating the next grid, you must re -train


%%-----------------Calculation of the Condition of each Node CPT table-------------------------
%There are 5 variables in total, cloud volume C, Jingxiang wind V, weft wind U, water vapor W, atmospheric temperature A
%Divided into 96*48 grid nets
%start the timer
t1 = clock;
for x=1:96
    for y=1:48
	
%Column number
A_num =1;C_num=2;U_num=3;V_num=4;W_num=5; 
       
%For nodes by serial number
C=1;U=2;V=3;W=4;A=5;

%Organize the variable data needed on the first grid to a top ------ training data
%[~,~,time_num] = size(aosurf);
time_num = 40;
degree_data(:,1)=reshape(aosurf_q(x,y,1:time_num),time_num,1);
degree_data(:,2)=reshape(Cloud_q(x,y,1:time_num),time_num,1);
degree_data(:,3)=reshape(uwind_q(x,y,1:time_num),time_num,1);
degree_data(:,4)=reshape(vwind_q(x,y,1:time_num),time_num,1);
degree_data(:,5)=reshape(Q_q(x,y,1:time_num),time_num,1);

%Simulation data
time_pre_num = 80 ;
degree_pre_data(:,1)=reshape(aosurf_q(x,y,time_num+1:time_num+time_pre_num),time_pre_num,1);
degree_pre_data(:,2)=reshape(Cloud_q(x,y,time_num+1:time_num+time_pre_num),time_pre_num,1);
degree_pre_data(:,3)=reshape(uwind_q(x,y,time_num+1:time_num+time_pre_num),time_pre_num,1);
degree_pre_data(:,4)=reshape(vwind_q(x,y,time_num+1:time_num+time_pre_num),time_pre_num,1);
degree_pre_data(:,5)=reshape(Q_q(x,y,time_num+1:time_num+time_pre_num),time_pre_num,1);

%C nodes CPT
for i=1:num_class
P_C(i)=sum(degree_data(:,C_num)==i)/length(degree_data(:,C_num));
end

%U nodes CPT
for i=1:num_class
P_U(i)=sum(degree_data(:,U_num)==i)/length(degree_data(:,U_num));
end

%V nodes CPT
for i=1:num_class
P_V(i)=sum(degree_data(:,V_num)==i)/length(degree_data(:,V_num));
end

%W nodes CPT
for i=1:num_class
    for j=1:num_class
        for k=1:num_class
        position = (degree_data(:,U_num)==j)&(degree_data(:,V_num)==i);
        P_W((i-1)*num_class+j,k)=sum(degree_data(position,W_num)==k)/length(degree_data(position,W_num));
        end
    end
end

%A nodes CPT
for i=1:num_class
    for j=1:num_class
        for k=1:num_class
            for m=1:num_class
                for n=1:num_class
                    position = (degree_data(:,C_num)==m)&(degree_data(:,U_num)==k)&(degree_data(:,V_num)==j)&(degree_data(:,W_num)==i);
                    P_A((i-1)*(num_class^3)+(j-1)*(num_class^2)+(k-1)*num_class+m,n)=sum(degree_data(position,A_num)==n)/length(degree_data(position,A_num));
                end
            end
        end
    end
end
P_C(isnan(P_C))=0;
P_U(isnan(P_U))=0;
P_V(isnan(P_V))=0;
P_W(isnan(P_W))=0;
P_A(isnan(P_A))=0;

%Save the conditional probability table
result_probability_table{x,y} =P_A;

%---------------------------Bayesian network building----------------------
N=5;
dag=zeros(N,N);
C=1;U=2;V=3;W=4;A=5;
dag(C,A)=1;
dag(U,[W A])=1;
dag(V,[W A])=1;
dag(W,A)=1;

%Related assignments
discrete_nodes=1:N;
node_sizes=num_class*ones(1,N);
bnet=mk_bnet(dag,node_sizes,'names',{'C','U','V','W','A'},'discrete',discrete_nodes);
bnet.CPD{C}=tabular_CPD(bnet,C,P_C);
bnet.CPD{U}=tabular_CPD(bnet,U,P_U);
bnet.CPD{V}=tabular_CPD(bnet,V,P_V);
bnet.CPD{W}=tabular_CPD(bnet,W,P_W);
bnet.CPD{A}=tabular_CPD(bnet,A,P_A);

%---------------------------Simulation or prediction------------------------------
%Read the hydrological data to be simulated or predicted
num_degreedata=length(degree_pre_data);
for i=1:num_degreedata
    engine=jtree_inf_engine(bnet);
    evidence=cell(1,N);
    evidence{C}=degree_pre_data(i,C_num);  %input R
    evidence{U}=degree_pre_data(i,U_num);  %input E
    evidence{V}=degree_pre_data(i,V_num);  %input P
    evidence{W}=degree_pre_data(i,W_num);  %input P
    [engine,loglik]=enter_evidence(engine,evidence);
    m=marginal_nodes(engine,A);  %Find the value of T
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
    if T_value(i) == degree_pre_data(i,A_num)
        correct_number = correct_number+1;
    end
end
Correct_rate(x,y) = correct_number/number;

    end
end
t2 = clock;
time=etime(t2,t1); 
save('Natural_breakpoint_aosurf_7class_wj','Correct_rate','pre_result_degree','result_probability_table','time')
%%



%Later, you can compare the error with a heat map, or you can take the state of the two maps and compare them directly.
%heatmap(Correct_rate);

