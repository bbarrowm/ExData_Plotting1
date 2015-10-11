##Coursera Exploratory Data Analysis
##Project 1
##Plot 3

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
subset$Date <- as.Date(subset$Date, "%d/%m/%Y") ##this converts year to 2020
##convert time from character class to POSIXit
##combine Date and Time variables into one Date_time variable
Date_time <- paste(subset$Date, subset$Time)
##convert Time to POSIXit
subset$Time <- strptime(Date_time, format = "%Y-%m-%d %H:%M:%S")
##remove temporary 'Date_time' variable
rm("Date_time")
class(subset$Time)
subset

##construct base plot 3
with(subset, plot(subset$Time, subset$Sub_metering_1, ylab = "Energy sub metering",
                  xlab = "", type = "l"))
##add line for sub_metering_2
lines(subset$Time, subset$Sub_metering_2, col = c("red"))
##add line for sub_metering_3
lines(subset$Time, subset$Sub_metering_3, col = c("blue"))
##add legend
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("sub_metering_1", "sub_metering_2", "sub_metering_3"))
##copy plot 3 to png
dev.copy(png, file = "plot3.png", width = 650)
##close png
dev.off()