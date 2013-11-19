%%%Arpit Gupta
%n is the number of individuals you want to draw
%%%pop_density is a row vector of size say, 1X10^6
%%%

function [cohort LL Token ]   = cohort_simulator_full(n,pop_density,pop,begin,batch)
cohort = zeros(n, length(pop_density)); 
allele_sample = rand(n,length(pop_density),2); 

for j = 1:length(pop_density)
       cohort(:,j) = uint32(allele_sample(:,j,1) <= pop_density(j)) + uint32(allele_sample(:,j,2) <= pop_density(j)); 
end

clear allele_sample ;

base = mode(cohort(:,1:length(pop_density)));
%length(base)
formatSpec = '%dV%d ';
LL = 0;
Token = 0; 
for i=1:n
	filename = sprintf('files/pop%dindiv%d.txt',pop,i);
	filename2 = sprintf('test/pop%dindiv%d.txt',pop,i);
	Ind = find((base != cohort(i,:)) == 1) ;
	
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%comment the below line when you do not want everything to be printed
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%Ind = 1:length(pop_density);
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	toPrint = cohort(i,Ind);
	LLInd = Ind ; 
	Ind = Ind + begin - 1;  
	if ( i<=500)
		fid = fopen(filename,'a') ;
		%disp(filename);
		fprintf(fid,formatSpec,[Ind;toPrint]);
		fclose(fid);
	else
		fid2 = fopen(filename2,'a');
	
		fprintf(fid2,formatSpec,[Ind;toPrint]);
		fclose(fid2);
	endif
	%size(LLInd)
	for yy = 1:length(LLInd)
		Token = Token + 1;
		ll = 0 ;
		%disp(LLInd(yy));
		if (toPrint(yy) == 0)
			ll = 2*log(1 - pop_density(LLInd(yy))) ;
		elseif(toPrint(yy) == 1)
			ll = 2*(log(pop_density(LLInd(yy))) + log(1-pop_density(LLInd(yy))));
		else
			ll = 2*log(pop_density(LLInd(yy))) ;		 	
		endif
		LL = LL + ll ;
	end
 
end
filename = sprintf('filesBase/pop%d.txt',pop);
fid = fopen(filename,'a');
fprintf(fid,formatSpec,base);
fclose(fid);
	







	
