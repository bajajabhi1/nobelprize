%%%%
%%% Abhinav Bajaj	%%%
%%%%
function eigenstrat_pop_data_sim(subPopCount, popCount,noOfLoci, indivCount, alleleFreq, probOfCaseVar2)
rand("seed",12002);
noOfSubPop = subPopCount;
noOfPop = popCount;
noOfMarkerLoci = noOfLoci;
lociBatchSize = 10;
freqParam = 1/500; %% 1000, Wright Fisher model
noOfIndiv = indivCount;
noOfIndivControl = indivCount;
varAlleleFreq = alleleFreq;
%% 
snpFileName = 'eigen.snp';
indivFileName = 'eigen.ind';
genoFileName = 'eigen.geno';
caseSnpLoc = 10;
refAllele= 'G';
varAllele = 'A';
%% taking GG as 0, AG|GA as 1 and AA as 2
alleleVar2 = 2; 
alleleVar1 = 1;
alleleVar0 = 0;
probOfVar2 = varAlleleFreq^2;
probOfVar1 = 2 * varAlleleFreq * (1-varAlleleFreq);
probOfVar0 = (1-varAlleleFreq)^2;
probCaseVar2 = probOfCaseVar2;
probCaseVarParam = 1.1;
probCaseVar1 = probCaseVar2 * 1.1;
probCaseVar0 = probCaseVar1 * 1.1;
probCase = probOfVar2 * probCaseVar2 + probOfVar1 * probCaseVar1 + probOfVar0 * probCaseVar0;
probVar2Case = (probOfVar2 * probCaseVar2) / probCase;
probVar1Case = (probOfVar1 * probCaseVar1) / probCase;
probVar0Case = (probOfVar0 * probCaseVar0) / probCase;
noOfIndivVar2 = round(probVar2Case * noOfIndiv);
noOfIndivVar1 = round(probVar1Case * noOfIndiv);
noOfIndivVar0 = noOfIndiv - noOfIndivVar2 - noOfIndivVar1;
disp(probVar2Case);
disp(probVar1Case);
disp(probVar0Case);
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
pops = zeros(noOfPop,noOfMarkerLoci);
%ratios = zeros(noOfSubPop,noOfPop);
for i = 1: noOfPop
	[pops(i,:),ratios(:,i)] = population_simulator(subPops,drawFrom);
	disp(pops(i,caseSnpLoc));
end

disp('Population Gene Densities Generated');
%indiv = zeros(noOfIndivVar2,lociBatchSize,noOfPop);
batchCtr = noOfMarkerLoci/lociBatchSize;
%disp(batchCtr);
for j = 1:batchCtr
	% Check if caseSnpLoc is in this batch or not
	if((caseSnpLoc >= ((j-1)*lociBatchSize+1)) & (caseSnpLoc <= (j*lociBatchSize)))
		% generate the batch for the caseSNP. no of columns wud be (noofIndivVar2 + noOfIndivvar1 + 0 + control), rows will be the lociBatchSize. 
		disp('Case SNP Case');
		tmpNoOfIndiv = noOfIndivVar2 + noOfIndivVar1 + noOfIndivVar0 + noOfIndivControl;
		tmpPopsMatrix = pops(:,(j-1)*lociBatchSize+1:j*lociBatchSize);
		%disp(size(tmpPopsMatrix));
		merge = eigenstrat_create_case_snp_batch(tmpPopsMatrix,noOfIndivVar2,noOfIndivVar1,noOfIndivVar0,noOfIndivControl,caseSnpLoc,lociBatchSize,alleleVar2,alleleVar1,alleleVar0,probVar2Case,probVar1Case,probVar0Case);	
		%indiv = zeros(tmpNoOfIndiv,lociBatchSize,noOfPop);
		%for i = 1:noOfPop
	%		indiv(:,:,i) = eigenstrat_create_case_snp_batch();
%		end
		
%		mergeTmp = [indiv(:,:,1)' indiv(:,:,2)' indiv(:,:,3)'];
	else
		disp(' Other case');
		%% create Var2
		indiv1 = zeros(noOfIndivVar2,lociBatchSize,noOfPop);
		for i = 1:noOfPop
			indiv1(:,:,i) = eigenstrat_cohort_sim(noOfIndivVar2,pops(i,(j-1)*lociBatchSize+1:j*lociBatchSize)); 
		end
		merge1 = [indiv1(:,:,1)' indiv1(:,:,2)' indiv1(:,:,3)'];
%		if((caseSnpLoc >= ((j-1)*lociBatchSize+1)) & (caseSnpLoc <= (j*lociBatchSize)))
%			merge1(caseSnpLoc-((j-1)*lociBatchSize),:)=alleleVar2;
%		end
%		disp(merge1);
		%% create Var1
		indiv2 = zeros(noOfIndivVar1,lociBatchSize,noOfPop);
		for i = 1:noOfPop
       	        	indiv2(:,:,i) = eigenstrat_cohort_sim(noOfIndivVar1,pops(i,(j-1)*lociBatchSize+1:j*lociBatchSize));
       		end
	       	merge2 = [indiv2(:,:,1)' indiv2(:,:,2)' indiv2(:,:,3)'];
%       	if((caseSnpLoc >= ((j-1)*lociBatchSize+1)) & (caseSnpLoc <= (j*lociBatchSize)))
%        		merge2(caseSnpLoc-((j-1)*lociBatchSize),:)=alleleVar1;
%		end
	%	disp(merge2);
        	%% create Var0
	        indiv3 = zeros(noOfIndivVar0,lociBatchSize,noOfPop);
	        for i = 1:noOfPop
	                indiv3(:,:,i) = eigenstrat_cohort_sim(noOfIndivVar0,pops(i,(j-1)*lociBatchSize+1:j*lociBatchSize));
	        end
		merge3 = [indiv3(:,:,1)' indiv3(:,:,2)' indiv3(:,:,3)'];
	%        if((caseSnpLoc >= ((j-1)*lociBatchSize+1)) & (caseSnpLoc <= (j*lociBatchSize)))
	%        	merge3(caseSnpLoc-((j-1)*lociBatchSize),:)=alleleVar0;
	%	end
	
	        %% create Control
	        indiv4 = zeros(noOfIndivControl,lociBatchSize,noOfPop);
	        for i = 1:noOfPop
	                indiv4(:,:,i) = eigenstrat_cohort_sim(noOfIndivControl,pops(i,(j-1)*lociBatchSize+1:j*lociBatchSize));
	        end
	        merge4 = [indiv4(:,:,1)' indiv4(:,:,2)' indiv4(:,:,3)'];
	
		% merge all	
		merge = [merge1 merge2 merge3 merge4];
	
	end % end if to check Snp Location
	% write merged to file
	dlmwrite(genoFileName,merge,'-append','delimiter','');
end
writeEigenIndiv(noOfIndivVar2*noOfPop, 1, refAllele, varAllele,indivFileName);
writeEigenIndiv(noOfIndivVar1*noOfPop, 1, refAllele, varAllele,indivFileName);
writeEigenIndiv(noOfIndivVar0*noOfPop, 1, refAllele, varAllele,indivFileName);
writeEigenIndiv(noOfIndivControl*noOfPop,0, refAllele, varAllele,indivFileName);
writeEigenSnp(noOfMarkerLoci, caseSnpLoc, refAllele, varAllele, snpFileName);
disp('Cohorts drawn from population densities');
