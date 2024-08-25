%%
%水深
clc,clear
alpha=deg2rad(1.5);%转换成弧度值
D_mid=110;
x=-2:0.1:2;
x=1852.*x;
D=D_mid+x*tan(alpha);
disp(D')
%%
clc,clear
D0=13.0073;
alpha=deg2rad(1.5);%转换成弧度值
theta = deg2rad(120);%转换成弧度值
%求解最浅处临界距离
syms x1
f = (D0+x1*tan(alpha))*cos(alpha)*(sin(theta/2)/cos(theta/2-alpha)) - x1;
solution = solve(f, x1);
x1 = double(solution);
%求解最深处临界距离
syms x3
f = (D0+x3*tan(alpha))*cos(alpha)*(sin(theta/2)/cos(theta/2+alpha)) + x3 - 7408;
solution = solve(f, x3);
x3 = double(solution);

%从最浅处临界值开始迭代航线
x_far=x1;
x=[];
x=[x,x_far];

while x_far <= x3  %没有迭代到西海岸之前
    syms x2
    f = 0.85*((D0+x2*tan(alpha))*cos(alpha)*sin(theta/2)/cos(theta/2-alpha)+(D0+x_far*tan(alpha))*cos(alpha)*sin(theta/2)/cos(theta/2+alpha))-x2+x_far;
    solution = solve(f, x2);
    % 将符号解转换为数值解
    x_far = double(solution);
    x=[x,x_far];
end
disp(x')
disp(['一共有',num2str(length(x)),'条测线'])
disp(['近处迭代，测量长度为：',num2str(length(x)*2*1852),'米'])
%%
clc,clear
D0=13.0073;
alpha=deg2rad(1.5);%转换成弧度值
theta = deg2rad(120);%转换成弧度值
%求解最浅处临界距离
syms x1
f = (D0+x1*tan(alpha))*cos(alpha)*(sin(theta/2)/cos(theta/2-alpha)) - x1;
solution = solve(f, x1);
x1 = double(solution);
%求解最深处临界距离
syms x3
f = (D0+x3*tan(alpha))*cos(alpha)*(sin(theta/2)/cos(theta/2+alpha)) + x3 - 7408;
solution = solve(f, x3);
x3 = double(solution);

%从最浅处临界值开始迭代航线
x_near=x3;
x=[];
x=[x,x_near];

while x_near >= x1  %没有迭代到西海岸之前
    syms x2
    f = 0.9*((D0+x2*tan(alpha))*cos(alpha)*sin(theta/2)/cos(theta/2+alpha)+(D0+x_near*tan(alpha))*cos(alpha)*sin(theta/2)/cos(theta/2-alpha))+x2-x_near;
    solution = solve(f, x2);
    % 将符号解转换为数值解
    x_near = double(solution);
    x=[x,x_near];
end
disp(x')
disp(['一共有',num2str(length(x)),'条测线'])
disp(['远处迭代，测量长度为：',num2str(length(x)*2*1852),'米'])