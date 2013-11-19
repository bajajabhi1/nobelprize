%run maximal matching 
NoOfBatch = getenv('batch');
NoOfBatch = str2num(NoOfBatch);
distBest = 10000000;
bestPrediction = 1 ;

for ff1 = 1:NoOfBatch
	ff1name = sprintf('files%d/rawPredictions.txt',ff1);
	file1 = fopen(ff1name,'r');
	leader = dlmread(file1);
	leaderChange = zeros(size(leader)); ; 
	fclose('all') ; 

	for ff2 = 1:NoOfBatch
		ff1name = sprintf('files%d/rawPredictions.txt',ff1);
		ff2name = sprintf('files%d/rawPredictions.txt',ff2);
		file1 = fopen(ff1name,'r');
		file2 = fopen(ff2name,'r');
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
		cd ../gaimc
		[error actV  predV]=bipartite_matching(dist);
		predM = pred;
		actM = actual;
		for ( i = 1:n)
			predM(i,:) = pred(predV(i),:);
		end
		for ( i = 1:n)
			actM(i,:) = actual(actV(i),:);
		end
		
		predM = predM';
		actM = actM';
		%disp(predV);
		%disp(actV);
		%disp(predM);
		%disp(actM);
		cd ../files
		writeFile = sprintf('files%d/predicted%d.txt',ff1,ff2) ; 
		leaderChange = leaderChange + predM ; 
		dlmwrite(writeFile,predM,' ');
		fclose('all')
	end
	leaderChange = leaderChange ./ NoOfBatch ;
	for ( i = 1:size(leaderChange,1))
		leaderChange(i,:) = leaderChange(i,:) ./ sum(leaderChange(i,:)) ;
	end
	dist = 0 ; 

	for (i = 1:size(leaderChange,1))
		dist += norm(leaderChange(i,:) - leader(i,:)) ; 
	end
	dist = dist / size(leaderChange,1) ;
	if (dist < distBest)
		distBest = dist ; 
		bestPrediction = leaderChange ;
	end

end

writeFile = sprintf('predictedFinal.txt') ; 
dlmwrite(writeFile,bestPrediction,' ');
		