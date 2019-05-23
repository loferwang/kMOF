function outliers = captureoutliers(otnss,tnsdismatrix,ovector)
% ���ÿ��otns�е���Ⱥ�㡣ͨ������otns�����ڽ��ľ����ƽ��ֵ��������ڸ�ƽ��ֵ��
%��Ͽ������Ͽ�λ��֮ǰ�ĵ�Ϊ��Ⱥ�㡣
% otnss,��Ⱥ�м��ϣ���Ⱥ�о���
%tnsdismatrix, ����ľ������
%ovector,��Ⱥ�к�
%outliers, ������Ⱥ�㼯��
%Author: Wang Renmin
%Date: 2018.4.9

%%��ʼ��

outliers = [];
%%��ȡ��Ⱥ����ľ������
otnsdismatrix = tnsdismatrix(ovector,:);

%% ��ȡotnsdismatrix��ÿ�о����ƽ��ֵ�����ҵ�����ƽ��ֵ�����λ��
%����ÿ�еľ�ֵ
%rowmean = mean(otnsdismatrix,2);
%����otnsdismatrix��ÿ�о�������ֵ����Ӧλ��
[maxvalues,locs] = max(otnsdismatrix,[ ],2);
%%����ÿ�д��ھ�ֵ�����λ��
%  [r,c] = size(otnsdismatrix);
% %��Ⱥλ�ø���ֵ
%  oposition = zeros(r,1);
%  for i = 1:r
%      p = find(otnsdismatrix(i,:) > rowmean(i) * 1.5); %ÿ�д��ھ�ֵ������λ��
%      oposition(i) = p(numel(p)); %ȡ���һ��λ��
%  end

 oposition = locs;
%% ��otns�и���λ��������ȡ��Ⱥ��
%��ȡ����Ⱥ��
%oposition = computerowpvector(otnsdismatrix);
r = size(oposition);
for j = 1: r
    %otns�е�λ��
    rowposition = oposition(j) * 2 -1;
    %����Ⱥ��
    temprowoutliers = otnss(j,1:rowposition);
    %ȥ���ظ����
    rowoutliers = unique(temprowoutliers);
    
    %������Ⱥ������
    k = numel(outliers);
    %������Ⱥ������
    n = numel(rowoutliers);
    %���ν�����Ⱥ�����outliers
    for m = 1:n
        outliers(k+m) = rowoutliers(m);
    end
    outliers = unique(outliers);
end
 function rowp = computexl(vector)
        %������б������λ��
        
        %��ȡvectorԪ�ظ���
        rown = numel(vector);
         %��ʼ��
        xl = zeros(1,rown-1);
        %������б�ʣ���Ϊ����ɢֵ������ֱ�Ӽ�������Ԫ�صĲ�ֵ
        for x = 1:rown-1
            xl(x) = vector(x) - vector(x+1);
        end
        %���ֵ����λ��
        [v,rowp] = max(xl);
 end
    function rowpvector = computerowpvector(outliermatrix)
        %�����������Ⱥ������󣬻�ȡÿ�����仯���ڵ�λ��
        %outliermatrix,��Ⱥ����ľ������
        %rowpvector,��������仯λ������
        %h��ȡ������������ֵ
        [line,col] = size(outliermatrix);
        
        %��ʼ�����
        rowpvector = zeros(line,1);
        
        %������
        for iline = 1:line
            rowpvector(iline) = computexl(outliermatrix(iline,:));
        end
    end
end

