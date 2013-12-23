filename1 = 'predicted.txt';
filename2 = 'true.txt';
predicted = dlmread(filename1) ;
original = dlmread(filename2) ; 
sim = zeros(10,1);
for i = 1:10
	predicted(i,:) = predicted(i,:)/sum(predicted(i,:)) ;
end
for i = 1:10
	for j = 1:3
		sim(i) = sim(i) + log(original(i,j)/predicted(i,j))*original(i,j) ;

	end
end

sumErr = sum(sim) ;
avgErr = mean(sim) ; 
disp(avgErr);
f1 = fopen('results.txt','a') ;
fprintf(f1, '%f ', avgErr);
%disp(sumErr);
