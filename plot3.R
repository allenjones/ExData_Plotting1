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
png("plot3.png")
xLimit <- range(power_cons$dateTime)
yLimit <- range(power_cons$Sub_metering_1, power_cons$Sub_metering_2, power_cons$Sub_metering_3)
plot(xLimit, yLimit, type="n", xlab = "", ylab = "Energy sub metering")
with(power_cons, lines(dateTime, Sub_metering_1, type = "l", col = "black"))
with(power_cons, lines(dateTime, Sub_metering_2, type = "l", col = "red"))
with(power_cons, lines(dateTime, Sub_metering_3, type = "l", col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty=1)
dev.off()