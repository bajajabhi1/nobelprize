%%%% use for topic modelling
%%% Arpit Gupta-Abhinav Bajaj	%%%
%%% Usage pop_data_simulator(outPopformat)
%%%
%%% outPopFormat - Output file format for Population
%%%%
rand("seed",1000456);
noOfSubPop = 3;
noOfPop = 3;

noOfMarkerLoci = getenv('loci');
noOfMarkerLoci = str2num(noOfMarkerLoci);
freq = getenv('freq');
freq = str2num(freq)	;
freqParam = 1/freq; %%  Wright Fisher model
noOfIndiv = getenv('indiv');
noOfIndiv = str2num(noOfIndiv);

batchSize = min(noOfMarkerLoci,100);
NoOfBatch = noOfMarkerLoci/batchSize;

for B = 1:NoOfBatch
	dirName = sprintf('files/files%d',B) ; 
	mkdir (dirName );
	%disp(B); 
end

%%
drawFrom  = ones(noOfSubPop,1);
ratios1 = [0.70;0.20;0.10]; % Ratios of contribution of each sub pop
ratios2 = [0.20;0.65;0.15];
ratios3 = [0.20;0.00;0.80];
ratios = [ratios1 ratios2 ratios3] ;
ratiosWrite = ratios';
%a = a';
dlmwrite('true.txt',ratiosWrite,' ');
paramFile = sprintf('Indiv%dfreq%dsnp%d.txt',noOfIndiv,freq,noOfMarkerLoci)

subPops = zeros(noOfSubPop,noOfMarkerLoci);
for i = 1:noOfSubPop
	subPops(i,:) = subPopulation_simulator(noOfMarkerLoci,freqParam);
end

disp('SubPopulations generated');

indiv = zeros(noOfMarkerLoci,1);
formatSpec = 'pos%d*%d ' ; 
index = 1:1000000;
LL = 0;
Tokens = 0 ; 
for i = 1:noOfPop
	pops = population_simulator(subPops,drawFrom,ratios(:,i));
	k = 0 
	for j = 1:NoOfBatch
		k = j -1 ;
		%filename = sprintf('files/pop%dindiv%d',i,j);
		[indiv ll tokens] = cohort_simulator(noOfIndiv,pops(k*batchSize+1:j*batchSize),i,k*batchSize+1,j)    ; 
		LL = LL + ll;
		Tokens = Tokens + tokens ; 		
	end
end
%% write the output population generated
%writeToFile(indiv,outPopFormat);
disp('Cohorts drawn from population densities');
%save('Population_data.mat','indiv','pops','subPops','ratios');

%disp(Tokens);
%disp(LL/Tokens);
%disp(freq)
fparam  = fopen(paramFile,'w');
fprintf(fparam,'No of individuals %d \n',noOfIndiv);
fprintf(fparam,'No of SubPop %d \n',noOfSubPop);
fprintf(fparam,'Freq Paramater %f \n',freqParam);
fprintf(fparam,'No of Populations %d \n',noOfPop);
fprintf(fparam,"Log likelihood %f \n",LL/Tokens) ;
fprintf(fparam,"No of Tokens %d \n",Tokens );
fclose(fparam);
