function [k_dist,k_index] = getnnmatrix(A,k)
%获取data中每个数据的k个近邻距离矩阵，以及对应的索引矩阵
%因为每个点到自身的距离为0,必然是最近的距离，因此需处理所得结果的第一行数据
%ndistancematrix:邻域距离矩阵
%nindexmatrix:邻域索引矩阵
%data:数据集
%k:需查询的最近邻个数
%author：Wang Renmin
%date:2017.10.16
    
%     %Find the nearest neighbors by "KDTree" for each elements
%     [k_index, k_dist] = knnsearch(A,A,'k',k+1,'nsmethod','kdtree','IncludeTies',true);
% 
%    %转换为矩阵形式
%    k_index = cell2mat(k_index);
%    k_dist = cell2mat(k_dist);
% 
%     %转置
%     k_index = k_index';
%     k_dist = k_dist';
%     
%     k_dist = k_dist(2:end,:);
A=A(:,1:end-1);
[k_dist,k_index] = pdist2(A,A,'euclidean','Smallest',k+1);
k_dist = k_dist(2:end,:);

end
