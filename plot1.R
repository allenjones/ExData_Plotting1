library(lubridate)

loadData <- function () {
    # Download and unzip the data files.
    if (!file.exists("household_power_consumption.zip")) {
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_power_consumption.zip")
    }
    if (!file.exists("household_power_consumption.txt")) {
        unzip("household_power_consumption.zip")
    }
    
    pc <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", stringsAsFactors = FALSE)
    pc <- pc[ which(pc$Date == "1/2/2007" | pc$Date == "2/2/2007"),]
    pc$dateTime <- dmy_hms(paste(pc$Date, pc$Time))
    return(pc)
}

power_cons <- loadData()
png("plot1.png")
hist(power_cons$Global_active_power, col="red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()