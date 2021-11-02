'
Author: Madeline Melichar
University of Arizona
Date: November 02, 2021
'

# Lab 2: R function and visualization

# Design a R function that takes two periods as parameters, 
# for instance, "2019-01" and "2020-01". Using boxplot, plot 
# the distributions of the rain amounts in the two periods 
# (only including those of good quality readings) and show the
# statistical difference between the two data sets. The function 
# should return the difference in average rain between the two 
# periods and conclude whether the difference is statistically
# significant at the 0.05 significance level (p-value<0.05). 
# Submit your R scripts in a text file and write a report summarizing 
# the function design with an example results (screenshot of results is acceptable).
# Bonus: 
# 1) Use multiple functions to work together
# 2) Use the same sets of gauges for a fair comparison. 

library(dplyr)
library(tidyr)

total_rain <- function(time_period_1,time_period_2,gauge_type){
  # Read in data
  data <- read.delim("tucson_rain.txt", header=T, sep="\t")
  
  # Only good quality data readings
  data_good <- data[data$quality=="Good" & data$gaugeType==gauge_type,]
  
  # Seperate readingDate into Year Month Day
  data_sep <- data_good %>% separate(readingDate,c("year", "month", "day"),"-",remove=FALSE)
  
  # Filter only valid dates in time_period
  data_1 <- data_sep[grep(paste("^", paste0(time_period_1),sep = ""),data_sep$readingDate),]
  data_2 <- data_sep[grep(paste("^", paste0(time_period_2),sep = ""),data_sep$readingDate),]
  
  # Total amount of rain from time_period
  rain_sum1 <- sum(as.integer(data_1$rainAmount))
  rain_sum2 <- sum(as.integer(data_2$rainAmount))
  diff <- rain_sum2-rain_sum1
  
  # Boxplot
  par(mfrow = c(1, 2))
  boxplot(as.numeric(data_1$rainAmount),xlab=time_period_1, ylab="rain distribution")
  boxplot(as.numeric(data_2$rainAmount),xlab=time_period_2, ylab="rain distribution")
  
  # Combine data_1 and data_2
 # data_full<-rbind(data_1,data_2)
  
  # Comparison
  wt <- wilcox.test(as.numeric(data_1$rainAmount),as.numeric(data_2$rainAmount),paired=F)
  print(wt)
  
  return(list(diff,wt))
}

test <- total_rain("2019-01","2020-01","TruChek")
