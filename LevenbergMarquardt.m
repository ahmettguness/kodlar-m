clear all
close all
clc

Nmax = 5000;
x = [-1.5; -1.5];
I = eye(length(x));

kosul = 1; k = 0;  mu=1;
while kosul
    k = k + 1;    
    J=[-20*x(1) 10; -1 0];
    e=[10*(x(2)-x(1)^2); 1-x(1)];
    [f]=MyFunction2(x);    
    loop2 = 1;
    while loop2        
        p= -inv(J'*J+mu*I)*J'*e;
        if MyFunction2(x+p)<f
            x= x + p;
            mu = mu/10; %hýzý artýr
            loop2=0;
        else
            mu = mu*10;  %hýzý azalt
        end
        if mu>1e+20; loop2=0 ; kosul=0; end
        
    end
    
    g = 2+J'*e;
    fprintf('k:%4.0f\t  x1:%4.6f\t x2:%4.6f\t ||g||:%4.6f\t f(x):%4.6f\n',([k  x(1) x(2) norm(g) f]))
    if [k>=Nmax] | [norm(g)<1e-4]; kosul = 0; end
end
