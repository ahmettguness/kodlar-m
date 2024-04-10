clear all
close all
clc


x = [2; 0; 0];
f = x(1)^2 - 2*x(1) + x(2)^2 - x(3)^2 + 4*x(3);
Z = [1 -2; 1 0; 0 1];

for i=1:10000
    GRADf = [2*x(1)-2; 2*x(2); -2*x(3)+4];
    p = -Z' * GRADf;
    alpha = 0.001;
    x = x + alpha*Z*p;
    f = x(1)^2 - 2*x(1) + x(2)^2 - x(3)^2 + 4*x(3);
    disp([x',f])
end
HESSIANf = [2 0 0;0 2 0; 0 0 -2];
eig(Z'*HESSIANf*Z)
