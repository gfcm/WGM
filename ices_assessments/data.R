## Preprocess data, write TAF data tables

## Before: sid19.csv (bootstrap/data/SID)
## After:  assmt.csv (data)

library(icesTAF)

mkdir("data")

## Read SID data
sid <- read.taf("bootstrap/data/SID/sid19.csv", colClasses="character")

## Select assessment columns
assmt <- sid[c("ExpertGroup", "SpeciesCommonName", "StockKeyLabel",
               "DataCategory", "AssessmentType")]

## Write assessment table
write.taf(assmt, dir="data", quote=TRUE)
