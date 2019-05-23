function [k_mst_matrix,k_mst_matrix_dis] = construct_k_mst_matrix(data,kn,nd,ni)
%Ϊ����data����k-MST�ṹ����
%%parameters
%input:
%data: ���ݼ�
%kn��k-MST�Ĳ���k
%nd: ����k���ھ������
%ni: ����k������������
%output:
%k_mst_matrix: k-MST�ṹ����
%   k_mst_matrix_dis: ��Ӧ�ṹ����ľ������
%%Other information
%Author: Wang Renmin
%Date: 2018.10.10

%%��ʼ����Ϣ
[r,~] = size(data);
%��ʼ��k_mst_matrix
%c = 2 .* (kn -1); %k-MST����
k_mst_matrix = [];
k_mst_matrix_dis = [];
%����k-MST����
%��ʼ�����ݱ��
dsnumbers = 1: r(1);

while ~isempty(dsnumbers)

    %��ǰk_mst������ʼ���
    start_point = dsnumbers(1);
    %������ʼ��㹹��һ��k_mst
    [k_mst,k_mst_dis] = construct_k_mst(start_point,kn,nd,ni);
    %���µ�k_mst����k_mst_matrix
    k_mst_matrix = [k_mst_matrix;k_mst];
    k_mst_matrix_dis = [k_mst_matrix_dis;k_mst_dis];
    %�����ݷ����������Ƴ��ѽ��������ݽ��
    dsnumbers = setdiff(dsnumbers,k_mst);
  
end
%�ڲ����ú�����������ʼ��㹹��һ��k_mst
function [a_k_mst,a_k_mst_dis] = construct_k_mst(start_point,k,nd,ni)
    %����һ�����ݹ���k���ڵ�k*k�������ڲ�ѯ��ǰ���ݵ������
    a_k_mst = []; %��ʼ��
    a_k_mst_dis = zeros(1,k-1); %��Ӧ�ľ�������
    a_k_mst(1) = start_point ; %��ʼ���
    %��ѯ��ʼ������һ�����
    start_point_next = ni(2,start_point); % ֱ�Ӳ�ѯ���еĵڶ�������
    a_k_mst(2) = start_point_next;
    a_k_mst_dis(1) = nd(1,start_point); % ��һ���ߵľ���
    %�����ӵıߣ�����֮��ľ���������Ϊ����󣬷�ֹ��·
    %nd(1,start_point) = inf; %1������Ϊ����
    %�Ƿ������k����
%     inverse_k = find(ni(:,start_point_next) == start_point, 1);
%     if ~isempty(inverse_k) %�������
%         nd(inverse_k - 1,start_point_next) = inf; %ע����ֵ-1
%     end
    %����k-2����
    for i = 1 : k-2
        %��ǰ�Ѵ��ڵĽ�㼯
        formed_points = unique(a_k_mst);
        %ȡ�Ѵ��ڽ���k���ھ�������
        k_distance_matrix = nd(:,formed_points);
        %ȡ�Ѵ��ڽ���k������������
        k_index_matrix = ni(:,formed_points);
        
        %���Ѵ��ڵĽ��ľ�����Ϊinf
        k_index_matrix_true = k_index_matrix(2:end,:); %��ȥ��һ������
        locs = ismember(k_index_matrix_true,formed_points); %�Ѵ��ڽ���λ��
        [locs_r,locs_c] = find(locs == 1); %���к�

        %inf����
        for m = 1:numel(locs_r)
            k_distance_matrix(locs_r(m),locs_c(m)) = inf; %
        end
        %��ѯ���е���Сֵ������λ��       
        min_value = min(min(k_distance_matrix)); %��Сֵ
        [row,col] = find(k_distance_matrix == min_value);% �������к�
        
        %�����Сֵ��ֹһ��ѡ������ǰ���һ��
        if length(row) > 1
            row = row(1);
            col = col(1);
        end
        %����ڹ��ɵı�
        cur_point = formed_points(col);%��col�е�ֵΪ��ǰ�����
        next_point = k_index_matrix_true(row ,col); %Ϊcol�У�row�еı��
        
        %���µı߼���a_k_mst��
        a_k_mst(2 .* i + 1) = cur_point;
        a_k_mst(2 .* i + 2) = next_point;
        
        %��i���ߵľ���
        a_k_mst_dis(i+1) = k_distance_matrix(row,col);
        %�������ı߾���
        %nd(row,cur_point) = inf;
        %�Ƿ�����k����
%         inverse_k = find(ni(:,next_point) == cur_point);
%         if ~isempty(inverse_k) %����
%             nd(inverse_k -1,next_point) = inf; %�������ҲΪ�����
%         end

               
    end
end
end
