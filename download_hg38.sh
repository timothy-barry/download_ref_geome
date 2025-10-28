#!/bin/bash
#SBATCH --job-name=download_fastq
#SBATCH --output=logs/download_%A_%a.out
#SBATCH --error=logs/download_%A_%a.err
#SBATCH --time=2:00:00
#SBATCH --mem=4G
#SBATCH --partition short

# download the reference genomes
#source ~/.research_config
#dest_fp=$REF_GENOME_DIR"/hg38_primary.fa.gz"
#wget -O $dest_fp https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_49/GRCh38.primary_assembly.genome.fa.gz
gzip -d $dest_fp

# download the annotation file
dest_fp=$REF_GENOME_DIR"/primary_annotation.gtf.gz"
wget -O $dest_fp https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_49/gencode.v49.primary_assembly.annotation.gtf.gz
gzip -d $dest_fp
