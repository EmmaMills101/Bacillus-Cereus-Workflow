#!/bin/bash
#Usage: sh trimmomatic.sh <path to input files>
#lmc297@cornell.edu
#jk2739@cornell.edu

cd $1
echo | pwd
for f in *.fastq.gz
do
if [ -f "${f%_R1.fastq.gz}_R1.trimmedP.fastq.gz}" ]
then
echo 'skip'${f}
continue
fi
echo 'trim' ${f}
trimmomatic PE -threads 7 -phred33 -trimlog log $f ${f%_R1.fastq.gz}_R2.fastq.gz ${f%_R1.fastq.gz}_R1.trimmedP.fastq.gz ${f%_R1.fastq.gz}_R1.trimmedS.fastq.gz ${f%_R1.fastq.gz}_R2.trimmedP.fastq.gz ${f%_R1.fastq.gz}_R2.trimmedS.fastq.gz ILLUMINACLIP:../../../../../miniconda3/envs/trim/share/trimmomatic/adapters/NexteraPE-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36;
done;
