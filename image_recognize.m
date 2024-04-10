clc,clear all,close all;
%% Neural Network TEST CODE via ÝMAGE CLASSÝFÝCATÝON
%  04-Jan-2019

%% Load Data
load NNLearnedForTest.mat


%% Loading Test Data From Webcam
cam = webcam(1);
image1 = snapshot(cam);
imshow(image1);


%% Ýmage Processing
image = im2bw(image1);             
image = imresize(image,[60,60]);  
image = double(image);            
image = reshape(image,1,3600);    
[FV] = feature_extractor_2d(image)';


%% NN OUTPUT
[yhatVA] = sign(MISOYSAmodel2(FV,Wg,bh,Wc,bc));


%% Estimation of Output


if yhatVA > 0
    ANS = ('1');
else
    ANS = ('0');
end

subplot(121)
imshow(image1)
title('Test Ýmage')

subplot(122)
hold on
text(0.3,0.5,ANS,'FontSize',100)
title('NN OUTPUT')

clear cam
