%%Arpit code to write small subset of individuals, to test topic modelling toolbox

for i = 1:100
	filename = sprintf('files/pop%d.txt',i);
	dlmwrite(filename,indiv(i,:,1),'delimiter',' ');
end
