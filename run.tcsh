#!/bin/tcsh

# source /etc/profile.d/modules.sh 2>/dev/null || true; \

module purge
module load gcc/11.4.0
module load python/3.11.9  
make run
source ~/.tcshrc