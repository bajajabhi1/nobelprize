%%%%
%%% Abhinav Bajaj	%%%
%%% Usage pop_data_simulator(outPopformat)
%%%
%%% outPopFormat - Output file format for Population
%%%%
function pop_data_simulator(outPopFormat)

noOfSubPop = 5;
noOfPop = 3;
noOfMarkerLoci = 10;
freqParam = 1e3; %% 1000, Wright Fisher model
noOfIndiv = 10;

%%
drawFrom  = ones(noOfSubPop,1);
% ratios = [0.3;0.2;0.1;0.1;0.3]; % Ratios of contribution of each sub pop

subPops = zeros(noOfSubPop,noOfMarkerLoci);
for i = 1:noOfSubPop
	subPops(i,:) = subPopulation_simulator(noOfMarkerLoci,freqParam);
end

disp('SubPopulations generated');
pops = zeros(noOfPop,noOfMarkerLoci);
ratios = zeros(noOfSubPop,noOfPop);
for i = 1: noOfPop
	[pops(i,:),ratios(:,i)] = population_simulator(subPops,drawFrom);
end

disp('Population Gene Densities Generated');

indiv = zeros(noOfIndiv,noOfMarkerLoci,noOfPop);
for i = 1:noOfPop
	indiv(:,:,i) = cohort_simulator(noOfIndiv,pops(i,:)) ; 
end
%% write the output population generated
writeToFile(indiv,outPopFormat);
disp('Cohorts drawn from population densities');
save('Population_data.mat','indiv','pops','subPops','ratios');

