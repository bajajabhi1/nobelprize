%% Author - Arpit code, Abhinav Bajaj
%% 
%% Usage writeToFile(indiv, outPopFormat)
%% Arguments -- 
%% indiv - 3 dimensional matrix having genotype data of populations (indiv,marker,pop) 
%% outPopFormat - format of file in which the genotype of individuals to be written
%%                value is 1 - for EIGENSTRAT
%%                value is 2 - for STRUCTURE
%%                value is 3 - for TOPIC MODELLING
%%

function writeToFile(indiv, outPopFormat)

switch(outPopFormat)
	case 1
		disp('GENERATING EIGENSTRAT FORMAT');
		filename = 'eigen.geno';
		disp(size(indiv,3));
		for i=1:size(indiv,3)
			dlmwrite(filename,indiv(:,:,i)','-append','delimiter','');
		end
		filename = 'eigen.ind';
		%for()
		%sprintf('             SAMPLE4 F    Control');
		%sprintf('             SAMPLE1 M       Case');
		%end
		filename = 'eigen.snp'
		%rs0000  11        0.000000               0 A C
	case 2
		disp('GENERATING STRUCTURE FORMAT');
	case 3
		disp('GENERATING TOPIC MODELLING FORMAT');
	otherwise
		disp('Invalid format. Valid values are 1,2 and 3');
end
%for i = 1:100
%	filename = sprintf('files/pop%d.txt',i);
%	dlmwrite(filename,indiv(i,:,1),'delimiter',' ');
%end
