clc,clear;
D0=13.0073;
%D0 = 206.9927;
D=[];
D=[D,D0];
lens=[];
alpha = deg2rad(1.5);%转换成弧度值
theta = deg2rad(120);%转换成弧度
while D0<184
    x=D0*tan(theta/2);%该深度边线长度
    n=fix(2*1852/1.8*x);%包含多少个间隔
    m=0;%该区域有几根
    if 2*1852-1.8*x*n <= x
        m=n;
    else
        m=n+1;
    end
    l=(D0/16)/tan(alpha);%该区域长度
    len=l*m;
    lens=[lens,len];
    D0=D0*17/16;
    D=[D,D0];
end
disp(sum(lens))