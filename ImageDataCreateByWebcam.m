clc, clear all, close all;
%% Create �nput Data
cam = webcam(1);
for i = 1251:1500
    img = snapshot(cam);
    name = ['Image' num2str(i)];
    imwrite(img,name,'jpg');
end