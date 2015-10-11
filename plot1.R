##Coursera Exploratory Data Analysis
##Project 1
##Plot 1

##read in data
library(data.table)
power <- fread("household_power_consumption.txt", na.strings = c("?", ""))
str(power)
##convert to tbl_df (easier to read) with dplyr
library(dplyr)
household_power <- tbl_df(power)
household_power
##remove original data table
rm("power")

##subset to dates 02/01/2007 and 02/02/2007
subset <- filter(household_power, Date == "1/2/2007" | Date == "2/2/2007")
subset

##convert date from character class to date class 
subset$Date <- as.Date(subset$Date, "%d/%m/%y")
##convert time from character class to POSIXit
##combine Date and Time variables into one Date_time variable
Date_time <- paste(subset$Date, subset$Time)
date_time <- strptime(Date_time, format = "%Y-%m-%d %H:%M:%S")
##remove temporary 'Date_time' variable
rm("Date_time")
##convert original Time variable to new POSIXit class
subset$Time <- date_time
class(subset$Time)
subset

##construct plot 1
hist(subset$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency", main = "Global Active Power")

##copy plot 1 to png
dev.copy(png, file = "plot1.png")
##close png
dev.off()
