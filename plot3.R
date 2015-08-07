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
    
    
    llbls<-c('Sub_metering_1','Sub_metering_2','Sub_metering_3')
    lncol<-c('black','red','blue')
    
    par(mar = c(2, 2, 2, 2))
    par(mfrow = c(1,1))
    
    plot(data$dt,data$Sub_metering_1, type = "l",
                    ylab = "Energy sub metering", col=lncol[1], xlab = "")
    lines(data$dt,data$Sub_metering_2, col = lncol[2])
    
    lines(data$dt,data$Sub_metering_3, col = lncol[3])
     
    #I do not way but the legend is drawen in wrong positions and strange params
    #tryed to reset par but no luck.
    legend("topright",col=lncol, lty = "solid", legend=llbls)
    
    dev.copy(png, "plot3.png", width = 480, height = 480)
    dev.off()
}