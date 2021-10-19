'
Author: Madeline Melichar
University of Arizona
Date: October 22, 2021
'
# HW 05: R Function
# Design a R function that takes a time period/pattern as a parameter 
# and returns the total amount of rain from good quality readings during
# the time period, for instance,  "2020-01". Submit your R scripts in a 
# text file and example results in a word/text file (screenshot of results is acceptable).

library(dplyr)
library(tidyr)
library(data.table)

total_rain <- function(time_period){
  # Read in data
  data <- read.delim("tucson_rain.txt", header=T, sep="\t")
  # Filter only valid dates in time_period
  data_dates <- data[grep(paste("^", paste0(time_period), sep = ""),data$readingDate),]
  # Only good quality data readings
  data_good <- data_dates[data_dates$quality=="Good",]
  
  # Total amount of rain from time_period
  rain_sum <- sum(as.integer(data_good$rainAmount))
  
  return(print(paste("Total rain amount for",time_period,"is",rain_sum)))
}


