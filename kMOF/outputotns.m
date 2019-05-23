function [otns,otns_topn_index] = outputotns(cf_vector,tns,topn)
%��cf_vector��ѡ��topn����Ϊ��Ⱥ��
%%parameters
%input:
%cf_vector: CF����
%tns��tns�ṹ����
%topn: topn����
%output:
%otns��outlier tns����
%otns_topn_index: ��ԭtns�е��б��
%%Other informatrion
%Author: Wang Renmin
%Date: 2018.10.10

%%��ʼ��

%%����cf_vector�е����topn��ֵ���ڵ��б��
[ordered_values, index] = sort(cf_vector,'descend');
otns_topn_index = index(1:topn);
otns = tns(otns_topn_index,:);
end