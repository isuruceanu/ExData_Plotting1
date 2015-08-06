library(data.table)
source("plot1.R") #because copy-past is a bad practice

### plots Global Active Power over the time period
plot2 <- function() {
    file.url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    file.zip <- "household_power_consumption.zip"
    file.data <- "household_power_consumption.txt"
    downloadfile(file.url, file.zip)
    unzipfile(file.zip, file.data)
    
    data <- loaddata(file.data)
    
    plot(data$Global_active_power ~ data$dt, type = "l", 
         ylab = "Global Active Power (killowatts)",
         xlab = ""
         )
    dev.copy(png, "plot2.png", width = 480, height = 480)
    dev.off()
}