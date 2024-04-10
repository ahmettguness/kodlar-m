clear all
%close all
clc

B = 1.8;
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

noise = randn(size(T,1),size(T,2))*0.1;
T = T + noise;
figure
K = 5;
input = []; output = [];
for i=1:size(T,1)
    D = [];
    for j=1:size(T,1)
        D = [D; sum([T(j,:)-T(i,:)].^2)];
    end
    [V,I] = sort(D);
    output = [output; sign(sum(Y(I(1:K)))) ];
end
NumOfMisclass = length(find(output~=Y));

input = []; output = [];
for c1 = floor(min(T(:,1)))-1: 0.02: ceil(max(T(:,1)))+1
    for c2 = floor(min(T(:,2)))-1: 0.02: ceil(max(T(:,2)))+1
        input = [input; [c1,c2] ];
        D = [];
        for i=1:size(T,1)
            D = [D; sum((T(i,:)-[c1,c2]).^2)];
        end
        [V,I] = sort(D);
        output = [output; sign(sum(Y(I(1:K)))) ];
    end
end
Iplus = find(output==1);
Iminus = find(output==-1);
plot(input(Iplus,1),input(Iplus,2),'g.')
hold on
plot(input(Iminus,1),input(Iminus,2),'y.')
Iplus = find(Y==1);
Iminus = find(Y==-1);
plot(T(Iplus,1),T(Iplus,2),'bs')
hold on
plot(T(Iminus,1),T(Iminus,2),'ro')
axis([-1 1 -1 +1])
xlabel('x_{1}'); ylabel('x_{2}')
title(['K.: ', num2str(K) '      NumOfMisclass.: ', num2str(NumOfMisclass)])
set(gcf,'Color',[1 1 1])