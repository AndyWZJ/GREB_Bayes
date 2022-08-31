function outdata =classification(data,breaks_data)
% The function is used to divide a one-dimensional array into different levels according to the break point

% The input is a one-dimensional original data, and a one-dimensional hierarchical break point boundary value

% If a=[13 42 23 41 21 44 52], the grade boundary value to be divided is [0 20 40 60], that is, it is divided into three categories (0-20,20-40,40-60).

% The output is a hierarchical one-dimensional array such as [1 3 2 3 2 3 3 3]



How many levels are % respectively? [0, 20, 40, 60] is the number of -1, which is three levels
num_class=length(breaks_data)-1;
% classifies values that are smaller than the minimum as one level
s1 = find(data(:,:)<breaks_data(1));
for num=1:length(s1)
outdata(s1(num))=1;
end
% classifies values greater than the maximum as the highest level
s2 = find(data(:,:)>breaks_data(num_class));
for num=1:length(s2)
outdata(s2(num))=num_class;
end
% classifies intermediate values according to their size. Some values that are exactly equal to the intermediate value can be equal to one of the boundary states.
for i =1:num_class
    r=find(data(:,:)>=breaks_data(i)&data(:,:)<=breaks_data(i+1));
    for num=1:length(r)
        outdata(r(num))=i;
    end
end
    
end

