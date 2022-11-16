#!/bin/bash

# safe
# fails on error
set -e

# stop if undefined variables
set -u

# Synopsis: runSalmon.sh <index> <fwd> <rev> <outdir> <salmon container>

# checks
[[ $# -ne 5 ]] && echo "this scripts needs 5 arguments" && exit 1

# same as above, less concise
#if [ $# -ne 3 ]; then
#	echo "this scripts needs 3 arguments"
#	exit 1
#fi

[[ ! -d $1 ]] && echo "the first argument should be the index directory" && exit 1

[[ ! -f $2 ]] && echo "the second argument should be the fwd file" && exit 1

[[ ! -f $3 ]] && echo "the third argument should be the reverse file" && exit 1

[[ ! -d $4 ]] && echo "the fourth argument should be the output directory" && exit 1

[[ ! -f $5 ]] && echo "the fifth argument should be the singularity / apptainer container for salmon" && exit 1

# run salmon
apptainer exec -B /proj:/proj $5 \
salmon quant -l A \
-i $1 -1 $2 -2 $3
-o $4 --seqBias --gcBias \
--validateMappings -p 7
