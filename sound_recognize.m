clear all
close all
clc

load SVMBEST1.mat LAMBDAS1best SV1best SG1best T1 Y1 MinT MaxT
load SVMBEST2.mat LAMBDAS2best SV2best SG2best T2 Y2 MinT MaxT
load SVMBEST3.mat LAMBDAS3best SV3best SG3best T3 Y3 MinT MaxT
load SVMBEST4.mat LAMBDAS4best SV4best SG4best T4 Y4 MinT MaxT
load SVMBEST5.mat LAMBDAS5best SV5best SG5best T5 Y5 MinT MaxT

s1 = SG1best;
s2 = SG2best;
s3 = SG3best;
s4 = SG4best;
s5 = SG5best;
rec0bj = audiorecorder;
disp('Start Speaking...')
recordblocking(rec0bj,3);
disp('End of Speaking...')
x = getaudiodata(rec0bj);
plot(x)
[FV] = GetFeatureVector(x)';
xtest = [(FV'-MinT)./(MaxT-MinT)]';
SVM1 = 0;
SVM2 = 0;
SVM3 = 0;
SVM4 = 0;
SVM5 = 0;
SVM1 = ModelKernelSMC(xtest,LAMBDAS1best,T1,Y1,SG1best)
SVM2 = ModelKernelSMC(xtest,LAMBDAS2best,T2,Y2,SG2best)
SVM3 = ModelKernelSMC(xtest,LAMBDAS3best,T3,Y3,SG3best)
SVM4 = ModelKernelSMC(xtest,LAMBDAS4best,T4,Y4,SG4best)
SVM5 = ModelKernelSMC(xtest,LAMBDAS5best,T5,Y5,SG5best)

if SVM1<0 && SVM2<0 && SVM3<0 && SVM4<0 && SVM5<0
    ANS = ('BORU');
elseif SVM1<0 && SVM2<0 && SVM3<0 && SVM4<0 && SVM5>0
    ANS = ('IZMIR');
elseif SVM1<0 && SVM2<0 && SVM3<0 && SVM4>0 && SVM5<0
    ANS = ('KARSIYAKA');
elseif SVM1<0 && SVM2<0 && SVM3<0 && SVM4>0 && SVM5>0
    ANS = ('ADAM');
elseif SVM1<0 && SVM2<0 && SVM3>0 && SVM4<0 && SVM5<0
    ANS = ('YAZ');
elseif SVM1<0 && SVM2<0 && SVM3>0 && SVM4<0 && SVM5>0
    ANS = ('MANYETIK');
elseif SVM1<0 && SVM2<0 && SVM3>0 && SVM4>0 && SVM5<0
    ANS = ('KANUN');
elseif SVM1<0 && SVM2<0 && SVM3>0 && SVM4>0 && SVM5>0
    ANS = ('SABAH');
elseif SVM1<0 && SVM2>0 && SVM3<0 && SVM4<0 && SVM5<0
    ANS = ('SONBAHAR');
elseif SVM1<0 && SVM2>0 && SVM3<0 && SVM4<0 && SVM5>0
    ANS = ('LALE');
elseif SVM1<0 && SVM2>0 && SVM3<0 && SVM4>0 && SVM5<0
    ANS = ('KAL');
elseif SVM1<0 && SVM2>0 && SVM3<0 && SVM4>0 && SVM5>0
    ANS = ('BALIK');
elseif SVM1<0 && SVM2>0 && SVM3>0 && SVM4<0 && SVM5<0
    ANS = ('PANCAR');
elseif SVM1<0 && SVM2>0 && SVM3>0 && SVM4<0 && SVM5>0
    ANS = ('RAKUN');
elseif SVM1<0 && SVM2>0 && SVM3>0 && SVM4>0 && SVM5<0
    ANS = ('HUY');
elseif SVM1<0 && SVM2>0 && SVM3>0 && SVM4>0 && SVM5>0
    ANS = ('DALYAN');
elseif SVM1>0 && SVM2<0 && SVM3<0 && SVM4<0 && SVM5<0
    ANS = ('ZAMAN');
elseif SVM1>0 && SVM2<0 && SVM3<0 && SVM4<0 && SVM5>0
    ANS = ('NANE');
elseif SVM1>0 && SVM2<0 && SVM3<0 && SVM4>0 && SVM5<0
    ANS = ('BARDAK');
elseif SVM1>0 && SVM2<0 && SVM3<0 && SVM4>0 && SVM5>0
    ANS = ('YILDIZ');
else
    ANS = ('KELÝME ANLAÞILAMADI YA DA BÝLÝNMÝYOR!');
end

h = text(length(x), max(x),ANS);
set(h,'FontSize',32);
set(h,'FontWeight','Bold');
set(h,'Color',[1 0 0]);
set(h,'EdgeColor', [0 0 1]);
set(h,'Linewidth',3);
set(h,'HorizontalAlignment', 'Right');
set(h,'VerticalAlignment', 'Middle');
set(gcf,'color',[1 1 1])
set(gcf,'Position', [275 195 721 497])