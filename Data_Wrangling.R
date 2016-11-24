## load libraries
library(dplyr)
library(data.table)
## load datasets

dj <- read.csv("dowjones.csv", stringsAsFactors = FALSE) # in usd
gold <- read.csv("gold.csv", stringsAsFactors = FALSE) # in usd
snp <- read.csv("snp.csv", stringsAsFactors = FALSE) # in usd
nasdaq <- read.csv("nasdaq.csv", stringsAsFactors = FALSE) ## in usd
dax <- read.csv("dax.csv", stringsAsFactors = FALSE) ## in euros
ftse <- read.csv("FTSE.csv", stringsAsFactors = FALSE) ## in gbp

identical(dj$Date, snp$Date)

## Euro/USD
eur_usd <- read.csv("eur_us.csv", stringsAsFactors = FALSE)

## load usd gbp currency '''''''''''''''''''''''''''''
usd_gbp <- read.csv("usd_gbp.csv", stringsAsFactors = FALSE)
str(usd_gbp)
setnames(usd_gbp, "DATE", "Date")
setnames(usd_gbp, "RATE", "Rate")

## Data Wrangling

## change to date format

usd_gbp$Date <- as.Date(usd_gbp$Date, format= "%Y-%m-%d")
eur_usd$Date <- as.Date(eur_usd$Date, format= "%Y-%m-%d")
dj$Date <- as.Date(dj$Date, format= "%Y-%m-%d")
snp$Date <- as.Date(snp$Date, format= "%Y-%m-%d")
nasdaq$Date <- as.Date(nasdaq$Date, format= "%Y-%m-%d")
gold$Date <- as.Date(gold$Date, format= "%Y-%m-%d")
dax$Date <- as.Date(dax$Date, format= "%Y-%m-%d")



'''
# Dow Jones Data ---------------------------------------------------------------
'''
#dj$dj_date <- dj$Date
dj$dj_close_usd <- dj$Close

dj_cur <- merge(dj, eur_usd, all=TRUE)
str(dj_cur)

## create column for dj closing rate in euro currency
dj_cur$dj_close_eur <- dj_cur$dj_close_usd * dj_cur$Value

## create column for dj closing rate in gbp currency
dj_cur <- merge(dj_cur, usd_gbp, all=TRUE)

dj_cur$dj_close_gbp <- dj_cur$dj_close_usd * dj_cur$Rate

## drop columns
drops <- c("High", "Low", "Close", "Volume", "Open", "Adjusted.Close",
           "Value", "Rate")
dj_cur <- dj_cur[ , !(names(dj_cur) %in% drops)]

# drop rows with missing values
dj_cur <- na.omit(dj_cur)


'''
# S&P Data -----------------------------------------------------------------
'''

#snp$snp_date <- snp$Date
snp$snp_close_usd <- snp$Close

## merge with eur currency data frame

snp_cur <- merge(snp, eur_usd, all=TRUE)
str(snp_cur)

## create new column for snp in Eur
snp_cur$snp_close_eur <- snp_cur$snp_close_usd *snp_cur$Value

## merge with gbp data frame
snp_cur <- merge(snp_cur, usd_gbp, all=TRUE)

## create new column for snp in gbp
snp_cur$snp_close_gbp <- snp_cur$snp_close_usd * snp_cur$Rate

## drop columns
snp_cur <- snp_cur[ , !(names(snp_cur) %in% drops)]

# drop missing values
snp_cur <- na.omit(snp_cur)


'''
Gold Data -------------------------------------------------------------------
'''

## Gold
setnames(gold, "Value", "gold_close_usd")
str(gold_cur)

##merge with eur_usd
gold_cur <- merge(gold_cur, eur_usd, all=TRUE)

## create column for gold price in eur
gold_cur$gold_close_eur <- gold_cur$gold_close_usd * gold_cur$Value

## merge with usd_gbp
gold_cur <- merge(gold, usd_gbp, all=TRUE)

## create column for gold price in gbp
gold_cur$gold_close_gbp <- gold_cur$gold_close_usd * gold_cur$Rate

## drop columns
drop_gold <- c("Value", "Rate")

gold_cur <- gold_cur[ , !(names(gold_cur) %in% drop_gold)]

## drop missing values
gold_cur <- na.omit(gold_cur)

'''
Nasdaq Data --------------------------------------------------------------------
'''

## Nasdaq

str(nasdaq)
setnames(nasdaq, "Value", "nasdaq_close_usd")

## merge with eur_usd

nasdaq_cur <- merge(nasdaq, eur_usd, all=TRUE)
str(nasdaq_cur)

## create new column for nasdaq in eur
nasdaq_cur$nasdaq_close_eur <- nasdaq_cur$nasdaq_close_usd * nasdaq_cur$Value

## merge with usd_gbp
nasdaq_cur <- merge(nasdaq_cur, usd_gbp, all=TRUE)

## create new column for nasdaq in gbp
nasdaq_cur$nasdaq_close_gbp <- nasdaq_cur$nasdaq_close_usd * nasdaq_cur$Rate

## drop columns
drop_nas <- c("Value", "Rate")

nasdaq_cur <- nasdaq_cur[ , !(names(nasdaq_cur) %in% drop_nas)]

## drop rows with missing values
nasdaq_cur <- na.omit(nasdaq_cur)

'''
Dax Data-----------------------------------------------------------------------
'''
str(dax_cur)
## Merge data frames
dax_cur <- merge(dax, eur_usd, all=TRUE)

## change column name
setnames(dax_cur, "Close", "dax_close_eur")

## Create new Column for Dax adjusted to daily Euro/Dollar Currency Exchange Rate
dax_cur$dax_close_in_usd <- dax_cur$dax_close_eur / dax_cur$Value

## merge with usd_gbp
dax_cur <- merge(dax_cur, usd_gbp, all=TRUE)

## create new column for dax in gbp
dax_cur$dax_close_gbp <- dax_cur$dax_close_in_usd * dax_cur$Rate
str(dax_cur)

## drop columns

drops_dax <- c("Open", "High", "Low", "Volume", 
               "Adjusted.Close", "Value", "Close", "Rate")
dax_cur <- dax_cur[ , !(names(dax_cur) %in% drops_dax)]

# drop rows with missing values
dax_cur <- na.omit(dax_cur)



'''
FTSE Data ----------------------------------------------------------------------
'''
str(ftse)
str(usd_gbp)

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
str(ftse_cur)

## rename column
setnames(ftse, "Close.Price", "ftse_close_gbp")

## merge with usd_gbp
ftse_cur <- merge(ftse, usd_gbp, all=TRUE)

# create column for ftse in usd

ftse_cur$ftse_close_usd <- ftse_cur$ftse_close_gbp / ftse_cur$Rate 

## merge data frames -----------------------------------------------------

ftse_cur <- merge(ftse_cur, eur_usd, all=TRUE)

str(ftse_cur)
str(eur_usd)
str(usd_gbp)

## create column for ftse in eur
ftse_cur$ftse_close_in_eur <- ftse_cur$ftse_close_usd * ftse_cur$Value

## drop selected columns
drops_ftse <- c("Open.Price", "High.Price", "Low.Price", "Volume", 
               "Rate", "Value")
ftse_cur <- ftse_cur[ , !(names(ftse_cur) %in% drops_ftse)]

# remove rows with missing values
ftse_cur <- na.omit(ftse_cur)


## join dataframes

dj_snp <- merge(dj_cur, snp_cur, all = TRUE)
dj_snp_g <- merge(dj_snp, gold_cur, all = TRUE)
dj_snp_g_n <- merge(dj_snp_g, nasdaq_cur, all=TRUE)
dj_snp_g_n_d <- merge(dj_snp_g_n, dax_cur, all=TRUE)
graph_data <- merge(dj_snp_g_n_d, ftse_cur, all=TRUE)

### Checking data for plausibility - one error identified in original dataset
graph_data[62,]

summary(graph_data)

## changing errors manually to NA's
graph_data$snp_close_usd[62] <- NA
graph_data$snp_close_eur[62] <- NA
graph_data$snp_close_gbp[62] <- NA

## save to csv
write.csv(graph_data, 'graph_data.csv', row.names=FALSE)
