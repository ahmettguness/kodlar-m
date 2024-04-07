clc
clear all
close all
format long
a=1;
b=2;
eps=0.001;
k=1;

hh=1e100;
hata(1)=hh;
while hh>eps
x(k)=(a+b)/2;
fa(k)=func(a);
fb(k)=func(b);
ftahmin(k)=func(x(k));

if fa(k)*ftahmin(k)<0
    b=x(k);
end

if ftahmin(k)*fb(k)<0
    a=x(k);
end

if k>1
hata(k)=abs((x(k)-x(k-1))/x(k));
end
hh=hata(k);
k=k+1;
end
x'
k=k-1

