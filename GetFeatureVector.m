function [FV]=GetFeatureVector(x)
FV = [];

MIN = min(x);
FV = [FV,MIN];

MAX = max(x);
FV = [FV,MAX];

MEAN = mean(x);
FV = [FV,MEAN];

STD = std(x);
FV = [FV,STD];

ENERGY = sum(abs(x).^2);
FV = [FV,ENERGY];

ENTROPY = wentropy(x,'shannon');
FV = [FV,ENTROPY];

% Fs = 8000;
% Ts = 1/Fs;
% N = length(x);
% [X] = fft(x);
% Magnitude = 2*abs(X)/N;
% Magnitude(1)= Magnitude(1)/2;
% Magnitude = Magnitude(N/2:end);
% Magnitude = [Magnitude-min(Magnitude)]/[max(Magnitude)-min(Magnitude)];
% [yupper,ylower] = envelope(Magnitude,30,'peak');
% [pks,locs] = findpeaks(yupper);
% [V,I] = sort(pks,'Descend');
% F = [0:N/2]*Fs/N;
% IMSF = F(locs(I(1:5)))';
% FV = [FV, IMSF'];
