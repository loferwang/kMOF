function cf_vector = compute_cfvector(inner_relative_distancematrix)
%计算每个结构的CF值
%%parameters
% imput:
% inner_relative_distancematrix: 结构的内部相对距离矩阵
% output:
%cf_vector: CF值列向量
%%Other information
%Author: Wang Renmin
%Date: 2018.10.10

%%初始化
[r,c] = size(inner_relative_distancematrix);
cf_vector = zeros(r,1);

%% 计算CF值
for i = 1:r
    %第一步：查找第i行的最大值alpha
    alpha = max(inner_relative_distancematrix(i,:));
    %第二步：计算第i行除最大值alpha外的均值beta
    beta = (sum(inner_relative_distancematrix(i,:)) - alpha) ./ (c-1);
    %第三步：计算第i行的CF值
    cf = alpha ./ beta;
    cf_vector(i) = cf;
end
end