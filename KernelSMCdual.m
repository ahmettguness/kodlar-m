clear all
close all
clc

B = 3.2;
N = 100;
Tall = [];
for i=1:N/2
    theta = pi/2 + (i-1)*[(2*B-1)/N]*pi;
    Tall = [Tall , [theta*cos(theta);theta*sin(theta)]];
end
Tall = [Tall,-Tall];
Tmax = pi/2+[(N/2-1)*(2*B-1)/N]*pi;
T = [Tall]'/Tmax;
Y = [-ones(1,N/2), ones(1,N/2)]';
clear theta Tall Tmax

C = 10; sgm = 0.2;
[N,n] = size(T);
for i=1:N
    for j=1:N
        H(i,j) = Y(i)*Y(j)*GaussKernel(T(i,:)',T(j,:)',sgm);
    end
end
g = -ones(1,N);
Aeq = Y';
beq = 0;
opts = optimset('Algorithm','interior-point-convex','Display','off');
lb = zeros(N,1);
ub = ones(N,1)*C;
[lambda] = quadprog(H,g,[],[],Aeq,beq,lb,ub,[],opts);

svi = find(lambda>1e-6);


input = []; output = [];
for t1=-1:0.01:1
    for t2=-1:0.01:1
        input = [input; [t1,t2] ];
        [yhat]= DualKernelModel([t1;t2],lambda,svi,T,Y,sgm);
        output = [output; sign(yhat)];
    end
end

Iplus = find(output==+1);
Iminus = find(output==-1);
plot(input(Iplus,1),input(Iplus,2),'g.')
hold on
plot(input(Iminus,1),input(Iminus,2),'y.')



Iplus = find(Y==+1);
Iminus = find(Y==-1);
plot(T(Iplus,1), T(Iplus,2), 'ro')
plot(T(Iminus,1), T(Iminus,2), 'b*')


NumOfSVs = length(svi); NumOfMisClass = 0;
for i=1:size(T,1)
    input = T(i,:)';
    [yhat] = DualKernelModel(input,lambda,svi,T,Y,sgm);
    if yhat == Y(i);
    else
        NumOfMisClass = NumOfMisClass + 1;
    end
end
        
title(['\sigma:', num2str(sgm), '  N:', num2str(N), '  #SVs:', num2str(NumOfSVs), '  #MissCla.:', num2str(NumOfMisClass)])
