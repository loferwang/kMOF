function [k_mst_matrix,cf_vector,outliers] = kMOF(data,kn)
% main function
% input:
%   data: orignal data
%   kn: the size of kmst.like the parameter k of knn
%output:
%   k_mst_matrix: k-mst strcuture matrix
%   cf_vector: a vector of kMOF values
%   outliers: indices of outliers
%   For example:
%  excute [mst_matrix,kmofs,outliers] = kMOF(A,5), the outliers can be
%  detected for kn=5. Note that a topN need to be choosed according to
%  decision graph during running this program.
%Author :Wang Renmin
%Email:   wangrenmin@cqu.edu.cn

%Step 1，compute knn neighbors and indices for each instance
[nd,ni] = getnnmatrix(data,kn);
%Step2，construct k-mist sturctures for a dataset
[k_mst_matrix,k_mst_matrix_dis] = construct_k_mst_matrix(data,kn,nd,ni);


%% k-mst graph
figure
scatter(data(:,1),data(:,2),40,'.');
hold on
xlabel('x');
ylabel('y');
title('k-MST graph for the data');
plotnns(data,k_mst_matrix);
hold off

%Step 3，compute kMOF value for each sub-structure (that is  k-mst structures)
cf_vector = compute_cfvector(k_mst_matrix_dis);

% plot of ordered kMOF values 
sorted_cf = sort(cf_vector,'ascend'); %排序
% decision graph : a plot of sorted kMOF values
figure
plot(sorted_cf,'--.');
hold on
xlabel('No. of objects');
ylabel('kMOF');
title('decision graph');
ylim = get(gca,'ylim');
ylim(1) = 0;
set(gca,'ylim',ylim);
hold off

%set the topn of outlier-k-mst structures according to decision graph
[~,suspicious_index] = sort(cf_vector,'descend');
topn = input('Please input the parameter of top-n:');
outlier_kmst_numbers = suspicious_index(1:topn);
[otns] = outputotns(cf_vector,k_mst_matrix,topn);

%% figure the graph of outlier-k-msts
%figure
scatter(data(:,1),data(:,2),40,'.');
hold on
xlabel('x');
ylabel('y');
title('k-MST graph for the data');
plotnns(data,otns);
hold off

%% separate outliers from outlier sub-structures
outliers = capture_outliers(outlier_kmst_numbers,k_mst_matrix,k_mst_matrix_dis);
end
% sub-function of capture outliers from each sub-structure
function outliers = capture_outliers(outlier_kmst_numbers,k_mst_matrix,inner_relative_distancematrix)
%从离群子结构中分离出离群点
%找出离群行距离矩阵的行最大值的值和位置
outliers = [];
%离群子结构矩阵
outlier_kmst_matrix = k_mst_matrix(outlier_kmst_numbers,:);
%离群行的内部距离矩阵
outlier_kmst_inner_distancematrix = inner_relative_distancematrix(outlier_kmst_numbers,:);
%行内距离最大的位置
[~,locs] = max(outlier_kmst_inner_distancematrix,[],2);
%将距离位置转化为断开位置
outlier_locs = (locs * 2) -1;

%检测离群点
for i = 1:numel(outlier_kmst_numbers)
    %一个子结构的离群点或点集
    rowoutliers = outlier_kmst_matrix(i,1:outlier_locs(i));
    %加入结果集中
    outliers = [outliers,rowoutliers];
end
%对outliers进行处理，唯一化处理
outliers = unique(outliers);
end
