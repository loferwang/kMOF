function [k_dist,k_index] = getnnmatrix(A,k)
%��ȡdata��ÿ�����ݵ�k�����ھ�������Լ���Ӧ����������
%��Ϊÿ���㵽����ľ���Ϊ0,��Ȼ������ľ��룬����账�����ý���ĵ�һ������
%ndistancematrix:����������
%nindexmatrix:������������
%data:���ݼ�
%k:���ѯ������ڸ���
%author��Wang Renmin
%date:2017.10.16
    
%     %Find the nearest neighbors by "KDTree" for each elements
%     [k_index, k_dist] = knnsearch(A,A,'k',k+1,'nsmethod','kdtree','IncludeTies',true);
% 
%    %ת��Ϊ������ʽ
%    k_index = cell2mat(k_index);
%    k_dist = cell2mat(k_dist);
% 
%     %ת��
%     k_index = k_index';
%     k_dist = k_dist';
%     
%     k_dist = k_dist(2:end,:);
A=A(:,1:end-1);
[k_dist,k_index] = pdist2(A,A,'euclidean','Smallest',k+1);
k_dist = k_dist(2:end,:);

end
