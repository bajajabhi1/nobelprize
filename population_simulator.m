%%%Arpit Gupta
%%%%Draw populations from subpopulations
%%ratios and drawFrom should be column vectors
%%drawFrom is 1 for the subpopulation from which we want to draw our population, otherwise it is zero
%%%%%%%%
function [pop] = population_simulator(subPopulations,drawFrom,ratios)
if nargin == 1 
	drawFrom = ones(1,size(subPopulations,1)) ; 
endif
if nargin < 3
	 
		ratios = rand(size(subPopulations,1),1) ;
		ratios = ratios .* drawFrom;
		ratios = ratios/sum(ratios) ;
endif
pop = zeros(1,size(subPopulations,2)) ; 
for i = 1:size(subPopulations,2)
	pop(i) = sum(subPopulations(:,i) .* ratios);
end
