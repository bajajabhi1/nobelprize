%n is the number of individuals you want to draw

function []  = cohort_simulator(n,pop_density)
cohort = rand(n,length(pop_density),2)
for j = 1:length(pop_density)
	cohort(:,j,:) = cohort(:,j,:) <= pop_density(j)

	
