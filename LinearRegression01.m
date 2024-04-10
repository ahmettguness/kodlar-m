clear all
close all
clc

a = 2.77;
b = -3.64;
c = 2.04;
d = 7.22;

T = rand(100,3);
Y = [];
for i = 1:size(T,1)
    Y = [Y; T(i,:)*[a;b;c] + d + randn*0.1];
end

% load regression.mat
% T = T(1:500,:);
% Y = Y(1:500,:);


% %Least Squares ile bulunuyor
% A = [T,ones(size(T,1),1)];
% b = Y;
% theta = inv(A'*A)*A'*b
% yhat = [T,ones(size(T,1),1)]*theta;
% error = Y - yhat;
% plot(Y,'b'); hold on
% plot(yhat,'r')
% F = error'*error;

% Iteratif yontemle bulunuyor

x = rand(4,1)-0.5;
yhat = [T,ones(size(T,1),1)]*x;
error = Y - yhat;
%plot(Y,'b'); hold on
hyhat = plot(yhat,'r');
F = error'*error;

loop = 1; iteration = 0; mu = 1;
while loop
    iteration = iteration + 1;
    yhat = [T,ones(size(T,1),1)]*x;
    delete(hyhat)
    %hyhat = plot(yhat,'r'); pause(.5)
    error = Y - yhat;
    F = error'*error;
    %disp([iteration, F])
    J = -[T,ones(size(T,1),1)];
    
    loop2 = 1; I = eye(4);
    while loop2
        p = -inv(J'*J+mu*I)*J'*error;
        z = x + p;
        yz = [T,ones(size(T,1),1)]*z;
        ez = Y - yz;
        Fz = ez'*ez;
        if Fz<F
            x = z; F = Fz;
            mu = mu/10;
            loop2 = 0;
        else
            mu = mu*10;
            if mu>=1e+20; loop = 0; loop2 = 0; end
        end
    end
    if iteration>=100; loop = 0; end
end

%...............
n = 0:1000;
Yref = 3*sin(.015*n+0.4);
t = 4*(rand(3,1)-0.5);

for n=1:1000
    yREFERENCE = Yref(n);
    
    loop = 1; iteration = 0; mu = 1;
    while loop
        iteration = iteration + 1;
        ySYSTEM = [t;1]'*[a;b;c;d];
        e = yREFERENCE - ySYSTEM;
        F = e'*e;
        J = -[x(1) x(2) x(3)];
        loop2 = 1; I = eye(3);
        while loop2
            p = -inv(J'*J+mu*I)*J'*e;
            z = t + p;
            yz = [z;1]'*[a;b;c;d];
            ez = yREFERENCE - yz;
            Fz = ez'*ez;
            if Fz<F
                t = z; F = Fz;
                mu = mu/10;
                loop2 = 0;
            else
                mu = mu*10;
                if mu>=1e+20; loop = 0; loop2 = 0; end
            end
        end
    end
    Ysys(n) = [t;1]'*[a;b;c;d];
    disp([n,yREFERENCE, Ysys(n)])
end

plot(Yref); hold on
plot(Ysys,'r')







