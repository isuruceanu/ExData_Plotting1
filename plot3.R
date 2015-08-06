library(data.table)
source("plot1.R") #because copy-paste is bad practice

#plots Energy sub metering over the time period
plot3 <- function(){
    file.url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    file.zip <- "household_power_consumption.zip"
    file.data <- "household_power_consumption.txt"
    downloadfile(file.url, file.zip)
    unzipfile(file.zip, file.data)
    
    data <- loaddata(file.data)
    
    plot(data$Sub_metering_1~data$dt, type = "l",
                    ylab = "Energy sub metering",
                    xlab = "")
    lines(data$Sub_metering_2~data$dt, col = "Red")
    
    lines(data$Sub_metering_3~data$dt, col = "Blue")
         
    legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    

    dev.copy(png, "plot3.png", width = 480, height = 480)
    dev.off()
}