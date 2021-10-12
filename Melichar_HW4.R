'
Author: Madeline Melichar
University of Arizona
Date: October 11, 2021
'

library(dplyr)
library(tidyr)
library(data.table)

# Read in data
data <- read.delim("tucson_rain.txt", header=T, sep="\t")
# Filter only valid dates
data_dates <- data[grep("^20",data$readingDate),]
# Seperate readingDate into Year Month Day
data_sep <- data_dates %>% separate(readingDate,c("year", "month", "day"),"-")
# Only good quality data readings
data_good <- data_sep[data_sep$quality=="Good",]

# Conver data to data table
dt <- data.table(data_good)
# Monthly summary as data table
rain_summary <- dt[, list(rain_avg=mean(as.integer(rainAmount)),rain_sum=sum(as.integer(rainAmount))), by=list(year, month)]

# Data for 2019 and 2020
out <- rain_summary[rain_summary$year==c("2019","2020")]

# Difference in rainfall n-1
rain_delta <-c()
for (yr in c(2019,2020)){
  dt_1 <- rain_summary[rain_summary$year==yr,]
  for (m in unique(dt_1$month)) {
    dt_2<-dt_1[dt_1$month==m,]
    dif <- dt_2$rain_sum-rain_summary[rain_summary$year==(yr-1) & rain_summary$month==m,rain_sum]
    rain_delta <- c(rain_delta,dif)
  }
}
out_dt <-cbind(out,rain_delta)

# Final data table
ans <- rbind(rain_summary[rain_summary$year=="2018",],out_dt,fill=TRUE)
