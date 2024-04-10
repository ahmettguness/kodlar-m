clear all
close all
clc

%% DATAS FOR K-MEANS

T = [1	    0.08
    0.04	0.93
    0.84	0.01
    0.21	0.89
    0.10	0.95
    0.89	0.10
    0.17    0.85
    0.81	0.04
    0.99 	0.07
    0.96    0.07
    0.77	0.05
    0.99	0.12
    0.16	1.00
    0.78	0.00
    0.00	0.90
    0.00    0.85];
%% NORMALIZATION
% T = [T-ones(size(T,1),1)*min(T)]./[ones(size(T,1),1)*max(T)-ones(size(T,1),1)*min(T)];


%% K-MEANS ALGORITHM
VeriSayisi = size(T,1);
DegiskenSayisi = size(T,2);

TYPE = 'euclidean';
% euclidean
% mahalanobis
% seuclidean
% cityblock
% minkowski
% chebychev
% cosine
% correlation
% spearman
% hamming
% jaccard


h1=plot(T(:,1),T(:,2),'b*');
hold on

K = 10;    %kümeleme sayýmýz
% IndeksVektoru(1) = ceil(rand*VeriSayisi);
% for i=1:K-1
%     loop = 1;
%     while loop
%         AdayIndeks = ceil(rand*VeriSayisi);
%         temp = find(AdayIndeks==IndeksVektoru);
%         if isempty(temp)
%             IndeksVektoru = [IndeksVektoru; AdayIndeks];
%             loop = 0;
%          end
%     end
% end
% CENTER = T(IndeksVektoru,:);
CENTER = [];
for i=1:DegiskenSayisi
    temp = min(T(:,i)) + rand(K,1)*[max(T(:,i)) - min(T(:,i))];
    CENTER = [CENTER, temp];
end

h2=plot(CENTER(:,1),CENTER(:,2),'ro');
pause(4)

loop = 1; counter = 0;
while loop
    counter = counter + 1
    ClusterIndex = [];
    for i=1:size(T,1)
        D = pdist2(CENTER,T(i,:),TYPE);
        [V,I] = min(D);
        ClusterIndex(i,1) = I;
    end
    PreviousCENTER = CENTER;
    CENTER = [];
    for i=1:K
        I = find(ClusterIndex==i);
        c = mean(T(I,:),1);
        CENTER = [CENTER; c];
        h1=plot(T(I,1),T(I,2),'*'); set(h1,'Color',[rand rand rand]);
    end
    temp1 = []; temp2 = [];
    for i=1:size(CENTER,1)
        if max(isnan(CENTER(i,:)))
        else
            temp1 = [temp1; CENTER(i,:)];
            temp2 = [temp2; PreviousCENTER(i,:)];
        end
    end
    CENTER = temp1; PreviousCENTER = temp2;
    delete(h2)
    hold on
    h2=plot(CENTER(:,1),CENTER(:,2),'ro');
    pause(.1)
    
    if [norm(PreviousCENTER-CENTER)<1e-6] | [counter>100] ; loop = 0; end
end

unique(ClusterIndex)


%% SILHOUETTE
[silh] = silhouette(T,ClusterIndex);
% ai is the average distance from the ith point to the
% other points in the same cluster as i, and bi is the
% minimum average distance from the ith point to points
% in a different cluster

UCI = unique(ClusterIndex);

for i=1:size(T,1)
    point = T(i,:);
    ClusterIndexOfPoint = ClusterIndex(i);
    DataIndexOfThePointsInTheSameCluster = find(ClusterIndex==ClusterIndexOfPoint);
    ai = sum(pdist2(point,T(DataIndexOfThePointsInTheSameCluster,:),TYPE))/[length(DataIndexOfThePointsInTheSameCluster)-1];
    bi = [];

    for k=1:length(UCI)
        j = UCI(k);
        if j~=ClusterIndexOfPoint
           DataIndexOfThePointsInTheOtherCluster = find(ClusterIndex==j);
           bi = [bi, mean(pdist2(point,T(DataIndexOfThePointsInTheOtherCluster,:),TYPE))];
        end
    end
    bi = min(bi);
    S(i,1) = (bi-ai)/max([ai,bi]);
end
mean(S)
