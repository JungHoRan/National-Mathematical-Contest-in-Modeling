clc,clear;
D00=13.0073;
result=[];
result=[result,D00];
alpha=deg2rad(1.5);%转换成弧度值
theta = deg2rad(120);%转换成弧度
beta=deg2rad(89.67);
%先算东南角是否合理
% d=2*1852/cos(beta);
% syms x1
% gamma=atan(sin(beta)*tan(alpha));
% D=D00+x1.*cos(beta)*tan(alpha);
% W1 = D.*cos(gamma)*sin(theta/2)/cos(theta/2-gamma);
% f = W1 - x1/tan(beta);
% solution = solve(f, x1);
% x1 = double(solution);
% m=2*1852-x1/sin(beta);
% d=m*cos(beta);
% D=D00+(d*sin(beta))*tan(alpha);
% x=[0:100:((2*1852-2386)/sin(beta))];%确定d,遍历x
% [W11,W12]=fun(beta, D00,x);
% [W21,W22]=fun(beta, D,x);
% eta=repeat(d,W12,W21);
% disp(eta)
%%
%算西北角临界深度
D0=197.61;
n=(207-D0)/tan(alpha);
x=n*sin(beta);
[W11,W12]=fun(beta, D0,x);
disp(['W12是',num2str(W12)])
disp(['距离西北角',num2str(n*sin(beta))])
%%

while D00<197.61
    for d_try=1:0.1:2000
        D0=D00+(d_try/sin(beta)-d_try*sin(beta))*tan(alpha);
        delta_d=d_try*sin(beta);
        D=D0+delta_d*tan(alpha);
        x=[0:100:(2*1852/sin(beta)-d_try/tan(beta))];%确定d,遍历x
        [W11,W12]=fun(beta, D0,x);
        [W21,W22]=fun(beta, D,x);
        eta=repeat(d_try,W12,W21);
        if min(eta) >= 0.1 && max(eta) <= 0.2
            d_max=d_try;
            eta1=eta;
            W11_record=W11;
        end
    end
    D00 = d_max*sin(beta)*tan(alpha)+D00
    result=[result,D00];
end
disp(length(result))
% for d_try=1:0.1:2000
%     D0=D00+(d_try/sin(beta)-d_try*sin(beta))*tan(alpha);
%     delta_d=d_try*sin(beta);
%     D=D0+delta_d*tan(alpha);
%     x=[0:100:(2*1852/sin(beta)-d_try/tan(beta))];%确定d,遍历x
%     [W11,W12]=fun(beta, D0,x);
%     [W21,W22]=fun(beta, D,x);
%     eta=repeat(d_try,W12,W21);
%     if min(eta) >= 0.1 && max(eta) <= 0.2
%         d_max=d_try;
%         eta1=eta;
%         W11_record=W11;
%     end
% end
% disp(d_max)
% disp(d_max*sin(beta)*tan(alpha)+D00)
% disp(eta1)
% 
% for d_try2=1:0.1:2000
%     D=D00-(d_try2*sin(beta))*tan(alpha);
%     x=[0:100:(2*1852/sin(beta)-d_try2/tan(beta))];%确定d,遍历x
%     [W11,W12]=fun(beta, D00,x);
%     [W21,W22]=fun(beta, D,x);
%     eta=repeat(d_try2,W12,W21);
%     if min(eta) >= 0.1 && max(eta) <= 0.2
%         d_max=d_try2;
%         eta1=eta;
%         W11_record=W11;
%     end
% end
% disp(d_max)
% disp(eta1)
%%
clc,clear;
D00=197.61;
result=[];
result=[result,D00];
alpha=deg2rad(1.5);%转换成弧度值
theta = deg2rad(120);%转换成弧度
beta=deg2rad(89.67);
while D00>13
    for d_try2=1:0.1:2000
        D=D00-(d_try2*sin(beta))*tan(alpha);
        x=[0:100:(2*1852/sin(beta)-d_try2/tan(beta))];%确定d,遍历x
        [W11,W12]=fun(beta, D00,x);
        [W21,W22]=fun(beta, D,x);
        eta=repeat(d_try2,W12,W21);
        if min(eta) >= 0.1 && max(eta) <= 0.2
            d_max=d_try2;
            eta1=eta;
            W11_record=W11;
        end
    end
    D00 = D00-d_max*sin(beta)*tan(alpha)
    result=[result,D00];
end
disp(length(result))
% for d_try=1:0.1:2000
%     D0=D00+(d_try/sin(beta)-d_try*sin(beta))*tan(alpha);
%     delta_d=d_try*sin(beta);
%     D=D0+delta_d*tan(alpha);
%     x=[0:100:(2*1852/sin(beta)-d_try/tan(beta))];%确定d,遍历x
%     [W11,W12]=fun(beta, D0,x);
%     [W21,W22]=fun(beta, D,x);
%     eta=repeat(d_try,W12,W21);
%     if min(eta) >= 0.1 && max(eta) <= 0.2
%         d_max=d_try;
%         eta1=eta;
%         W11_record=W11;
%     end
% end
% disp(d_max)
% disp(d_max*sin(beta)*tan(alpha)+D00)
% disp(eta1)
% 
% for d_try2=1:0.1:2000
%     D=D00-(d_try2*sin(beta))*tan(alpha);
%     x=[0:100:(2*1852/sin(beta)-d_try2/tan(beta))];%确定d,遍历x
%     [W11,W12]=fun(beta, D00,x);
%     [W21,W22]=fun(beta, D,x);
%     eta=repeat(d_try2,W12,W21);
%     if min(eta) >= 0.1 && max(eta) <= 0.2
%         d_max=d_try2;
%         eta1=eta;
%         W11_record=W11;
%     end
% end
% disp(d_max)
% disp(eta1)
%%
%求解西北角
D0=197.61;
alpha=deg2rad(1.5);%转换成弧度值
theta = deg2rad(120);%转换成弧度
beta=deg2rad(89.02);
n=(207-D0)/tan(alpha);
x=n*sin(beta);
[W11,W12]=fun(beta, D0,x);
disp(['W12是',num2str(W12)])
disp(['距离西北角',num2str(n*sin(beta))])
%%
%符合要求

%该角度下东南角求解
alpha=deg2rad(1.5);%转换成弧度值
theta = deg2rad(120);%转换成弧度
beta=deg2rad(89.02);
syms x1
gamma=atan(sin(beta)*tan(alpha));
D=D0+x1.*cos(beta)*tan(alpha);
W1 = D.*cos(gamma)*sin(theta/2)/cos(theta/2-gamma);
f = W1 - x1/tan(beta);
solution = solve(f, x1);
x1 = double(solution);
m=2*1852-x1/sin(beta);
d=m*cos(beta);
%d=40.8215;
D00=13.0074;
D=D00+(d*sin(beta))*tan(alpha);
x=[0:100:((2*1852-2386)/sin(beta))];%确定d,遍历x
[W11,W12]=fun(beta, D00,x);
[W21,W22]=fun(beta, D,x);
eta=repeat(d,W12,W21);
disp(eta)


%%
function [W1,W2] = fun(beta, D0,x)
    alpha=deg2rad(1.5);%转换成弧度值
    theta = deg2rad(120);%转换成弧度值
    gamma=atan(sin(beta)*tan(alpha));
    D=D0+x.*cos(beta)*tan(alpha);
    W1 = D.*cos(gamma)*sin(theta/2)/cos(theta/2-gamma);
    W2 = D.*cos(gamma)*sin(theta/2)/cos(theta/2+gamma);
end
function eta = repeat(d,W12,W21)
    eta = 1 - d./(W12+W21);
end