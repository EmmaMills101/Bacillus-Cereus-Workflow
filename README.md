# Bacillus-Cereus-Workflow
Workflow of all bioinformatic tools and processes

### Workflow ###

#Downloading Reads - SRA ToolKit v2.10.9
fasterq-dump --split-files SRR2541537

#Checking Reading Quality - FastQC v2.8.0
fastqc ./fastqc_results --extract SRR2541537_R1.fastq SRR2541537_R2.fastq

#Trimming Adapters and Poor Quality Regions - Trimmomatic v0.39
sh trimmomatic.sh 

#Assembling Draft Genomes - SPAdes v3.15
sh spades.sh

#Annontating Genomes - PROKKA v1.14.6
prokka ../all_assemblies/SRR2541537.fasta -outdir SRR2541537 --prefix H7-0926

#Pan Genome Analysis - Roary v3.11.2
roary -e --dont_delete_files --mafft -g 80000 --p 8  */*.gff -e

#Phylogentic Inference - RAxML v8.2.12
raxmlHPC -m GTRGAMMA -p 12345 -s core_gene_alignment.aln -n Bacillus -T 50 -# 100

#AMR Gene Detection of Draft Genomes - Abricate v1.0.1 - Databases: NCBI, MEGARES, and Resfinder
abricate --db megagres *.fasta > megares.results.tab
abricate --summary megares.results.tab > ncbi.summary.tab

#AMR Gene Detection of Processed Reads - Abriba v2.14.6 - Databases: MEGARES and Resfinder 
ariba run out.megares.prepareref/ SRR2541537_R1.trimmedP.fastq.gz SRR2541537_R2.trimmedP.fastq.gz SRR2541537

#Virulence, MLST, panC Group, and Species Identification - Btyper3 v3.1.0
sh btyper3.sh
