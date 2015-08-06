library(data.table)
source("plot1.R") #because copy-paste is bad practice

#Plots Global Active Power, Voltage, Energy sub metering and Global_reactive_power over
# the time period
plot4 <- function() {
    file.url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    file.zip <- "household_power_consumption.zip"
    file.data <- "household_power_consumption.txt"
    downloadfile(file.url, file.zip)
    unzipfile(file.zip, file.data)
    
    data <- loaddata(file.data)
    
    par(mfrow=c(2,2))
    
    with(data, {
        
        plot(Global_active_power ~ dt, type = "l", 
             ylab = "Global Active Power (killowatts)",
             xlab = "")
        plot(Voltage~dt, type = "l", ylab = "Voltage", xlab = "")
        
        plot(Sub_metering_1~dt, type = "l",
             ylab = "Energy sub metering",
             xlab = "")
        lines(Sub_metering_2~dt, col = "Red")
        lines(Sub_metering_3~dt, col = "Blue")
        plot(Global_reactive_power~dt, xlab = "")
    })
    
    dev.copy(png, "plot4.png", width = 480, height = 480)
    dev.off()
}