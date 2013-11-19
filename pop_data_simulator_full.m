%%%% use for topic modelling
%%% Arpit Gupta-Abhinav Bajaj	%%%
%%% Usage pop_data_simulator(outPopformat)
%%%
%%% outPopFormat - Output file format for Population
%%%%
rand("seed",1000456);
noOfSubPop = 3;
noOfPop = 10;

noOfMarkerLoci = getenv('loci');
noOfMarkerLoci = str2num(noOfMarkerLoci);
freq = getenv('freq');
freq = str2num(freq)	;
freqParam = 1/freq; %%  Wright Fisher model
noOfIndiv = getenv('indiv');
noOfIndiv = str2num(noOfIndiv);

batchSize = min(noOfMarkerLoci,1000);
NoOfBatch = noOfMarkerLoci/batchSize;

%%
drawFrom  = ones(noOfSubPop,1);
ratios1 = [0.70;0.20;0.10]; % Ratios of contribution of each sub pop
ratios2 = [0.20;0.65;0.15];
ratios3 = [0.20;0.00;0.80];
ratios4 = [0.50;0.40;0.10];
ratios5 = [0.30;0.60;0.10];
ratios6 = [0.10;0.10;0.80];
ratios7 = [0.15;0.25;0.60];
ratios8 = [0.10;0.35;0.45];
ratios9 = [0.05;0.60;0.35];
ratios10 = [0.4;0.20;0.40];

ratios = [ratios1 ratios2 ratios3 ratios4 ratios5 ratios6 ratios7 ratios8 ratios9 ratios10 ] ;
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
		[indiv ll tokens] = cohort_simulator_full(noOfIndiv,pops(k*batchSize+1:j*batchSize),i,k*batchSize+1,j)    ; 
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
