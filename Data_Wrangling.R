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
str(ftse)

#Change Date Format
ftse$Date <- as.Date(ftse$Date, format = "%d-%B-%Y") 

## for some reason, changing the date format leads to missing values for the
## month of october. Not the best solution but entering the missing values
## by hand

ftse$Date[88] <- "2016-10-03"
ftse$Date[89] <- "2016-10-04"
ftse$Date[90] <- "2016-10-05"
ftse$Date[91] <- "2016-10-06"
ftse$Date[92] <- "2016-10-07"
ftse$Date[93] <- "2016-10-10"
ftse$Date[94] <- "2016-10-11"
ftse$Date[95] <- "2016-10-12"
ftse$Date[96] <- "2016-10-13"
ftse$Date[97] <- "2016-10-14"
ftse$Date[98] <- "2016-10-17"
ftse$Date[99] <- "2016-10-18"
ftse$Date[100] <- "2016-10-19"
ftse$Date[101] <- "2016-10-20"
ftse$Date[102] <- "2016-10-21"
ftse$Date[103] <- "2016-10-24"
ftse$Date[104] <- "2016-10-25"
ftse$Date[105] <- "2016-10-26"
ftse$Date[106] <- "2016-10-27"
ftse$Date[107] <- "2016-10-28"
ftse$Date[108] <- "2016-10-31"

## Reverse Rows of data frame to match structure of the others
ftse <- arrange(ftse, -row_number())
str(ftse)

## load usd gbp currency '''''''''''''''''''''''''''''
usd_gbp <- read.csv("usd_gbp.csv", stringsAsFactors = FALSE)
str(usd_gbp)
setnames(usd_gbp, "DATE", "Date")
setnames(usd_gbp, "RATE", "Rate")

usd_gbp$Date = as.Date(usd_gbp$Date, format = "%Y-%m-%d") 
str(usd_gbp)

## merge data frames 
ftse_cur <- merge(ftse, usd_gbp, all=TRUE)

## create column for ftse in Gbp
ftse_cur$ftse_close_in_usd <- ftse_cur$Close.Price / ftse_cur$RATE

ftse_cur <- arrange(ftse_cur, -row_number())
setnames(ftse_cur, "Close.Price", "ftse_close_in_gbp")

str(ftse_cur)

## drop selected columns
drops_ftse <- c("Open.Price", "High.Price", "Low.Price", "Volume", 
               "RATE")
ftse_cur <- ftse_cur[ , !(names(ftse_cur) %in% drops_ftse)]

# remove rows with missing values
ftse_cur <- na.omit(ftse_cur)


## join dataframes

dj_snp <- merge(dj, snp, all = TRUE)
dj_snp_g <- merge(dj_snp, gold, all = TRUE)
dj_snp_g_n <- merge(dj_snp_g, nasdaq, all=TRUE)
dj_snp_g_n_d <- merge(dj_snp_g_n, dax_cur, all=TRUE)
