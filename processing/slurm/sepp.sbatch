#!/bin/bash
#SBATCH -p short # Partition or queue.
#SBATCH --job-name=sepp # Job name
#SBATCH --mail-type=ALL # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=jost9358@colorado.edu
#SBATCH --nodes=1 # Only use a single node
#SBATCH --ntasks=32 
#SBATCH --mem=16gb # Memory limit
#SBATCH --time=6:00:00 # Time limit hrs:min:sec
#SBATCH --output=/scratch/Users/jost9358/Glutenshield/slurm_outs/sepp_%j.out # Standard output and error log
#SBATCH --error=/scratch/Users/jost9358/Glutenshield/slurm_outs/sepp_%j.err # %j inserts job number

source activate qiime2-2021.4


qiime fragment-insertion sepp \
--i-representative-sequences qiime/dada2-out/representative_sequences.qza \
--i-reference-database qiime/sepp-refs-silva-128.qza \
--o-tree qiime/insertion-tree.qza \
--o-placements qiime/insertion-placements.qza \
--p-threads 32 \
--verbose

qiime fragment-insertion filter-features \
--i-table qiime/dada2-out/table.qza \
--i-tree qiime/insertion-tree.qza \
--o-filtered-table qiime/filtered-table.qza \
--o-removed-table qiime/removed-table.qza