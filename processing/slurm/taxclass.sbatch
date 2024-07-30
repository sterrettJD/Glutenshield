#!/bin/bash
#SBATCH -p short # Partition or queue.
#SBATCH --job-name=taxclass # Job name
#SBATCH --mail-type=ALL # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=jost9358@colorado.edu
#SBATCH --nodes=1 # Only use a single node
#SBATCH --ntasks=1
#SBATCH --mem=8gb # Memory limit
#SBATCH --time=6:00:00 # Time limit hrs:min:sec
#SBATCH --output=/scratch/Users/jost9358/Glutenshield/slurm_outs/taxclass_%j.out # Standard output and error log
#SBATCH --error=/scratch/Users/jost9358/Glutenshield/slurm_outs/taxclass_%j.err # %j inserts job number

source activate qiime2-2021.4

qiime feature-classifier classify-sklearn \
--i-reads qiime/dada2-out/representative_sequences.qza \
--i-classifier qiime/silva-138-99-515-806-nb-classifier.qza \
--output-dir qiime/silva-classified

qiime metadata tabulate \
--m-input-file qiime/silva-classified/classification.qza \
--o-visualization qiime/silva-classified/classification.qzv

mv qiime/silva-classified/classification.qza qiime/taxonomy-silva.qza
mv qiime/silva-classified/classification.qzv qiime/taxonomy-silva.qzv
