%GREB versus Bayes
t1=clock;
% Processes Greb data into state data
% Result of reading the natural break point
breaks_data =xlsread('C:\Users\Administrator\Desktop\ Docking \ Quarterly average\Natural_breakpoint_aosurf_9class.xlsx');  %change@@
% The is reconstituted into a line
load('tamn_greb_quarter');   %change
greb_data = tamn_greb_quarter(:,:,41:120);   %change
natural_onedim = reshape(greb_data,96*48*80,1);  
%Classify the data and convert it to state data
q_state_data=classification(natural_onedim,breaks_data(:,1)); 
q_state_data =reshape(q_state_data,96,48,80);

%Raw data is processed as state data
load('D:\Desktop\Graduation_thesis\Raw_data\Data\Quarterly_average\air_tropp_quarter.mat');   %change
ori_data =air_tropp_quarter(:,:,41:120);  %change
%Recombine into one line
original_data = reshape(ori_data,96*48*80,1);    
%Classify the data and convert it to state data
original_state_data=classification(original_data,breaks_data(:,1)); 
original_state_data =reshape(original_state_data,96,48,80);

%Correct rate comparison '
number = 80;
for i =1:96
    for j=1:48
        correct_number = 0;
        for k = 1:number
            if q_state_data(i,j,k) == original_state_data(i,j,k)
                correct_number = correct_number+1;
            end
        end
        Correct_rate(i,j) = correct_number/number;
    end
end
t2=clock;
time =etime(t2,t1);

%Thermal map preservation
heatmap(rot90(Correct_rate));
save('original_aosurf_9class','Correct_rate'); %change@@

clear
