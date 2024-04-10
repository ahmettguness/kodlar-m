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