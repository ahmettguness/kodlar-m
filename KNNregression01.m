clear all
close all
clc

load regression.mat
T = T(1:500,:);
Y = Y(1:500,:);

noiseT = randn(size(T,1),size(T,2))*0.01;
Tn = T + noiseT;
noiseY = randn(size(Y,1),size(Y,2))*0.01;
Yn = Y + noiseY;


figure
K = 3;
input = []; output = [];
for i=1:size(Tn,1)
    D = [];
    for j=1:size(Tn,1)
        D = [D; sum([Tn(j,:)-Tn(i,:)].^2)];
    end
    [V,I] = sort(D);
    output = [output; mean(Yn(I(1:K))) ];
end

plot(Y); hold on; plot(output,'r')
Error = (Y - output);
F = Error'*Error;

title(['K: ', num2str(K) '      F: ', num2str(F)])
set(gcf,'Color',[1 1 1])