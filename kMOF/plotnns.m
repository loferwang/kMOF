function plotnns(data,nns)
%������ṹ��ƽ��ͼ����ʾ����
%data:���ݼ�
%nns:����ṹ����о���
%author:Wang Renmin
%date:2017.10.28
%sytle:��ͼ��ʽ��������ʽ������ʾ��С����ɫ
%%��ʼ��
[r,c] = size(nns); %��ȡnns������ֵ
%color_vector = ['b','r','c','g','m','y'];
%%����
for i = 1:r
    %style = rem(i,length(color_vector)) + 1;
    for j = 1:2:c %ÿ�е�������������������
        cur = [data(nns(i,j),1),data(nns(i,j+1),1)];  %��һ�����
        next = [data(nns(i,j),2),data(nns(i,j+1),2)]; %��һ�����
        
        %����
        %plot(cur,next,color_vector(style));
        plot(cur,next,'k-');
        hold on
    end
end
end