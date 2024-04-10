clear all
clc
close all


B = 4.0; % Problem Complexty 
N = 400; % Number of data
Tall=[];
for i=1:N/2
    theta=pi/2+(i-1)*[(2*B-1)/N]*pi;
    Tall= [Tall , [theta*cos(theta);theta*sin(theta)]];
end
Tall= [Tall,-Tall];
Tmax = pi/2+[(N/2-1)*(2*B-1)/N]*pi;
INPUT = [Tall]/Tmax; INPUT=INPUT';
OUTPUT =[-ones(1,N/2), ones(1,N/2)]; OUTPUT=OUTPUT';
T = INPUT;
Y = OUTPUT;

[N,R] = size(T); 
%    Data bölme
TrainingIndex   = 1:2:N;
ValidationIndex = 2:2:N;

TrainingINPUT    = T(TrainingIndex,:);  % Eðitim Datasý Giriþ
TrainingOUTPUT   = Y(TrainingIndex,:);  % Eðitim Datasý Çýkýþ

ValidationINPUT  = T(ValidationIndex,:);  % Test Datasý Giriþ
ValidationOUTPUT = Y(ValidationIndex,:);  % Test Datasý Çýkýþ

NumberofHiddenNeurons=50;                     % Gizli Katman Nöron Sayýsý
NumberofTrainingData=size(TrainingINPUT,1);    % Eðitim Data Sayýsý
NumberofTestingData=size(ValidationINPUT,1);   % Test Data Sayýsý
NumberofInputNeurons=size(TrainingINPUT,2);    % Giriþ Özellik Sayýsý
NumberofOutputNeurons=2;                       % Çýkýþýmýz +1 veya -1 olacýðý için 

% Train part
tic                 % Eðitim için iþlemci süresini baþlatýyoruz.

InputWeight=rand(NumberofHiddenNeurons,NumberofInputNeurons)*2-1;  % Giriþ aðýrlýklarý rastgele atanýyor
BiasofHiddenNeurons=rand(NumberofHiddenNeurons,1);                 % Giriþ Bias Deðerleri rastgele atanýyor 

tempH=InputWeight*TrainingINPUT';  % Geçici bir tempH fonksiyonu oluþturuyoruz.
ind=ones(1,NumberofTrainingData);        %   H matrisi Hesaplanýrken boyut uyumsuzluðu olmamasý için 
BiasMatrix=BiasofHiddenNeurons(:,ind);   %   Gizli katman matrisini geniþletiyoruz
tempH=tempH+BiasMatrix;
% Çeþitli aktivasyon fonksiyonlarý
H = 1 ./ (1 + exp(-tempH)); % sigmoid
% H = 1-2./(exp(2*tempH)+1);    % tanh
% H = sin(tempH);                 %sin
% H = double(hardlim(tempH)); % Hardlim
% H = radbas(tempH);              %radbas

% Beta= (H matrisinin genelleþtirilmiþ Moore-Penrose tersi)*Eðitim setinin çýkýþý
OutputWeight=pinv(H') * TrainingOUTPUT;     % Çýkýþ aðýrlýk matrisini hesaplýyoruz

Train_ans=(H' * OutputWeight)';  % Eðitim Datasýnýn Çýktýsý
elapsedTime1 = toc;              % Eðitim  için iþlemci süresini durduruyoruz 


b=sign(Train_ans); 
b=b';
% Eðitim Çýktýsý ile Gerçek Çýktýnýn karþýlaþtýrýlmasý
MissClassificationRate_Training=0;
for i=1:size(TrainingOUTPUT,1)
    if  TrainingOUTPUT(i,1)~=b(i,1)
    MissClassificationRate_Training=MissClassificationRate_Training+1;
    end
    
end
% Test Part
tic                                         % Test için iþlemci süresini baþlatýyoruz.

tempH_test=InputWeight*ValidationINPUT';    % Geçici bir tempH fonksiyonu oluþturuyoruz.
ind=ones(1,NumberofTestingData);            %   H matrisi Hesaplanýrken boyut uyumsuzluðu olmamasý için 
BiasMatrix=BiasofHiddenNeurons(:,ind);      %   Gizli katman matrisini geniþletiyoruz             

tempH_test=tempH_test + BiasMatrix;         

% Çeþitli aktivasyon fonksiyonlarý
H_test = 1 ./ (1 + exp(-tempH_test));     % sigmoid

% H_test = sin(tempH_test);                 % sin
% H_test = hardlim(tempH_test);             %  Hardlim
% H_test = 1-2./(exp(2*tempH_test)+1);        % tanh
% H_test = radbas(tempH_test);                %radbas

Test_ans=(H_test' * OutputWeight)';         %  Test Datasýnýn Çýktýsý

elapsedTime = toc;                       % Test  için iþlemci süresini durduruyoruz


a=sign(Test_ans);
a=a';
% Test Çýktýsý ile Gerçek Çýktýnýn Karþýlaþtýrýlmasý
MissClassificationRate_Testing=0;
for i=1:size(ValidationOUTPUT,1)
    if  ValidationOUTPUT(i,1)~=a(i,1)
    MissClassificationRate_Testing=MissClassificationRate_Testing+1;
    end
    
end


input = []; output = [];
for t1=-1:0.01:1
    for t2=-1:0.01:1
        input = [input; [t1,t2] ];
        tempH_test=InputWeight*[t1,t2]';
        ind=ones(1,1);

        BiasMatrix=BiasofHiddenNeurons(:,ind);              
        tempH_test=tempH_test + BiasMatrix;
        %   H_test = sin(tempH_test);            %sin  
        H_test = 1 ./ (1 + exp(-tempH_test));  % sigmoid
        % H_test = hardlim(tempH_test);         %  Hardlim
        % H_test = 1-2./(exp(2*tempH_test)+1);   % tanh
        % H_test = radbas(tempH_test);             %radbas
        Test_ans=(H_test' * OutputWeight)';
        a=sign(Test_ans);
        a=a';
       
        output = [output; a];
    end
end

Iplus=find(output==+1);
Iminus=find(output==-1);

plot(input(Iplus,1), input(Iplus,2), 'm.')
hold on
plot(input(Iminus,1), input(Iminus,2), 'y.')

%plot
Iplus=find(OUTPUT==+1);
Iminus=find(OUTPUT==-1);


plot(INPUT(Iplus,1),INPUT(Iplus,2),'bx')
hold on
plot(INPUT(Iminus,1),INPUT(Iminus,2),'ko')
title(['Gizli Katman Nöron Sayýsý: ', num2str(NumberofHiddenNeurons),  'Toplam Data Sayýsý: ', num2str(N), 'MissClassTrain:',num2str(MissClassificationRate_Training),'Train time: ', num2str(elapsedTime1), 'MissClassTest:',num2str(MissClassificationRate_Testing), 'Test time: ', num2str(elapsedTime)])
