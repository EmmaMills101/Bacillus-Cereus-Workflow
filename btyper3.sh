#!/bin/bash
#Usage: sh btyper.sh <path to input files>

#download the latest most database (this does not need to be done every time)
python3 download_pubmlst_latest.py

cd $1
mkdir btyper_out

for f in *.fasta
do
python3 ./btyper-3.1.1/btyper3 --input $f --output btyper_out --fastani_path ./fastANI --ani_subspecies True --virulence True --bt True --panC True 

done
