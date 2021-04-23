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

# plot line chart to plot2.png
png("plot2.png", width = 480, height = 480)

plot(data$dateTime, data$Global_active_power, type="n", xlab = "", ylab = "Global Active Power (kilowatts)")
lines(data$dateTime, data$Global_active_power)

dev.off()

