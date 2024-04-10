clear all
close all
clc

Nmax=5000;
x= [-4.5 ; -3.5];
[f] = MyFunction2(x);
kosul = 1; k=0; p=0;
while kosul
    k=k+1;
    g= [2*(x(1)-1.5*x(2))
        -3*(x(1)-1.5*x(2)) + 2*(x(2)-2)];
    if k==1
        p = -g;
    else
        beta = (g'*g)/(gp'*gp) ;
        p = -g + beta*p;
    end
    s= GSforSD2(x,p);
    x = x+ s*p;
    gp = g;
    [f] = MyFunction2(x);
    fprintf('k:%4.0f\t s:%4.6f\t x1:%4.6f\t x2:%4.6f\t ||g||: %4.6f\t f(x): %4.6f\n',([k s x(1) x(2) norm(g) f]))
    % disp([k s x(1) x(2) norm(g) f])
    if[k>Nmax] | norm(g)<1e-4; kosul=0;  end
end