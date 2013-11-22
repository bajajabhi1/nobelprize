#!/bin/bash
#$ -l mem=4G,time=10:30: -S /bin/bash -N eigenDataSim -j y -cwd

/nfs/apps/matlab/R2013a/bin/matlab -nojvm -singleCompThread -r "eigenstrat_pop_data_sim(3,3,100,1000000,10,0.8,0.5,1.6,1000)";
