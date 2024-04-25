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
hpc$DateTime <- paste(hpc$Date, hpc$Time)
hpc$DateTime <- as.POSIXct(hpc$DateTime, format="%Y-%m-%d %H:%M:%S")

# Filtering the data for the specific dates
hpc_subset <- hpc %>%
  filter(Date == "2007-02-01" | Date == "2007-02-02")

## Plot2
if(!require(ggplot2)){
  install.packages("ggplot2")
  library(ggplot2)
}

with(hpc_subset, plot(x = DateTime, 
                      y = Global_active_power, 
                      type = "l",
                      xlab = "",
                      ylab = "Global Active Power (kilowatts)",
                      main = ""))