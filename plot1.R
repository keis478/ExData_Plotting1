## download and unzip the file
if(!require(downloader)){
  install.packages("downloader")
  library(downloader)
}

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destfile <- "~/Documents/R/Exploratory Data Analysis/hpc"
download.file(url, destfile = destfile, method = "auto")
unzip(destfile, exdir = "~/Documents/R/Exploratory Data Analysis")

## read the file 
hpc <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)

## subset required dates
if(!require(dplyr)){
  install.packages("dplyr")
  library(dplyr)
}
if (!require(lubridate)) {
  install.packages("lubridate")
  library(lubridate)
}

## Converting dates and times into time format
hpc$Date <- as.Date(hpc$Date, format = "%d/%m/%Y")
hpc <- hpc %>%
  mutate(Time = hms(Time))

# Filtering the data for the specific dates
hpc_subset <- hpc %>%
  filter(Date == "2007-02-01" | Date == "2007-02-02")

## Plot1
png("plot1.png", width = 480, height = 480)
hist(as.numeric(hpc_subset$Global_active_power), col = "red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
dev.off()