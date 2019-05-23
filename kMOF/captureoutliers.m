function outliers = captureoutliers(otnss,tnsdismatrix,ovector)
% 检测每个otns中的离群点。通过计算otns中相邻结点的距离的平均值，如果大于该平均值，
%则断开，最后断开位置之前的点为离群点。
% otnss,离群行集合（离群行矩阵）
%tnsdismatrix, 结点间的距离矩阵
%ovector,离群行号
%outliers, 返回离群点集合
%Author: Wang Renmin
%Date: 2018.4.9

%%初始化

outliers = [];
%%获取离群矩阵的距离矩阵
otnsdismatrix = tnsdismatrix(ovector,:);

%% 获取otnsdismatrix中每行距离的平均值，并找到大于平均值的最后位置
%计算每行的均值
%rowmean = mean(otnsdismatrix,2);
%计算otnsdismatrix中每行距离的最大值及相应位置
[maxvalues,locs] = max(otnsdismatrix,[ ],2);
%%查找每行大于均值的最后位置
%  [r,c] = size(otnsdismatrix);
% %离群位置赋初值
%  oposition = zeros(r,1);
%  for i = 1:r
%      p = find(otnsdismatrix(i,:) > rowmean(i) * 1.5); %每行大于均值的所有位置
%      oposition(i) = p(numel(p)); %取最后一个位置
%  end

 oposition = locs;
%% 在otns中根据位置向量获取离群点
%获取行离群点
%oposition = computerowpvector(otnsdismatrix);
r = size(oposition);
for j = 1: r
    %otns中的位置
    rowposition = oposition(j) * 2 -1;
    %行离群点
    temprowoutliers = otnss(j,1:rowposition);
    %去除重复结点
    rowoutliers = unique(temprowoutliers);
    
    %现有离群点数量
    k = numel(outliers);
    %新增离群点数量
    n = numel(rowoutliers);
    %依次将行离群点加入outliers
    for m = 1:n
        outliers(k+m) = rowoutliers(m);
    end
    outliers = unique(outliers);
end
 function rowp = computexl(vector)
        %计算行斜率最大的位置
        
        %获取vector元素个数
        rown = numel(vector);
         %初始化
        xl = zeros(1,rown-1);
        %依次求斜率，因为是离散值，所以直接计算相邻元素的差值
        for x = 1:rown-1
            xl(x) = vector(x) - vector(x+1);
        end
        %最大值所在位置
        [v,rowp] = max(xl);
 end
    function rowpvector = computerowpvector(outliermatrix)
        %根据输入的离群距离矩阵，获取每行最大变化所在的位置
        %outliermatrix,离群矩阵的距离矩阵
        %rowpvector,行最大距离变化位置向量
        %h获取距离矩阵的行列值
        [line,col] = size(outliermatrix);
        
        %初始化结果
        rowpvector = zeros(line,1);
        
        %计算结果
        for iline = 1:line
            rowpvector(iline) = computexl(outliermatrix(iline,:));
        end
    end
end

