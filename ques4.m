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

% %找(0,5)到(4,0)数据
% array1=[];%(4,0)方向
% for i=1:1:251 %第几行
%     j=round(i*4/5);
%     array1=[array1,num(252-i,j)];
% end
% len=length(array1);
% x=1:1:len;
% figure
% plot(x,array1+120)
%%
%分割第一块
% 给出三个点的坐标
X1 = 0;
Y1 = 0;
Z1 = -74.8;

X2 = 8*1852;
Y2 = 0;
Z2 = -74.8;

X3 = 0;
Y3 = 10*1852;
Z3 = -24.4;

tan_alpha = (Z3-Z1)/(5*1852);
alpha=atan(tan_alpha);
disp(['板块一的坡度：',num2str(alpha*180/pi)])
%%
D0=24.4;
theta = deg2rad(120);%转换成弧度值
%求解最浅处临界距离
syms x1
f = (D0+x1*tan(alpha))*cos(alpha)*(sin(theta/2)/cos(theta/2-alpha)) - x1;
solution = solve(f, x1);
x1 = double(solution);
%求解最深处临界距离
syms x3
f = (D0+x3*tan(alpha))*cos(alpha)*(sin(theta/2)/cos(theta/2+alpha)) + x3 - 5*1852;
solution = solve(f, x3);
x3 = double(solution);

%从最浅处临界值开始迭代航线
x_near=x3;
x=[];
x=[x,x_near];
len=[];
len=[len,4*1852*4/5];
while x_near >= x1  %没有迭代到西海岸之前
    syms x2
    f = 0.8*((D0+x2*tan(alpha))*cos(alpha)*sin(theta/2)/cos(theta/2+alpha)+(D0+x_near*tan(alpha))*cos(alpha)*sin(theta/2)/cos(theta/2-alpha))+x2-x_near;
    solution = solve(f, x2);
    % 将符号解转换为数值解
    len=[len,x_near*4/5];
    x_near = double(solution);
    x=[x,x_near];
end
disp(x')
disp(['一共有',num2str(length(x)),'条测线'])
disp(['远处迭代，测量长度为：',num2str(sum(len)),'米'])

%%
%计算重叠率大于20面积和漏测面积
%先算第一条
%找起始点格数
% t=10;
% m=fix((5*1852-x(t))/(0.02*1852))+1;
% 计算这一条航线上，往左往右分别可以扫几格
% if t==1
%     n=200;
% else m
%     n=4/5*x(t-1)/(0.02*1852);%可以前进几格
% end
% 
% mleft=[];
% mright=[];
% for i=1:1:n
%     for j=1:1:100
%         D=j*0.02*1852/tan(theta/2);%随着j变大，水深变大
%         if j <=m && D >= -num((251-m+j),i)  %碰到障碍物
%             mleft=[mleft,j];
%             break;
%         elseif j==m %到头了
%             mleft=[mleft,j];
%             break;
%         else
%             continue
%         end
%     end
%     for k=1:1:100
%         D=k*0.02*1852/tan(theta/2);%随着j变大，水深变大
%         if D >= -num((252-m-k),i)  %碰到障碍物
%             mright=[mright,j];
%             break;
%         else
%             continue
%         end
%     end
% end
%for t=1:1:length(x)
num_repeat=0;
repeat=[];
no=[];
num_no=0;
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
    m=fix((5*1852-x(t))/(0.02*1852))+1;
    %计算这一条航线上，往左往右分别可以扫几格
    if t==1
        n=200;
    else
        n=4/5*x(t-1)/(0.02*1852);%可以前进几格
    end
    
    mleft=[];
    mright=[];
    for i=1:1:n
        for j=1:1:100
            D=j*0.02*1852/tan(theta/2);%随着j变大，水深变大
            if j <=m && D >= -num((251-m+j),i)  %碰到障碍物
                mleft=[mleft,j-1];
                break;
            elseif j==m %到头了
                mleft=[mleft,j-1];
                break;
            else
                continue
            end
        end
        for k=1:1:100
            D=k*0.02*1852/tan(theta/2);%随着j变大，水深变大
            if D >= -num((252-m-k),i)  %碰到障碍物
                mright=[mright,k];
                break;
            else
                continue
            end
        end
    end
end