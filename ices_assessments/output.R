## Extract results of interest, write TAF output tables

## Before: assmt.csv (model)
## After:  categories.csv, methods.csv, models.csv (output)

library(icesTAF)

mkdir("output")

## Read assessment table
assmt <- read.taf("model/assmt.csv", colClasses="character")
assmt$Category <- substring(assmt$DataCategory, 1, 1)  # combine subcategories

## Calculate how many stocks are in each category
categories <- aggregate(Method~Category, assmt, length)
names(categories) <- c("Category", "Stocks")

## Show methods of interest that are used for each category
m <- aggregate(Method~Category, assmt, function(m) sort(unique(m)))
skip <- c("Age-based", "Age-length based", "Biomass model", "Salmon", "SCA",
          "Survey-based", "UWTV")
m$Method[[1]] <- m$Method[[1]][!(m$Method[[1]] %in% skip)]
m$Method[[4]] <- m$Method[[4]][m$Method[[4]] != "No assessment"]
methods <- m
methods$Method <- sapply(methods$Method, paste, collapse=", ")

## Calculate how many stocks are assessed with each model
models <- table(assmt$Method[assmt$Method %in% m$Method[[1]]])
models <- sort(models, decreasing=TRUE)
models <- as.data.frame(models)
names(models) <- c("Model", "Assessments")

## Write tables
write.taf(categories, dir="output")
write.taf(methods, dir="output", quote=TRUE)
write.taf(models, dir="output")
