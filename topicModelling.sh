#! /bin/bash
echo 'order of parameters is loci freq individuals aplha iter'
export loci=$1
export freq=$2
export indiv=$3
#echo $3
octave pop_data_simulator.m

cd ../../mallet
let "batch = $1/1000"
export batch
for i in `seq 1 $batch`;
do
	./runMallet.sh ../nobel/nobelprize/files/files 3 $4 $5 $i
done
cd ../nobel/nobelprize
for i in `seq 1 $batch`;
do
	cd files/files$i
	python ../../parseResults.py
	cd ..
	cd ..
	#echo $i
done
cd files
octave ../runMaximalMatching.m

echo "done"
cd ..
#folder='files'
#folder=$folder$(date +"%m_%d_%Y_%H_%M_%S")
folder='aplha-'$4'-freq-'$2'-loci-'$1'-indiv-'$3'-iter-'$5
##folder='loci-'
##folder=$folder$1'-freq-'$2'-indiv-'$3
##echo $folder
mv files $folder
#mv 'true.txt' $folder
#mv 'rawPredictions.txt' $folder
#mv 'predicted.txt' $folder
#mv Indiv* $folder
mkdir files



##############
#cut individuals 
#random sample alelles 
#hard cut off alleles
