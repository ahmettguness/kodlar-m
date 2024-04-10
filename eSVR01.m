clear all
close all
clc

load regression.mat 

% load SunSpot.mat;
% R = 10;
% T = []; Y = [];
% for k=1:length(Z)-R
%     T = [T; Z(k:k+R-1)'];
%     Y = [Y; Z(k+R)];
% end
T = T(1:500,:);
Y = Y(1:500,:);

minT = max(T);
maxT = min(T);
T = [T-(ones(size(T,1),1)*minT)]./[(ones(size(T,1),1)*maxT)-(ones(size(T,1),1)*minT)];


N = size(T,1);
C = 100;
EPS = 0.01;
SGM = 1.0;

Aeq = [ones(1,N) -ones(1,N)];
Beq = 0;
lb = zeros(2*N,1);
ub = C*ones(2*N,1);
g = [EPS-Y', EPS+Y'];
for i=1:N
    for j=1:N
        M(i,j) = GaussKernel(T(i,:)',T(j,:)',SGM);
    end
end
H = [M,-M;-M,M]; clear M;
[x] = quadprog(H,g,[],[],Aeq,Beq,lb,ub);
beta = x(1:N);
betastar = x(N+1:2*N);
alpha = beta-betastar;

svi = find(abs(alpha)>1e-6);
NumOfSVs = length(svi);

svib = find( 1e-6<abs(alpha) & abs(alpha)<C-(1e-6));


for k=1:length(svib)
    i = svib(k);
    TOT = 0;
    for m=1:length(svi)
        j = svi(m);
        TOT = TOT + alpha(j)*GaussKernel(T(i,:)',T(j,:)',SGM);
    end
    if alpha(svib(k))>0
        B(k) = Y(i) - TOT - EPS;
    else
        B(k) = Y(i) - TOT + EPS;
    end
end
b = mean(B);    
    
input = T;
yhat = DualSVMmodel(input,alpha(svi),T(svi,:),b,SGM);
e = Y - yhat;


subplot(211)
plot(Y,'b'); hold on
plot(yhat,'r')


subplot(212)
he=plot(e,'.');set(he,'MarkerSize',10)
h=line([0,length(Y)],[+EPS +EPS]); set(h,'Color',[1 0 0])
h=line([0,length(Y)],[-EPS -EPS]); set(h,'Color',[1 0 0])
axis([0,length(Y),-0.02,+0.02])
set(gcf,'Color',[1 1 1])
title(['#ofTrData:',num2str(N), ' C:', num2str(C), '  sigma',':', num2str(SGM), '  eps',':', num2str(EPS), ' #ofSVs:', num2str(length(svi))])

















