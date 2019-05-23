function cf_vector = compute_cfvector(inner_relative_distancematrix)
%����ÿ���ṹ��CFֵ
%%parameters
% imput:
% inner_relative_distancematrix: �ṹ���ڲ���Ծ������
% output:
%cf_vector: CFֵ������
%%Other information
%Author: Wang Renmin
%Date: 2018.10.10

%%��ʼ��
[r,c] = size(inner_relative_distancematrix);
cf_vector = zeros(r,1);

%% ����CFֵ
for i = 1:r
    %��һ�������ҵ�i�е����ֵalpha
    alpha = max(inner_relative_distancematrix(i,:));
    %�ڶ����������i�г����ֵalpha��ľ�ֵbeta
    beta = (sum(inner_relative_distancematrix(i,:)) - alpha) ./ (c-1);
    %�������������i�е�CFֵ
    cf = alpha ./ beta;
    cf_vector(i) = cf;
end
end