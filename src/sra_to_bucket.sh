#!/bin/bash
# INPUT: SRA id
# OUTPUT: bucket id where output FASTQ files are stored
yalm='
name: sra_to_fastq
description: Run fastq_dump file to generate fastq files from SRA files
inputParameters:
- name: INPUT
  defaultValue: SRR1575914 
outputParameters:
- name: OUTPUT
  localCopy:
    disk: datadisk
    path: output
resources:
  minimumCpuCores: 1
  minimumRamGb: 1
  zones:
  - us-central1-a
  - us-central1-b
  - us-central1-c
  - us-central1-f
  disks:
  - name: datadisk
    type: PERSISTENT_HDD
    sizeGb: 100
    mountPoint: /mnt/data
docker:
  imageName: actor0/bam2go
  cmd: "fastq-dump -X 100 --gzip --outdir ${OUTPUT} ${INPUT}"
'

sra_to_fastq(){
  local input=$1
  local output=$2
  echo "$yalm" > ./$FUNCNAME.yalm
  local cmd="
gcloud alpha genomics pipelines run \
  --pipeline-file ./$FUNCNAME.yalm \
  --logging $output/logs \
  --inputs INPUT=$input \
  --outputs OUTPUT=$output"
  echo "$cmd" | bash
}

##sra_to_fastq SRR1575914 "gs://bg-sra"
