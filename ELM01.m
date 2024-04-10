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
%    Data b�lme
TrainingIndex   = 1:2:N;
ValidationIndex = 2:2:N;

TrainingINPUT    = T(TrainingIndex,:);  % E�itim Datas� Giri�
TrainingOUTPUT   = Y(TrainingIndex,:);  % E�itim Datas� ��k��

ValidationINPUT  = T(ValidationIndex,:);  % Test Datas� Giri�
ValidationOUTPUT = Y(ValidationIndex,:);  % Test Datas� ��k��

NumberofHiddenNeurons=50;                     % Gizli Katman N�ron Say�s�
NumberofTrainingData=size(TrainingINPUT,1);    % E�itim Data Say�s�
NumberofTestingData=size(ValidationINPUT,1);   % Test Data Say�s�
NumberofInputNeurons=size(TrainingINPUT,2);    % Giri� �zellik Say�s�
NumberofOutputNeurons=2;                       % ��k���m�z +1 veya -1 olac��� i�in 

% Train part
tic                 % E�itim i�in i�lemci s�resini ba�lat�yoruz.

InputWeight=rand(NumberofHiddenNeurons,NumberofInputNeurons)*2-1;  % Giri� a��rl�klar� rastgele atan�yor
BiasofHiddenNeurons=rand(NumberofHiddenNeurons,1);                 % Giri� Bias De�erleri rastgele atan�yor 

tempH=InputWeight*TrainingINPUT';  % Ge�ici bir tempH fonksiyonu olu�turuyoruz.
ind=ones(1,NumberofTrainingData);        %   H matrisi Hesaplan�rken boyut uyumsuzlu�u olmamas� i�in 
BiasMatrix=BiasofHiddenNeurons(:,ind);   %   Gizli katman matrisini geni�letiyoruz
tempH=tempH+BiasMatrix;
% �e�itli aktivasyon fonksiyonlar�
H = 1 ./ (1 + exp(-tempH)); % sigmoid
% H = 1-2./(exp(2*tempH)+1);    % tanh
% H = sin(tempH);                 %sin
% H = double(hardlim(tempH)); % Hardlim
% H = radbas(tempH);              %radbas

% Beta= (H matrisinin genelle�tirilmi� Moore-Penrose tersi)*E�itim setinin ��k���
OutputWeight=pinv(H') * TrainingOUTPUT;     % ��k�� a��rl�k matrisini hesapl�yoruz

Train_ans=(H' * OutputWeight)';  % E�itim Datas�n�n ��kt�s�
elapsedTime1 = toc;              % E�itim  i�in i�lemci s�resini durduruyoruz 


b=sign(Train_ans); 
b=b';
% E�itim ��kt�s� ile Ger�ek ��kt�n�n kar��la�t�r�lmas�
MissClassificationRate_Training=0;
for i=1:size(TrainingOUTPUT,1)
    if  TrainingOUTPUT(i,1)~=b(i,1)
    MissClassificationRate_Training=MissClassificationRate_Training+1;
    end
    
end
% Test Part
tic                                         % Test i�in i�lemci s�resini ba�lat�yoruz.

tempH_test=InputWeight*ValidationINPUT';    % Ge�ici bir tempH fonksiyonu olu�turuyoruz.
ind=ones(1,NumberofTestingData);            %   H matrisi Hesaplan�rken boyut uyumsuzlu�u olmamas� i�in 
BiasMatrix=BiasofHiddenNeurons(:,ind);      %   Gizli katman matrisini geni�letiyoruz             

tempH_test=tempH_test + BiasMatrix;         

% �e�itli aktivasyon fonksiyonlar�
H_test = 1 ./ (1 + exp(-tempH_test));     % sigmoid

% H_test = sin(tempH_test);                 % sin
% H_test = hardlim(tempH_test);             %  Hardlim
% H_test = 1-2./(exp(2*tempH_test)+1);        % tanh
% H_test = radbas(tempH_test);                %radbas

Test_ans=(H_test' * OutputWeight)';         %  Test Datas�n�n ��kt�s�

elapsedTime = toc;                       % Test  i�in i�lemci s�resini durduruyoruz


a=sign(Test_ans);
a=a';
% Test ��kt�s� ile Ger�ek ��kt�n�n Kar��la�t�r�lmas�
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
title(['Gizli Katman N�ron Say�s�: ', num2str(NumberofHiddenNeurons),  'Toplam Data Say�s�: ', num2str(N), 'MissClassTrain:',num2str(MissClassificationRate_Training),'Train time: ', num2str(elapsedTime1), 'MissClassTest:',num2str(MissClassificationRate_Testing), 'Test time: ', num2str(elapsedTime)])
