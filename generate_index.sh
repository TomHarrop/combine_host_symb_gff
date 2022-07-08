#!/usr/bin/env bash

# Just `cat` the two fastas together
#
# Files downloaded from http://aten.reefgenomics.org/download/ and
# https://espace.library.uq.edu.au/view/UQ:8279c9a/Cladocopium_goreaui.zip?dsi_version=b32c42da081efc36eaa5d8118d322bc6
zcat \
    <( unzip -p data/Cladocopium_goreaui.zip \
       Cladocopium_goreaui/Cladocopium_goreaui.genome.fa.gz ) \
    data/aten_final_0.11.fasta.gz \
    > output/combined.aten_0.11.maker_post_001.Cladocopium_goreaui.fasta

# use rna-star to generate a mapping index
STAR \
    --runThreadN 32 \
    --runMode genomeGenerate \
    --genomeDir output/index \
    --genomeFastaFiles output/combined.aten_0.11.maker_post_001.Cladocopium_goreaui.fasta \
    --sjdbGTFfile output/combined.aten_0.11.maker_post_001.Cladocopium_goreaui.gff \
    --sjdbOverhang 149 \
    --sjdbGTFtagExonParentTranscript Parent

# you can map against this using STAR --genomeDir output/index etc...