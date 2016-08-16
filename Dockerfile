#################################################################
# Dockerfile
#
# Version:          1
# Software:         HMTools
# Software Version: 1
# Description:      Tools (written in C using htslib) for manipulating next-generation sequencing data
# Website:          https://github.com/hactor0/bam2go
# Tags:             Transcriptomics
# Base Image:       biodckr/biodocker
# Build Cmd:        docker build hactor0/bam2go 1.0/.
# Pull Cmd:         docker pull hactor0/bam2go
# Run Cmd:          docker run hactor0/bam2go
#################################################################

# base image
FROM biodckr/biodocker

################## BEGIN INSTALLATION ###########################

# install
RUN conda install samtools=1.3.1
RUN conda install bedtools=2.25.0
RUN wget "http://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/2.4.4/sratoolkit.2.4.4-ubuntu64.tar.gz" && \
  tar zxfv sratoolkit.2.4.4-ubuntu64.tar.gz && \
  cp -r sratoolkit.2.4.4-ubuntu64/bin/* /usr/bin


# change workdir to /data/
WORKDIR /data/

# define default command
CMD ["echo hello"]

##################### INSTALLATION END ##########################

# File Author / Maintainer
MAINTAINER hyunmin kim <human.actor0@gmail.com>
