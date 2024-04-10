clear all
close all
clc

database = ['G' 'E' 'Z'
    'G' 'H' 'Z'
    'R' 'E' 'Z'
    'Y' 'E' 'F'
    'Y' 'H' 'Z'
    'Y' 'E' 'F'
    'R' 'H' 'F'
    'R' 'H' 'Z'
    'R' 'E' 'Z'
    'G' 'H' 'Z'];

Features = ['HD' 'MD' 'PD'];

Karar = ['S'
    'T'
    'S'
    'S'
    'E'
    'S'
    'S'
    'A'
    'S'
    'T'];

TotalNumData = size(database,1);
Decisions = unique(Karar);
NumDecisions = size(Decisions,1);

for i=1:NumDecisions
    decision = Decisions(i);
    NumOcc = length(find(Karar == decision));
    Pdecisions(i,1) = NumOcc/TotalNumData;
end

E = 0;
for i=1:NumDecisions
    E = E - Pdecisions(i,1)*log2(Pdecisions(i,1));
end
E

for i:length(Features)
    FV = database(:,i);
    items = unique(FV);
    TOT = 0;
    for v=1:length(items)
        item = items(v);
        ItemKarar = Karar(find(FV==item));
        UniqueItemKarar = unique(ItemKarar);
        for j=1:length(UniqueItemKarar)
            temp = UniqueItemKarar(j);            
            p(j) = length(find(ItemKarar == temp))/length(ItemKarar);
        end
        TempE = 0;
        for j=1:length(UniqueItemKarar)
            TempE = TempE - p(j)*log2(p(j));
        end
        
        TOT = TOT + [length(find(FV==item))/length(FV)]*TempE;
    end
    Gain(i,1) = E - TOT;
end
[V,I] = max(Gain);
Features(I)





