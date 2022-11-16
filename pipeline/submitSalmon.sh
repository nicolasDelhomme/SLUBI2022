#!/bin/bash

# be safe
set -eu

# variables
proj=snic2022-22-920
index=/proj/snic2022-23-479/share/Day2/reference/salmon/Pabies1.0-all-phase.gff3.CDSandLTR-TE_salmon-version-1dot1dot0
in=/proj/snic2022-23-479/share/Day2/trimmomatic
out=/proj/snic2022-23-479/nobackup/$USER/salmon
container=/proj/snic2022-23-479/nobackup/delhomme/singularity/salmon_1.9.0.sif

# create the out dir if it does not exist
[[ ! -d $out ]] && mkdir $out

# loop
for f in $(find $in -name "*_trimmomatic_1.fq.gz"); do
     fnam=$(basename ${f/_1.fq.gz/})
     
     [[ ! -d $out/$fnam ]] && mkdir $out/$fnam     

     sbatch -t 1:00:00 -A $proj -n 7 \
     --mail-type=END,FAIL --mail-user=nicolas.delhomme@umu.se \
     -o $out/${fnam}.out -e $out/${fnam}.err \
     runSalmon.sh $index $f ${f/_1.fq.gz/_2.fq.gz} $out/$fnam $container
done
