function outdata =classification(data,breaks_data)
%This function is used to classify a one-dimensional array into different levels based on interruption points
%The input is a one-dimensional original data, and a one-dimensional graded interrupt boundary value
% such as a = [13 42 23 41 21 44 52], to be divided into levels of boundary values for [0 20 40 60], that is, into 3 categories (0-20, 20-40, 40-60)
% output is a one-dimensional array of divided levels, such as [1 3 2 3 2 3 3 3]

% how many levels respectively, [0 20 40 60] is the number-1, which is three levels
num_class=length(breaks_data)-1;
%Classify values smaller than the minimum value as 1 level
s1 = find(data(:,:)<breaks_data(1));
for num=1:length(s1)
outdata(s1(num))=1;
end
%Classify the value greater than the maximum value as the highest level
s2 = find(data(:,:)>breaks_data(num_class));
for num=1:length(s2)
outdata(s2(num))=num_class;
end
%The intermediate values are divided into levels according to their magnitude, and some values exactly equal to the intermediate values are equal to one of the boundary states.
for i =1:num_class
    r=find(data(:,:)>=breaks_data(i)&data(:,:)<=breaks_data(i+1));
    for num=1:length(r)
        outdata(r(num))=i;
    end
end
    
end

