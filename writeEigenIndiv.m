%% Author - Abhinav Bajaj
%% 
%% Usage writeToFile(indiv, outPopFormat)
%% Arguments -- 
%% indiv - 3 dimensional matrix having genotype data of populations (indiv,marker,pop) 
function writeEigenIndiv(noOfIndiv, isCase, refAllele, varAllele, filename)
caseText = 'Control';
if isCase==1
	caseText = 'Case';
end
count = 0;
for i=1:noOfIndiv
	count = count+1;
	gen = rand(1,1);
	genText = 'M';
	if gen>0.5
		genText = 'F';
	end
	dlmwrite(filename,sprintf('             SAMPLE%d %s   %s',count,genText,caseText),'-append','delimiter','');
end

