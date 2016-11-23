## load libraries
library(dplyr)
library(data.table)
## load datasets

dj <- read.csv("dowjones.csv")
gold <- read.csv("gold.csv")
snp <- read.csv("snp.csv")
nasdaq <- read.csv("nasdaq.csv")

identical(dj$Date, snp$Date)

## Data Wrangling

## renaming of columns in dataframes

# Dow Jones Dataset
#dj$dj_date <- dj$Date
dj$dj_close <- dj$Close

drops <- c("High", "Low", "Close", "Volume", "Open", "Adjusted.Close")
dj <- dj[ , !(names(dj) %in% drops)]

# S&P Dataset

#snp$snp_date <- snp$Date
snp$snp_close <- snp$Close
snp <- snp[ , !(names(snp) %in% drops)]

## Gold
setnames(gold, "Value", "gold_close")

## Nasdaq

str(nasdaq)
setnames(nasdaq, "Value", "nasdaq_close")

## join dataframes

dj_snp <- merge(dj, snp, all = TRUE)
dj_snp_g <- merge(dj_snp, gold, all = TRUE)
dj_snp_g_n <- merge(dj_snp_g, nasdaq, all=TRUE)
