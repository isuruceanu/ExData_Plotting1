library(data.table)
### main function for generating first plot.
### it will:
###   1. download the data source file if necesary
###   2. load necesary subset of data
###   3. build the plot1
###   4. save plot sa PNG into plot1.png file 
plot1 <- function(){
    file.url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    file.zip <- "household_power_consumption.zip"
    file.data <- "household_power_consumption.txt"
    downloadfile(file.url, file.zip)
    unzipfile(file.zip, file.data)
    
    data <- loaddata(file.data)
    
    hist(data$Global_active_power, main = "Global Active Power", 
         xlab = "Global Active Power (killowatts)", 
         ylab = "Frequency", col = "red")
    
    dev.copy(png, "plot1.png", width = 480, height = 480)
    dev.off()
}


### downloads file from inet with URL: file.url and save localy into file.name
downloadfile <- function(file.url, file.name) {
    if (!file.exists(file.name)){
        download.file(file.url, file.name)
        downloadeddate <- date()
        downloadeddate
    }
}

### unzip file
unzipfile <- function(file.zip, file.data) {
    if (!file.exists(file.data))
    {
        message(paste("Unziping", file.zip, "to", file.data, "..."))
        unzip(file.zip, files = c(file.data))
        
    }
}




### load specific data from file.zipname
loaddata <- function(file.name) {
    if (!file.exists(file.name))
        stop(paste("file: ", file.name, " does not exists"))
    
    #I use fread function to read all data set in memory as this is the fastest way 
    # to read it. Moden computer has enouth memory to load 143.1 Mb
    
    colTypes <- rep("character", 9)
    
    DT <- fread(file.name, sep = ";", na.strings = "?", header = T, colClasses = colTypes)
    message(paste("loaded", format(object.size(DT), units="MB")))
    data <- DT[DT$Date == "1/2/2007" | DT$Date == '2/2/2007']
    
    data[, dt := as.POSIXct(strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S"))]
    
    data$Global_active_power <- as.numeric(data$Global_active_power)
    data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
    data$Global_intensity <- as.numeric(data$Global_intensity)
    data$Voltage <- as.numeric(data$Voltage)
    data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
    data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
    data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)
    remove(DT) #clear the memory
    data
    
}