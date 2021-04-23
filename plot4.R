# download data
# 

dataFile <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipFileName <- "data/exdata_data_household_power_consumption.zip"
dataFileName <- "data/household_power_consumption.txt"

if (!dir.exists("data")) {
        dir.create("data")
}
download.file(dataFile, destfile = zipFileName, method = "curl")

unzip(zipFileName, exdir = "data", overwrite = TRUE)

# Read only the rows for 2007-02-01 to 2007-02-02
heading <- read.table(dataFileName, nrow = 1, header = FALSE, sep = ";")
data <- read.table(dataFileName, skip = 66637, nrow = 69517-66637, header = FALSE, sep = ";")
names(data) <- heading[1,]

# Add a date/time column
data$dateTime <- strptime(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")

# plot line charts to plot4.png
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))

# plot 1
plot(data$dateTime, data$Global_active_power, type="n", xlab = "", ylab = "Global Active Power (kilowatts)")
lines(data$dateTime, data$Global_active_power)

# plot 2
plot(data$dateTime, data$Voltage, type="n", xlab = "datetime", ylab = "Voltage")
lines(data$dateTime, data$Voltage)

# plot 3
xrange <- range(data$dateTime)
yrange <- range(c(data$Sub_metering_1, data$Sub_metering_2, data$Sub_metering_3))

plot(xrange, yrange, type = "n", xlab = "", ylab = "Energy sub metering")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lwd = c(1, 1, 1), col = c("black", "red", "blue"))

lines(data$dateTime, data$Sub_metering_1, col="black")
lines(data$dateTime, data$Sub_metering_2, col="red")
lines(data$dateTime, data$Sub_metering_3, col="blue")

# plot 4
plot(data$dateTime, data$Global_reactive_power, type="n", xlab = "datetime", ylab = "Global_reactive_power")
lines(data$dateTime, data$Global_reactive_power)

dev.off()

