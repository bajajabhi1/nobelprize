%%%%
%%% Abhinav Bajaj	%%%
%%% Usage pop_data_simulator(outPopformat)
%%%
%%% outPopFormat - Output file format for Population
%%%%

noOfSubPop = 3;
noOfPop = 3;
noOfMarkerLoci = 1000000;
freqParam = 500; %% 1000, Wright Fisher model
noOfIndiv = 500;

%%
drawFrom  = ones(noOfSubPop,1);
ratios1 = [0.7;0.2;0.1]; % Ratios of contribution of each sub pop
ratios2 = [0.4;0;0.6];
ratios3 = [0.2;0.3;0.5];
ratios = [ratios1 ratios2 ratios3] ;
subPops = zeros(noOfSubPop,noOfMarkerLoci);
for i = 1:noOfSubPop
	subPops(i,:) = subPopulation_simulator(noOfMarkerLoci,freqParam);
end

disp('SubPopulations generated');
%pops = zeros(noOfPop,noOfMarkerLoci);
%ratios = zeros(noOfSubPop,noOfPop);
%for i = 1: noOfPop
%	[pops(i,:),ratios(:,i)] = population_simulator(subPops,drawFrom);
%end

disp('Population Gene Densities Generated');
%whos
%indiv = zeros(noOfIndiv,noOfMarkerLoci,noOfPop);
indiv = zeros(noOfMarkerLoci,1);
formatSpec = 'pos%d*%d ' ; 
index = 1:1000000;
%whos
for i = 1:noOfPop
	%whos
	pops = population_simulator(subPops,drawFrom,ratios(:,i));
	k = 0 
	for j = 1:1000
		k = j -1 ;
		filename = sprintf('files/pop%dindiv%d',i,j);
		indiv = cohort_simulator(noOfIndiv,pops(k*1000+1:j*1000),i,k*1000+1)    ; 
		%fid = fopen(filename,'w');
		%fprintf(fid,formatSpec,[index;indiv]);
		%fclose(fid);
		%disp(filename);
	end
end
%% write the output population generated
%writeToFile(indiv,outPopFormat);
disp('Cohorts drawn from population densities');
%save('Population_data.mat','indiv','pops','subPops','ratios');

