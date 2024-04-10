clear all
close all
clc

xa = 1;
xb = 5;

kosul=1
while kosul
    dfa =exp(-xa)-xa*exp(-xa)-sin(xa);
    dfb =exp(-xb)-xb*exp(-xb)-sin(xb);
    
    xk = xa+ (xb-xa)/2;
    dfk =exp(-xk)-xk*exp(-xk)-sin(xk);
    if dfk*dfa>0
        xa=xk;
    else
        xb=xk;
    end
    disp([xb,xa,dfk])
    if [abs(dfk)<1e-6] | [abs(xa-xb)<1e-4]; kosul=0
    end
end
