clear all,close all,clc;
%% Create Data
T = [];
Y = [];
%% For 1
for m=1:500
    imageone = imread(['Image',num2str(m)]);
    imageone = im2bw(imageone);
    imageone = imresize(imageone,[60,60]);
    imageone = double(imageone);
    imageone = reshape(imageone,1,3600);
    [FV] = feature_extractor_2d(imageone)';
    T = [T;FV];
    Y = [Y;+1];
end
% subplot(121)
% imshow(imageone)
%% For 0
for n=1000:1500
    imagezero = imread(['Image',num2str(n)]);
    imagezero = im2bw(imagezero);
    imagezero = imresize(imagezero,[60,60]);
    imagezero = double(imagezero);
    imagezero = reshape(imagezero,1,3600);
    [FV] = feature_extractor_2d(imagezero)';
    T = [T;FV];
    Y = [Y;-1];
end
% subplot(122)
% imshow(imagezero)

%% NORMALÝZATÝON
minT = max(T);
maxT = min(T);
Tn = [T-(ones(size(T,1),1)*minT)]./[(ones(size(T,1),1)*maxT)-(ones(size(T,1),1)*minT)];

%% Save Data
save NNLearnedData.mat T Y Tn minT maxT

