#!/bin/bash
#SBATCH --job-name=download_fastq
#SBATCH --output=logs/download_%A_%a.out
#SBATCH --error=logs/download_%A_%a.err
#SBATCH --time=4:00:00
#SBATCH --mem=8G
#SBATCH -c 4
#SBATCH --partition short

module load conda/miniforge3/24.11.3-0
source ~/.research_config

# download the reference genomes
#ref_genome_dest_fp=$REF_GENOME_DIR"/hg38_primary.fa.gz"
#wget -O $ref_genome_dest_fp https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_49/GRCh38.primary_assembly.genome.fa.gz
#gzip -d $ref_genome_dest_fp

# download the annotation file
#annotation_dest_fp=$REF_GENOME_DIR"/primary_annotation.gtf.gz"
#wget -O $annotation_dest_fp https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_49/gencode.v49.primary_assembly.annotation.gtf.gz
#gzip -d $annotation_dest_fp

# active guideseq venv; remove scaffolds, etc
conda init
conda activate GENETHOFF
#ref_genome_dest_fp_uncompressed=$REF_GENOME_DIR"/hg38_primary.fa"
ref_genome_new_name=$REF_GENOME_DIR"/hg38_main_chroms.fa"
#sed -E 's/^(>chr[0-9XYM]+) .*/\1/' "$ref_genome_dest_fp_uncompressed" | \
#seqkit grep -n -f <(echo -e "chr1\nchr2\nchr3\nchr4\nchr5\nchr6\nchr7\nchr8\nchr9\nchr10\nchr11\nchr12\nchr13\nchr14\nchr15\nchr16\nchr17\nchr18\nchr19\nchr20\nchr21\nchr22\nchrX\nchrY\nchrM") > $ref_genome_new_name

# remove the old fasta files
# rm $ref_genome_dest_fp
# rm $ref_genome_dest_fp_uncompressed

# build the bowtie index
index_prefix=$REF_GENOME_DIR"/hg38_main_chroms"
bowtie2-build --threads 4 $ref_genome_new_name $index_prefix
