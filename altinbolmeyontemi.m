clear all
close all
clc

xalt=1;
xust=5;

Dx = 1e-10;
tau = 0.38197;
eps= Dx/(xust-xalt);
N=ceil(-2.078*log(eps)); %ceil sayýyý yukarýya yuvarlar

x1= xalt + tau*(xust-xalt);
f1= x1*exp(-x1)+cos(x1);
x2= xust-tau*(xust-xalt);
f2= x2*exp(-x2)+cos(x2);

for k=1:N  %k=1 den N ye kadar
    
    if f1>f2
        xalt= x1;  x1=x2;  f1=f2;
        x2=  xust-tau*(xust-xalt);
        f2= x2*exp(-x2)+cos(x2);
    else
        xust=x2;  x2=x1;  f2=f1;
        x1= xalt + tau*(xust-xalt);
        f1= x1*exp(-x1)+cos(x1);
    end       
    disp([ k xalt  xust])    
        
    end
    
