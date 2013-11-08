%%%% use for topic modelling
%%% Arpit Gupta-Abhinav Bajaj	%%%
%%% Usage pop_data_simulator(outPopformat)
%%%
%%% outPopFormat - Output file format for Population
%%%%
rand("seed",1000456);
noOfSubPop = 3;
noOfPop = 3;
noOfMarkerLoci = 1000;
freq = 500;
freqParam = 1/freq; %%  Wright Fisher model
noOfIndiv = 100;

batchSize = 1000;
NoOfBatch = noOfMarkerLoci/batchSize;

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
fparam  = fopen(paramFile,'w');
fprintf(fparam,'No of individuals %d \n',noOfIndiv);
fprintf(fparam,'No of SubPop %d \n',noOfSubPop);
fprintf(fparam,'Freq Paramater %f \n',freqParam);
fprintf(fparam,'No of Populations %d \n',noOfPop);
fclose(fparam);

subPops = zeros(noOfSubPop,noOfMarkerLoci);
for i = 1:noOfSubPop
	subPops(i,:) = subPopulation_simulator(noOfMarkerLoci,freqParam);
end

disp('SubPopulations generated');

indiv = zeros(noOfMarkerLoci,1);
formatSpec = 'pos%d*%d ' ; 
index = 1:1000000;
for i = 1:noOfPop
	pops = population_simulator(subPops,drawFrom,ratios(:,i));
	k = 0 
	for j = 1:NoOfBatch
		k = j -1 ;
		filename = sprintf('files/pop%dindiv%d',i,j);
		indiv = cohort_simulator(noOfIndiv,pops(k*batchSize+1:j*batchSize),i,k*batchSize+1)    ; 
		
	end
end
%% write the output population generated
%writeToFile(indiv,outPopFormat);
disp('Cohorts drawn from population densities');
%save('Population_data.mat','indiv','pops','subPops','ratios');

