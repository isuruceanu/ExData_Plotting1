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
    
    par(mar = c(2, 4, 2, 2))
    par(mfrow = c(1,1))
    
    plot(data$dt,data$Sub_metering_1, type = "l",
                    ylab = "Energy sub metering", col="black", xlab = "")
    lines(data$dt,data$Sub_metering_2, col = "red")
    
    lines(data$dt,data$Sub_metering_3, col = "blue")
     
    #only with recordGraphics was able to draw a nice legend
    # see. : https://class.coursera.org/exdata-031/forum/thread?thread_id=58
    recordGraphics(legend('topright',c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
                          lty=1, 
                          col=c('black', 'red', 'blue'),cex=0.8),list(), 
                            getNamespace("graphics"))
    
    dev.copy(png, "plot3.png", width = 480, height = 480)
    dev.off()
}