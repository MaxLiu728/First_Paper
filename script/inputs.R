#### Preamble ####
# Purpose: clean the data of Marriage License Statistics Data
# Author: Renjing Liu
# Date: 28 January 2021
# Contact: renjing.liu@mail.utoronto.ca
# License: MIT
# Todos:
# - Need to have downloaded the data and saved it to inputs
# - Need to remove ID column
# - Need to separate time period column
# - Need to change the class of variable

#### Workspace setup ####
library(tidyverse)
library(ggplot2)
library(opendatatoronto)
# Read in the raw data.
raw_data <- search_packages("Marriage Licence") %>%
  opendatatoronto::list_package_resources()%>%
  opendatatoronto::get_resource()
# Select variables
raw_data<- raw_data[,2:4]
# Separate time period column
## Define the function to separate the year and month in the time period column
raw_data<- tidyr::separate(raw_data, col= TIME_PERIOD, into= c('year','month'),remove= TRUE)

# change the class of variables
raw_data$year<- as.factor(raw_data$year)
## class(raw_data$year)
raw_data$CIVIC_CENTRE<-  as.factor(raw_data$CIVIC_CENTRE)
raw_data$month<- as.factor(raw_data$month)
## Check the baisc information of the dataframe
str(raw_data)

# Save it to input data
readr::write_csv(raw_data, "inputs/raw_data.csv")

