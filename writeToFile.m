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
		%disp(size(indiv,3));
		for i=1:size(indiv,3)
			dlmwrite(filename,indiv(:,:,i)','-append','delimiter','');
		end
		filename = 'eigen.ind';
		count = 0;
		for i=1:size(indiv,3)
			cas = rand(1,size(indiv,1));
			for j=1:size(indiv,1)
				count = count+1;
				gen = rand(1,1);
				caseText = 'Control';
				genText = 'M';
				if cas(j)>0.5
					caseText = 'Case';
				end
				if gen>0.5
					genText = 'F';
				end
				dlmwrite(filename,sprintf('             SAMPLE%d %s   %s',count,genText,caseText),'-append','delimiter','');
			end
		end
		filename = 'eigen.snp';
		count=0;
		for i=1:size(indiv,2);
			dlmwrite(filename,sprintf('rs%d  11        0.000000               0 A C',count),'-append','delimiter','');
			count=count+1;	
		end
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
