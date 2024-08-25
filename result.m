clc,clear
%问题一
%符号定义：s、d、D0、D、x、W1、W2、Wi1、Wi2、α、β、θ、η、γ
%W1为沿测线方向左侧覆盖范围，W2为沿测线方向右侧覆盖范围
%Wi1为第i条测线沿测线方向左侧覆盖范围，Wi2为第i条测线沿测线方向右侧覆盖范围
%假设测线之间相互平行
%假设覆盖宽度是水平段的宽度
%假设测线距中心处距离为s，且s为正是水浅方向
%假设海域中心点处水深为D0,其他位置为D

%海水深度：D=D0-s*tanα  s为正减小，为负增大
alpha=deg2rad(1.5);%转换成弧度值
d=200;
s=[-800,-600,-400,-200,0,200,400,600,800];
D=70-s.*tan(alpha);
disp('海水深度：')
disp(D')

%覆盖宽度：W=W1+W2=D*cosα*(sin(θ/2)/cos(θ/2+α)+sin(θ/2)/cos(θ/2-α))
theta = deg2rad(120);%转换成弧度值
W1 = D.*cos(alpha)*sin(theta/2)/cos(theta/2+alpha);
W2 = D.*cos(alpha)*sin(theta/2)/cos(theta/2-alpha);%浅的一侧
W = W1 + W2;
disp('覆盖宽度：')
disp(W')
%相邻线条重叠率：η=1-d/Wi2+W(i+1)1
len=length(W);%len为测线条数
eta=zeros(1,len-1);
for i = 1:len-1
    eta(i)=1-d/(W2(i)+W1(i+1));
end
disp('相邻线条重叠率：')
disp(eta')
%%
clc,clear
%问题二
%γ是不同测线方向的真实坡度
%γ=arctan(sinβ*tanα)
%D=D0+x*cosβ*tanα
%x是船行驶的距离
alpha=1.5*pi/180;%转换成弧度值
theta = 120*pi/180;%转换成弧度值
beta=0:45:315;
beta=deg2rad(beta);
x=0:0.3:2.1;
x=x.*1852;%转换成米
len1=length(beta);%行数
len2=length(x);%列数
D0=120;%海域中心点处水深
W=zeros(len1,len2);
for i=1:len1    %先写第一行   
    gamma=atan(sin(beta(i))*tan(alpha));
    D=D0+x.*cos(beta(i))*tan(alpha);
    W1 = D.*cos(gamma)*sin(theta/2)/cos(theta/2-gamma);%浅的一侧
    W2 = D.*cos(gamma)*sin(theta/2)/cos(theta/2+gamma);
    W(i,:) = W1 + W2;
end
disp('覆盖宽度：')
disp(W)
%%
% 问题三
clc,clear;
alpha=1.5*pi/180;%转换成弧度值
theta = 120*pi/180;%转换成弧度值
beta=89.5;%
beta=deg2rad(beta);

x=[0,2*1852/sin(beta)];%转换成米
D0=13;%海域中心点处水深
gamma=atan(sin(beta)*tan(alpha));
D=D0+x.*cos(beta)*tan(alpha);
W1 = D.*cos(gamma)*sin(theta/2)/cos(theta/2-gamma);
W2 = D.*cos(gamma)*sin(theta/2)/cos(theta/2+gamma);


