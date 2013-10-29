%%% Abhinav Bajaj
% n is the number of individuals you want to draw
%%%pop_density is a row vector of size say, 1X10^6
%%%

function [cohort]  = eigenstrat_cohort_sim(n,pop_density)
cohort = zeros(n, length(pop_density));
allele_sample = rand(n,length(pop_density),2);

for j = 1:length(pop_density)
       cohort(:,j) = uint32(allele_sample(:,j,1) <= pop_density(j)) + uint32(allele_sample(:,j,2) <= pop_density(j));
end

