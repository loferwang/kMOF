function [k_mst_matrix,k_mst_matrix_dis] = construct_k_mst_matrix(data,kn,nd,ni)
%为数据data建立k-MST结构矩阵
%%parameters
%input:
%data: 数据集
%kn：k-MST的参数k
%nd: 数据k近邻距离矩阵
%ni: 数据k近邻索引矩阵
%output:
%k_mst_matrix: k-MST结构矩阵
%   k_mst_matrix_dis: 对应结构矩阵的距离矩阵
%%Other information
%Author: Wang Renmin
%Date: 2018.10.10

%%初始化信息
[r,~] = size(data);
%初始化k_mst_matrix
%c = 2 .* (kn -1); %k-MST列数
k_mst_matrix = [];
k_mst_matrix_dis = [];
%建构k-MST矩阵
%初始化数据编号
dsnumbers = 1: r(1);

while ~isempty(dsnumbers)

    %当前k_mst设置起始结点
    start_point = dsnumbers(1);
    %根据起始结点构建一条k_mst
    [k_mst,k_mst_dis] = construct_k_mst(start_point,kn,nd,ni);
    %将新的k_mst加入k_mst_matrix
    k_mst_matrix = [k_mst_matrix;k_mst];
    k_mst_matrix_dis = [k_mst_matrix_dis;k_mst_dis];
    %从数据符号向量中移除已建立的数据结点
    dsnumbers = setdiff(dsnumbers,k_mst);
  
end
%内部调用函数：根据起始结点构建一条k_mst
function [a_k_mst,a_k_mst_dis] = construct_k_mst(start_point,k,nd,ni)
    %建立一个数据关于k近邻的k*k矩阵，用于查询当前数据的最近邻
    a_k_mst = []; %初始化
    a_k_mst_dis = zeros(1,k-1); %对应的距离向量
    a_k_mst(1) = start_point ; %起始结点
    %查询起始结点的下一个结点
    start_point_next = ni(2,start_point); % 直接查询该列的第二列数据
    a_k_mst(2) = start_point_next;
    a_k_mst_dis(1) = nd(1,start_point); % 第一条边的距离
    %已连接的边，将其之间的距离数据设为无穷大，防止回路
    %nd(1,start_point) = inf; %1近邻设为无穷
    %是否存在逆k近邻
%     inverse_k = find(ni(:,start_point_next) == start_point, 1);
%     if ~isempty(inverse_k) %如果存在
%         nd(inverse_k - 1,start_point_next) = inf; %注意行值-1
%     end
    %建立k-2条边
    for i = 1 : k-2
        %当前已存在的结点集
        formed_points = unique(a_k_mst);
        %取已存在结点的k近邻距离数据
        k_distance_matrix = nd(:,formed_points);
        %取已存在结点的k近邻索引数据
        k_index_matrix = ni(:,formed_points);
        
        %将已存在的结点的距离设为inf
        k_index_matrix_true = k_index_matrix(2:end,:); %除去第一行索引
        locs = ismember(k_index_matrix_true,formed_points); %已存在结点的位置
        [locs_r,locs_c] = find(locs == 1); %行列号

        %inf处理
        for m = 1:numel(locs_r)
            k_distance_matrix(locs_r(m),locs_c(m)) = inf; %
        end
        %查询其中的最小值和所在位置       
        min_value = min(min(k_distance_matrix)); %最小值
        [row,col] = find(k_distance_matrix == min_value);% 所在行列号
        
        %如果最小值不止一个选择排在前面的一个
        if length(row) > 1
            row = row(1);
            col = col(1);
        end
        %最近邻构成的边
        cur_point = formed_points(col);%第col列的值为当前结点编号
        next_point = k_index_matrix_true(row ,col); %为col列，row行的编号
        
        %将新的边加入a_k_mst中
        a_k_mst(2 .* i + 1) = cur_point;
        a_k_mst(2 .* i + 2) = next_point;
        
        %第i条边的距离
        a_k_mst_dis(i+1) = k_distance_matrix(row,col);
        %处理建立的边距离
        %nd(row,cur_point) = inf;
        %是否是逆k近邻
%         inverse_k = find(ni(:,next_point) == cur_point);
%         if ~isempty(inverse_k) %存在
%             nd(inverse_k -1,next_point) = inf; %设逆距离也为无穷大
%         end

               
    end
end
end
