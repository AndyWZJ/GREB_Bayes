X = [randn(50,2)+ones(50,2);randn(50,2)-ones(50,2);randn(50,2)+[ones(50,1),-ones(50,1)]];
%clustering
opts = statset('Display','final');


%Format conversion: The data is transformed into the data format required by the clustering algorithm, that is, number * latitude
data =mean(qmn_greb_quarter,3);

data =air_quarter;
x=1;
for i =1:96
    for j=1:48
    cluster_data(x,1)=j;
    cluster_data(x,2)=i;
    for z = 1:120
    cluster_data(x,z+2)=data(i,j,z);
    end
    x=x+1;
    end
end
x=1;

%K - means clustering
[Idx,C]=kmeans(cluster_data,6);

%Let's get back to the matrix
result_data = reshape(Idx,96,48);
heatmap(rot90(result_data));