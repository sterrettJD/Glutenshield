#!/bin/bash
#SBATCH -p short # Partition or queue.
#SBATCH --job-name=import # Job name
#SBATCH --mail-type=ALL # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=jost9358@colorado.edu
#SBATCH --nodes=1 # Only use a single node
#SBATCH --ntasks=1 # Run on a single CPU
#SBATCH --mem=16gb # Memory limit
#SBATCH --time=6:00:00 # Time limit hrs:min:sec
#SBATCH --output=/scratch/Users/jost9358/Glutenshield/slurm_outs/import_%j.out # Standard output and error log
#SBATCH --error=/scratch/Users/jost9358/Glutenshield/slurm_outs/import_%j.err # %j inserts job number

source activate qiime2-2021.4

mkdir -p qiime/demux 

qiime tools import \
  --type 'SampleData[PairedEndSequencesWithQuality]' \
  --input-path raw_seqs \
  --input-format CasavaOneEightSingleLanePerSampleDirFmt \
  --output-path qiime/demux/per_sample_sequences.qza