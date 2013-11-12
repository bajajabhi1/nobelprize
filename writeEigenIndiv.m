%% Author - Abhinav Bajaj
%% 
function writeEigenIndiv(indivInfo, filename)
for i=1:size(indivInfo,1)
	if indivInfo(i,2)==1
		caseText = 'Case';
	else
		caseText = 'Control';
	end
	gen = rand(1,1);
	genText = 'M';
	if gen>0.5
		genText = 'F';
	end
	dlmwrite(filename,sprintf('             SAMPLE%d %s   %s',i,genText,caseText),'-append','delimiter','');
end

