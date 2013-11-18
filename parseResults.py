import sys
import re
topics = dict()
if __name__ == '__main__':
	infile = file('gene_composition.txt',"r")
	outfile = file('rawPredictions.txt',"w")
	pop = re.compile('pop[0-9]+')
	infile.next()
	for line in infile:
		line = line.strip()
		#print line
		tokens = line.split()
		##make a dictionary on population number and proceed from there . 
		#print "length",len(tokens)
		find = pop.search(tokens[1])
		if (find):
			
			find = find.group(0)
			find = find[3:]
			find = int(find)
			if find in topics:
				for i in range(2,len(tokens),2):
					topics[find][int(tokens[i])].append(float(tokens[i +1 ]))
			else:
				topics[find] = dict()
				ntopics = (len(tokens) -2) /2 
				for i in range(0,ntopics):
					topics[find][i] = []
				for i in range(2,len(tokens),2):
					topics[find][int(tokens[i])].append(float(tokens[i +1 ]))
		else:
			print 'some error in file ',tokens[1] ; 
		
	for pop in topics:
		for subPop in topics[pop]:
			sum  = 0

			for indiv in topics[pop][subPop]:
				sum = sum + indiv
			avg = sum / len(topics[pop][subPop])
			topics[pop][subPop] = avg
	for pop in topics:
		for subPop in topics[pop]:
			outfile.write(str(topics[pop][subPop]) + " ")
		outfile.write("\n")
	print('completed python part')



















