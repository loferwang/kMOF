function plotnns(data,nns)
%将邻域结构在平面图中显示出来
%data:数据集
%nns:领域结构结点行矩阵
%author:Wang Renmin
%date:2017.10.28
%sytle:绘图样式：连线样式，结点表示大小，颜色
%%初始化
[r,c] = size(nns); %获取nns的行列值
%color_vector = ['b','r','c','g','m','y'];
%%连线
for i = 1:r
    %style = rem(i,length(color_vector)) + 1;
    for j = 1:2:c %每行的数据两两结点才是连线
        cur = [data(nns(i,j),1),data(nns(i,j+1),1)];  %第一个结点
        next = [data(nns(i,j),2),data(nns(i,j+1),2)]; %下一个结点
        
        %连接
        %plot(cur,next,color_vector(style));
        plot(cur,next,'k-');
        hold on
    end
end
end