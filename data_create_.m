clc,clear all,close all;
%% Data Create Emnist data set 1-2
load mnist_all.mat
one = [];
T = [];
Y = [];
for i=1:1000
    one = [one; V2M(test1(i,:),28,28)];
    temp = reshape(V2M(test1(i,:),28,28),1,784);
    [FV] = feature_extractor_2d(temp)';
    T = [T;FV];
    Y = [Y;+1];
end
% subplot(121)
% imshow(one)


two = [];
for i=1:1000
    two = [two; V2M(test2(i,:),28,28)];
    temp = reshape(V2M(test2(i,:),28,28),1,784);
    [FV] = feature_extractor_2d(temp)';
    T = [T;FV];
    Y = [Y;-1];
end
% subplot(122)
% imshow(two)
%% NORMALÝZATÝON
minT = max(T);
maxT = min(T);
Tn = [T-(ones(size(T,1),1)*minT)]./[(ones(size(T,1),1)*maxT)-(ones(size(T,1),1)*minT)];

%% Save Data
save NNTrainingData.mat T Y Tn minT maxT