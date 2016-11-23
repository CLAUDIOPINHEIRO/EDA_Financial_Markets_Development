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

## DAX in Euros
dax <- read.csv("dax.csv")
## Euro/USD
eur_usd <- read.csv("eur_us.csv")

## Merge data frames
dax_cur <- merge(dax, eur_usd, all=TRUE)
## Create new Column for Dax adjusted to daily Euro/Dollar Currency Exchange Rate
dax_cur$Dax_Close_in_USD <- dax_cur$Close * dax_cur$Value

drops_dax <- c("Open", "High", "Low", "Volume", 
               "Adjusted.Close", "Value", "Close")
dax_cur <- dax_cur[ , !(names(dax_cur) %in% drops_dax)]


## FTSE
ftse <- read.csv("FTSE.csv", stringsAsFactors = FALSE)
#Change Date Format
ftse$Date <- as.POSIXct(ftse$Date, format = "%d-%B-%Y") 

## load usd gbp currency '''''''''''''''''''''''''''''
usd_gbp <- read.csv("usd_gbp.csv", stringsAsFactors = FALSE)
str(usd_gbp)
setnames(usd_gbp, "DATE", "Date")
usd_gbp$DATE = as.POSIXct(usd_gbp$DATE, format = "%Y-%m-%d") 


## merge data frames 
ftse_cur <- merge(ftse, usd_gbp, all=TRUE)

str(ftse_cur)
ftse_cur$ftse_close_in_usd <- ftse_cur$Close.Price / ftse_cur$RATE

head()




## join dataframes

dj_snp <- merge(dj, snp, all = TRUE)
dj_snp_g <- merge(dj_snp, gold, all = TRUE)
dj_snp_g_n <- merge(dj_snp_g, nasdaq, all=TRUE)
dj_snp_g_n_d <- merge(dj_snp_g_n, dax_cur, all=TRUE)
