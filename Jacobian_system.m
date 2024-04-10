clc
clear all
close all
format long
eps=1e-6;
x1=1;x2=-1.7;
% eksik
denklemmax=2;
for j=1:denklemmax
for i=1:denklemmax
    [f1,f2]=func(x1,x2);
    d1(i)=f1;
    temp1=x1+eps;
    [f1,f2]=func(temp1,x2);
    d2(i)=f1;
    J(i,j)=(d2(i)-d1(i))/eps;
    x1=temp1-eps;
    
    
end
end
J


% % J(1,1)
% [f1,f2]=func(x1,x2);
% d1=f1;
% temp=x1+eps;
% [f1,f2]=func(temp,x2);
% d2=f1;
% J(1,1)=(d2-d1)/eps;
% x1=temp-eps;
% 
% % J(1,2)
% [f1,f2]=func(x1,x2);
% d1=f1;
% temp=x2+eps;
% [f1,f2]=func(x1,temp);
% d2=f1;
% J(1,2)=(d2-d1)/eps;
% x2=temp-eps;
% 
% % J(2,1)
% [f1,f2]=func(x1,x2);
% d1=f2;
% temp=x1+eps;
% [f1,f2]=func(temp,x2);
% d2=f2;
% J(2,1)=(d2-d1)/eps;
% x1=temp-eps;
% 
% % J(2,2)
% [f1,f2]=func(x1,x2);
% d1=f2;
% temp=x2+eps;
% [f1,f2]=func(x1,temp);
% d2=f2;
% J(2,2)=(d2-d1)/eps;
% x2=temp-eps;
% 
% J



