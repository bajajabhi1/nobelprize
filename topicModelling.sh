#! /bin/bash
octave pop_data_simulator.m
cd ../../mallet
./runMallet.sh ../nobel/nobelprize/files 3
cd ../nobel/nobelprize
python parseResults.py
octave runMaximalMatching.m
echo "done"
folder='files'
folder=$folder$(date +"%m_%d_%Y_%H_%M_%S")
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
