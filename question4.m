clc,clear;
[num]=xlsread('附件.xlsx' ,'C3:GU253'); 
x_data = 0:0.02:4;
y_data = 0:0.02:5;
%colormap('hsv');
num=-num;
figure
contour3(x_data,y_data,num,levelstep =0.75)
%surf(x_data, y_data, num);

% 设置颜色映射，例如使用 'jet' 颜色映射
%由公式推导出新的

%%
%分割第一块
% 给出三个点的坐标
% 输入三个点的坐标
A = [0,0, -44.8];
B = [4*1852, 0, -197.2];
C = [4*1852, 5*1852, -44.8];

tan_alpha = (197.2-44.8)/(20*1852/sqrt(41));
alpha=atan(tan_alpha);
theta = deg2rad(120);%转换成弧度值
beta=pi/2+atan(4/5);%行驶方向与坡度法向水平投影的夹角
disp(['板块二的坡度：',num2str(alpha*180/pi)])
%%
num_repeat=0;
repeat=[];
no=[];
num_no=0;
d0=0.25;
x=d0:d0:4-d0;
x=x*1852;
len=sum(x)*5/4;
disp(['一共有',num2str(length(x)),'条测线'])
disp(['总距离',num2str(len)])
%%
for t=1:1:length(x)-2
    [m_left1,m_right1,m1,n1] = fun(t,x,theta,num);
    [m_left2,m_right2,m2,n2] = fun(t+1,x,theta,num);
    %重叠超过20%的数量
    for s=1:1:n2
        if (m2-m1)<0.8*(m_right1(s)+m_left2(s))
            num_repeat=num_repeat+1; 
        end
        if (m2-m1-1)>(m_right1(s)+m_left2(s))
            num_no=num_no+1;
        end
    end
    repeat=[repeat,num_repeat];
    no=[no,num_no];
end
disp('漏测百分比')
disp(num_no/250)
disp('重叠长度')
disp(0.02*1852*num_repeat)
function [mleft,mright,m,n] = fun(t,x,theta,num)
    m=fix(x(t)/(0.02*1852))+1;
    %计算这一条航线上，往左往右分别可以扫几格
    if t==1
        n=250;
    else
        n=(4*1852-x(t))*5/4/0.02/1852;%可以前进几格
    end
    
    mleft=[];
    mright=[];
    for i=1:1:n
        for j=1:1:100
            D=j*0.02*1852/tan(theta/2);%随着j变大，水深变大
            if j <=m && D >= -num((252-i),(201-m+j))  %碰到障碍物
                mright=[mright,j-1];
                break;
            elseif j==m %到头了
                mright=[mright,j-1];
                break;
            else
                continue
            end
        end
        for k=1:1:100
            D=k*0.02*1852/tan(theta/2);%随着j变大，水深变大
            if D >= -num((252-i),(202-m-k))  %碰到障碍物
                mleft=[mleft,k];
                break;
            else
                continue
            end
        end
    end
end
% function [W1,W2] = fun1(beta, D0,x)
%     alpha=deg2rad(1.5);%转换成弧度值
%     theta = deg2rad(120);%转换成弧度值
%     gamma=atan(sin(beta)*tan(alpha));
%     D=D0+x.*cos(beta)*tan(alpha);
%     W1 = D.*cos(gamma)*sin(theta/2)/cos(theta/2-gamma);
%     W2 = D.*cos(gamma)*sin(theta/2)/cos(theta/2+gamma);
% end
% function eta = repeat1(d,W12,W21)
%     eta = 1 - d./(W12+W21);
% end