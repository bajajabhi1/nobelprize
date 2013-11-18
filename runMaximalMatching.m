%run maximal matching 

for ff1 = 1:10
	for ff2 = 1:10
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
		disp(predM);
		disp(actM);
		cd ../files
		writeFile = sprintf('predicted%d-%d.txt',ff1,ff2) ; 
		dlmwrite(writeFile,predM,' ');
		fclose('all')
	end
end
