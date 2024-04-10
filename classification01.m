clear all
close all
clc

B = 1.5;
N = 50;
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

Iplus = find(Y==1);
Iminus = find(Y==-1);

plot(T(Iplus,1),T(Iplus,2),'bs')
hold on
plot(T(Iminus,1),T(Iminus,2),'ko')
axis([-1 1 -1 +1])

N = size(T,1);


TraInput = T;
TraOutput = Y;
Ntra = size(TraInput,1);

n = 9;
x = rand(n,1)-0.5
I = eye(n);

iteration = 0; loop = 1; mu = 1;
while loop
    iteration = iteration + 1;
    for i = 1:Ntra
        yhat(i,1) = TwoNodeNN(x,TraInput(i,:)');
        ex(i,1) = TraOutput(i) - yhat(i,1);
    end
    Fx = ex'*ex;
    
    for i = 1:Ntra
        J(i,1) = -x(7)*TraInput(i,1)*[1-tanh(x(1)*TraInput(i,1) + x(2)*TraInput(i,2) + x(3))^2];
        J(i,2) = -x(7)*TraInput(i,2)*[1-tanh(x(1)*TraInput(i,1) + x(2)*TraInput(i,2) + x(3))^2];
        J(i,3) = -x(7)*[1-tanh(x(1)*TraInput(i,1) + x(2)*TraInput(i,2) + x(3))^2];
        J(i,4) = -x(8)*TraInput(i,1)*[1-tanh(x(4)*TraInput(i,1) + x(5)*TraInput(i,2) + x(6))^2];
        J(i,5) = -x(8)*TraInput(i,2)*[1-tanh(x(4)*TraInput(i,1) + x(5)*TraInput(i,2) + x(6))^2];        
        J(i,6) = -x(8)*[1-tanh(x(4)*TraInput(i,1) + x(5)*TraInput(i,2) + x(6))^2];
        J(i,7) = -tanh(x(1)*TraInput(i,1) + x(2)*TraInput(i,2) + x(3));
        J(i,8) = -tanh(x(4)*TraInput(i,1) + x(5)*TraInput(i,2) + x(6));
        J(i,9) = -1;
    end
    
    loop2 = 1;
    while loop2
        p = -inv(J'*J+mu*I)*J'*ex;
        z = x + p;
        for i = 1:Ntra
            yhat(i,1) = TwoNodeNN(z,TraInput(i,:)');
            ez(i,1) = TraOutput(i) - yhat(i,1);
        end
        Fz = ez'*ez;
        
        if Fz<Fx
            x = z; Fx = Fz ; ex = ez;
            loop2 = 0;
            mu = mu/10;
        else
            mu = mu*10;
        end
        if mu>1e+20; loop2 = 0; loop = 0; end
    end
    Ftra(iteration) = Fx;
    
    disp([iteration, Ftra(iteration)])
    if iteration>100 | norm(J'*ex)<1e-6; loop = 0; end
end

input = []; output = [];
for c1 = floor(min(T(:,1)))-1: 0.02: ceil(max(T(:,1)))+1
    for c2 = floor(min(T(:,2)))-1: 0.02: ceil(max(T(:,2)))+1
    input = [input; [c1,c2] ];
    output = [output; sign(TwoNodeNN(x,[c1,c2]')) ];
    end
end

Iplus = find(output==1);
Iminus = find(output==-1);

plot(input(Iplus,1),input(Iplus,2),'g.')
plot(input(Iminus,1),input(Iminus,2),'y.')


