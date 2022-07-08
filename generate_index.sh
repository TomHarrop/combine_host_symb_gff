#!/usr/bin/env bash

zcat \
	<( unzip -p data/Cladocopium_goreaui.zip \
	   Cladocopium_goreaui/Cladocopium_goreaui.genome.fa.gz ) \
    data/aten_final_0.11.fasta.gz \
    > output/combined.aten_0.11.maker_post_001.Cladocopium_goreaui.fasta

STAR \
	--runThreadN 32 \
	--runMode genomeGenerate \
	--genomeDir output/index \
	--genomeFastaFiles output/combined.aten_0.11.maker_post_001.Cladocopium_goreaui.fasta \
	--sjdbGTFfile output/combined.aten_0.11.maker_post_001.Cladocopium_goreaui.gff \
	--sjdbOverhang 149 \
	--sjdbGTFtagExonParentTranscript Parent