#!/usr/bin/env Rscript

library(GenomicRanges)
library(rtracklayer)
library(data.table)

host_gff_file <- "data/aten_0.11.maker_post_001.genes.gff.gz"
symb_gff_file <- unzip("data/Cladocopium_goreaui.zip",
                       "Cladocopium_goreaui/Cladocopium_goreaui.gff.gz")

# read the gff
host_gff <- import.gff3(host_gff_file)
symb_gff <- import.gff3(symb_gff_file)

# combine into a large data table
comb_table <- rbindlist(list(
  as.data.table(host_gff),
  as.data.table(symb_gff)
))

# run comb_table for a peek... it's 1.5 M records

# free up RAM. The GFF uses 2 GB or so
rm(host_gff, symb_gff)
gc(TRUE)

# make it back into a gff
comb_gff <- sort(makeGRangesFromDataFrame(
  comb_table,
  keep.extra.columns = TRUE))

# free up RAM. The data.table uses 2 GB or so
rm(comb_table)
gc(TRUE)

export.gff3(
  comb_gff,
  "output/combined.aten_0.11.maker_post_001.Cladocopium_goreaui.gff")

