%%%Arpit Gupta & nathan
%n is the number of individuals you want to draw
%%%pop_density is a row vector of size say, 1X10^6
%%%

function [cohort]  = cohort_simulator(n,pop_density,pop,begin)
cohort = zeros(n, length(pop_density)); 
allele_sample = rand(n,length(pop_density),2); 

for j = 1:length(pop_density)
       cohort(:,j) = uint32(allele_sample(:,j,1) <= pop_density(j)) + uint32(allele_sample(:,j,2) <= pop_density(j)); 
end

clear allele_sample ;

base = mode(cohort(:,1:length(pop_density)));

formatSpec = '%dV%d ';
for i=1:n
	filename = sprintf('files/pop%dindiv%d.txt',pop,i);
	Ind = find((base != cohort(i,:)) == 1) ;
	toPrint = cohort(i,Ind);
	fid = fopen(filename,'a') ;
	Ind = Ind + begin - 1;  
	fprintf(fid,formatSpec,[Ind;toPrint]);
	fclose(fid);
end
filename = sprintf('filesBase/pop%d.txt',pop);
fid = fopen(filename,'a');
fprintf(fid,formatSpec,base);
fclose(fid);
	







	
