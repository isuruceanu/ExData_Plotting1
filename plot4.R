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
    par(mar = c(4, 4, 2, 4))
    par(mfrow=c(2,2))
    
    with(data, {
        
        plot(Global_active_power ~ dt, type = "l", 
             ylab = "Global Active Power",
             xlab = "")
        plot(Voltage~dt, type = "l", ylab = "Voltage", xlab = "datetime")
        
        plot(Sub_metering_1~dt, type = "l",
             ylab = "Energy sub metering",
             xlab = "")
        lines(Sub_metering_2~dt, col = "red")
        lines(Sub_metering_3~dt, col = "blue")
        
        #only with recordGraphics was able to draw a nice legend
        # see. : https://class.coursera.org/exdata-031/forum/thread?thread_id=58
        recordGraphics(legend('topright'
                              ,c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
                              , lty=1, bty="n"
                              , col=c('black', 'red', 'blue'),cex=0.8)
                        ,list()
                        , getNamespace("graphics")
                       )
        plot(Global_reactive_power~dt, xlab = "datetime", type = "l")
    })
    
    dev.copy(png, "plot4.png", width = 480, height = 480)
    dev.off()
}