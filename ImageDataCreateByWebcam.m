clc, clear all, close all;
%% Create Ýnput Data
cam = webcam(1);
for i = 1251:1500
    img = snapshot(cam);
    name = ['Image' num2str(i)];
    imwrite(img,name,'jpg');
end