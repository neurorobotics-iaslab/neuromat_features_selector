function [dp, tf] = neuromat_cva(data, labels)
    arguments
        data    (:, :) double
        labels  (:, 1) double
    end

classes   = unique(labels);
nclasses  = length(classes);
nfeatures = size(data, 2);

if isequal(size(data, 1), length(labels)) == false 
    error('[neuromat_cva] Data and label vector must have the same length')
end

if sum(isnan(labels)) > 0
    error('[neuromat_cva] Label vector must not contain NaN values')
end

if(nclasses ~= 2)
    error('[neuromat_cva] Label vector must contain only 2 classes')
end


% Within covariance matrix
withincov = zeros(nfeatures, nfeatures, nclasses);
for cId = 1:nclasses
    index = labels == classes(cId);
    withincov(:, :, cId)= (sum(index) - 1) * (cov(data(index, :)));
end

withincovtot  = sum(withincov,3);
withinmeantot = mean(data, 1);

% Between covariance matrix
betweencov = zeros(nfeatures, nfeatures, nclasses);
for cId = 1:nclasses
    index = labels == classes(cId);
    ccentroids = mean(data(index, :)) - withinmeantot;
    betweencov(:,:,cId) = sum(index) * (ccentroids' * ccentroids);
end
[leftsv, sv] = svd(pinv(withincovtot) * sum(betweencov,3));
sv = diag(sv);

tf = data*leftsv(:, 1:nclasses-1);

% Within groups correlation matrix (Correlation beween components and originalfeatures)
withincorr = zeros(nclasses - 1 + nfeatures, nclasses - 1 + nfeatures, nclasses);
for cId=1:nclasses
    index = labels == classes(cId);
    cgroup = [tf(index, :), data(index, :)];    
    withincorr(:, :, cId) = (size(cgroup, 1) - 1) * cov(cgroup);
end

groupcorr = sum(withincorr,3);
withingroupcorr = groupcorr(nclasses:end, 1:nclasses - 1);

for i = 1:size(withingroupcorr, 1)
    for u = 1:size(withingroupcorr, 2)
        withingroupcorr(i,u) = withingroupcorr(i,u)/(sqrt(groupcorr(i + nclasses - 1, i + nclasses - 1)*groupcorr(u,u)));
    end
end

% Discriminability Power (%)
sv = sv(1:nclasses-1, 1)./sum(sv(1:nclasses - 1, 1));
dp = 100.*(((withingroupcorr.^2)*(sv))./(sum((withingroupcorr.^2)*(sv))));
