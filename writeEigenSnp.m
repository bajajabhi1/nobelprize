%% Author - Abhinav Bajaj
%%
function writeEigenSnp(noOfSNP,caseSnpLoc, refAllele, varAllele, filename)
count = 0 ;
for i=1:noOfSNP
	count = count +1;
	if(caseSnpLoc == i)
                dlmwrite(filename,sprintf('rs%d  11        0.000000               0 %s %s',count,refAllele, varAllele),'-append','delimiter','');
	else
		dlmwrite(filename,sprintf('rs%d  11        0.000000               0 A C',count),'-append','delimiter','');
	end
end

