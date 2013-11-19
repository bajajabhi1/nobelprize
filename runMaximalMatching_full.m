%run maximal matching 
file1 = fopen('true.txt','r');
file2 = fopen('rawPredictions.txt','r');
actual = dlmread(file1);
pred = dlmread(file2);
actual = actual'
pred = pred'
n = size(pred,1);
dist = zeros(n,n);
for i = 1:n
        for j= 1:n
                dist(i,j) = norm(actual(i,:)-pred(j,:));
        end
end
dist
dist = 1 ./ dist
cd gaimc
[error actV  predV]=bipartite_matching(dist);
predM = pred;
actM = actual;
for ( i = 1:n)
        predM(i,:) = pred(predV(i),:);
end
for ( i = 1:n)
        actM(i,:) = actual(actV(i),:);
end
predM = predM' ;
actM = actM' ;
%disp(predV);
%disp(actV);
disp(predM);
%disp(actM);
cd ..
dlmwrite('predicted.txt',predM,' ');