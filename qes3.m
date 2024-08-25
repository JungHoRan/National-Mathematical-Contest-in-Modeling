clc,clear
D0=13.0073;
alpha=deg2rad(1.5);%转换成弧度值
theta = deg2rad(120);%转换成弧度值
for i=1
    beta=deg2rad(90-i);
    %找到航线东海岸起点
    
%     disp(x1)
%     disp(m)
    %找到扫描区域与海岸线交点
    syms x1_n
    gamma=atan(sin(beta)*tan(alpha));
    D=D0+x1_n.*cos(beta)*tan(alpha);
    W2 = D.*cos(gamma)*sin(theta/2)/cos(theta/2+gamma);
    f = W2 - (x1_n-x1)*tan(beta);
    solution = solve(f, x1_n);
    x1_n = double(solution);
%     disp(x1_n-x1)
    %找到扫描区域与海岸线交点
    syms x1_e
    gamma=atan(sin(beta)*tan(alpha));
    D=D0+x1_e.*cos(beta)*tan(alpha);
    W2 = D.*cos(gamma)*sin(theta/2)/cos(theta/2+gamma);
    f = W2 - (x1_e-x1)/tan(beta);
    solution = solve(f, x1_e);
    x1_e = double(solution);
    disp(x1_e)
    %检测下一次如果从原点是否满足
    disp(['第一条航线的距离：',num2str(x1_e+x1_n)])
    d_door=m*cos(beta);
%     disp('d的门限值为')
%     disp(d_door)
    %
    d_max=0;
    for d_try=10:50:200
        delta_D=D0+d_try*sin(beta)-x1_e/tan(beta);
        D=D0+delta_D*tan(alpha);
        x=[0:100:x1_e+x1_n];%确定d,遍历x
        [W11,W12]=fun(beta, D0,x);
        [W21,W22]=fun(beta, D,x);
        eta=repeat(d_try,W12,W21);
        disp(eta)
%         if min(eta) >= 0.1 && max(eta) <= 0.2
%             disp('此时d为：')
%             disp(d_try)
%             d_max=d_try;
%         end
    end
%     if d_max==0
%         disp('找不到符合条件的第二条测线')
%     end
end

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

%%
% D0 = 13.0073;
% alpha = deg2rad(1.5); % 转换成弧度值
% theta = deg2rad(120); % 转换成弧度值
% 
% syms beta gamma % 声明符号变量 beta 和 gamma
% 
% gamma = atan(sin(beta) * tan(alpha));
% x1 = 2 * 1852 * sin(beta);
% D = D0 + x1 * cos(beta) * tan(alpha);
% W1 = D * cos(gamma) * sin(theta/2) / cos(theta/2 - gamma);
% 
% % 修正 f 的定义
% f = W1 - x1 / tan(beta);
% 
% % 求解方程 f = 0，得到 beta 的值
% solutions = solve(f, beta);
% 
% % 打印解
% fprintf('解 beta 的值为：\n');
% disp(solutions);
