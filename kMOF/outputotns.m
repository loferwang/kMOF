function [otns,otns_topn_index] = outputotns(cf_vector,tns,topn)
%从cf_vector中选择topn行作为离群行
%%parameters
%input:
%cf_vector: CF向量
%tns：tns结构矩阵
%topn: topn参数
%output:
%otns：outlier tns矩阵
%otns_topn_index: 在原tns中的行标号
%%Other informatrion
%Author: Wang Renmin
%Date: 2018.10.10

%%初始化

%%查找cf_vector中的最大topn个值所在的行标号
[ordered_values, index] = sort(cf_vector,'descend');
otns_topn_index = index(1:topn);
otns = tns(otns_topn_index,:);
end