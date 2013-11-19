#! /bin/bash
echo 'order of parameters is loci freq individuals aplha iter'
export loci=$1
export freq=$2
export indiv=$3
#echo $3
octave pop_data_simulator_full.m

cd ../../mallet

#for i in `seq 1 10`;
#do
./runMallet_full.sh ../nobel/nobelprize/files 3 $4 $5 $i
#done
cd ../nobel/nobelprize
python parseResults_full.py
octave runMaximalMatching_full.m
echo "done"
#folder='files'
#folder=$folder$(date +"%m_%d_%Y_%H_%M_%S")
folder='aplha-'$4'-freq-'$2'-loci-'$1'-indiv-'$3'-iter-'$5
#folder='loci-'
#folder=$folder$1'-freq-'$2'-indiv-'$3
#echo $folder
mv files $folder
mv 'true.txt' $folder
mv 'rawPredictions.txt' $folder
mv 'predicted.txt' $folder
mv Indiv* $folder
mkdir files



##############
#cut individuals 
#random sample alelles 
#hard cut off alleles
