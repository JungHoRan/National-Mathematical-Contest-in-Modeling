clc,clear;
D00=13.0073;
alpha=deg2rad(1.5);%转换成弧度值
theta = deg2rad(120);%转换成弧度
beta=deg2rad(89.6);
d=2*1852*cos(beta);
[W11,W12]=fun(beta, D00,d*tan(alpha));
disp(W11)
disp(d)
% d_max=0;
% eta1=0;
% W11_record=0;
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