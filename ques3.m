%不考虑海域外延伸
clc,clear
D0=13.0073;
alpha=deg2rad(1.5);%转换成弧度值
theta = deg2rad(120);%转换成弧度值
for i=0.98
    D0=13.0073;
    alpha=deg2rad(1.5);%转换成弧度值
    theta = deg2rad(120);%转换成弧度值
    m=0;D0=13.0073;eta=[];

    beta=deg2rad(90-i);
    disp(['现在的β是：',num2str(90-i)])
    %找第一条测线
    %找到航线东海岸起点
    syms x1
    gamma=atan(sin(beta)*tan(alpha));
    D=D0+x1.*cos(beta)*tan(alpha);
    W1 = D.*cos(gamma)*sin(theta/2)/cos(theta/2-gamma);
    f = W1 - x1/tan(beta);
    solution = solve(f, x1);
    x1 = double(solution);
    m=2*1852-x1/sin(beta);
    disp(['起点距离原点',num2str(m),'米'])
    d_door=m*cos(beta);
    disp(['d的门限值为',num2str(d_door)])
    %
    
    x=[];
    x=[x,x1];
    d_max=0;
    %找第二条线
    for d_try=1:0.5:2000
        delta_d=d_try*sin(beta);
        D=D0+delta_d*tan(alpha);
        x=[0:100:x1/sin(beta)/sin(beta)];%确定d,遍历x
        [W11,W12]=fun(beta, D0,x);
        [W21,W22]=fun(beta, D,x);
        eta=repeat(d_try,W12,W21);
        if min(eta) >= 0.1 && max(eta) <= 0.2
            d_max=d_try;
        end
    end

    
    if d_max==0
        disp('找不到符合条件的第二条测线')
    else
        disp(['第二轮d_max',num2str(d_max)])
    end
    
    %找第三条线
    if d_max/cos(beta) > m   %起点在北岸
        n=(d_max/cos(beta)-m)/tan(beta);%此时该航线起点到原点距离
        d_max=0;
        for d_try=1:0.5:2000
            D0_r=D0+(n+d_try*cos(beta)/tan(beta))*tan(alpha);
            delta_d=d_try*sin(beta);
            D=D0_r+delta_d*tan(alpha);
            x=[0:100:(2*1852-d_try/tan(beta))/sin(beta)];%确定d,遍历x
            [W11,W12]=fun(beta, D0_r,x);
            [W21,W22]=fun(beta, D,x);
            eta=repeat(d_try,W12,W21);
            if min(eta) >= 0.1 && max(eta) <= 0.2
                d_max=d_try;
            end
        end
    else %起点在东岸
        m=(m-d_max/cos(beta));%距离原点的新的距离
        d_max=0;
        for d_try=1:0.5:2000
            delta_d=d_try*sin(beta);
            D=D0+delta_d*tan(alpha);
            x=[0:100:(2*1852-m)/sin(beta)];%确定d,遍历x
            [W11,W12]=fun(beta, D0,x);
            [W21,W22]=fun(beta, D,x);
            eta=repeat(d_try,W12,W21);
            if min(eta) >= 0.1 && max(eta) <= 0.2
                d_max=d_try;
            end
        end
    if d_max==0
        disp('找不到符合条件的第三条测线')
    else
        disp(['第三轮d_max',num2str(d_max)])
    end
    end
end
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