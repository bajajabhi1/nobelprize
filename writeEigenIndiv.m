%% Author - Abhinav Bajaj
%% 
function writeEigenIndiv(startIndex, noOfIndiv, isCase, refAllele, varAllele, filename)
caseText = 'Control';
if isCase==1
	caseText = 'Case';
end
count = startIndex;
for i=1:noOfIndiv
	count = count+1;
	gen = rand(1,1);
	genText = 'M';
	if gen>0.5
		genText = 'F';
	end
	dlmwrite(filename,sprintf('             SAMPLE%d %s   %s',count,genText,caseText),'-append','delimiter','');
end

