# Setting data file path
dfile <- "data/household_power_consumption.txt"

# Saving column names
col_names <- read.table(dfile, nrow = 1, sep =";", stringsAsFactors = FALSE)

# Reading data covering the period from 2007-02-01 to 2007-02-02
data <- read.table(dfile, sep =";", header = FALSE, na.strings = "?",
                   skip = 66000, nrow = 4000,
                   col.names = col_names,
                   stringsAsFactors = FALSE
)

# Subsetting the precise date range
data <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007",]

# Adding datetime column
Sys.setlocale("LC_TIME", "English")
data <- transform(data, datetime = strptime(paste(Date, Time),
                                            "%d/%m/%Y %H:%M:%S"))

# Plotting

png(filename = "plot4.png", ) # width = 480, height = 480
par(mfcol = c(2, 2))

# Plot 1
with(data, plot(datetime, Global_active_power,
                xlab = "",
                ylab = "Global Active Power",
                type = "l"))

# Plot 2
with(data, plot(datetime,  Sub_metering_1,
                xlab = "",
                ylab = "Energy sub metering",
                type = "l"))
with(data, lines(datetime,  Sub_metering_2, col = "red"))
with(data, lines(datetime,  Sub_metering_3, col = "blue"))
legend("topright",
       lty = 1,
       bty = "n",
       col = c("black", "blue", "red"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Plot 3
with(data, plot(datetime, Voltage, type = "l"))
# Plot 4
with(data, plot(datetime, Global_reactive_power, type = "l"))
dev.off()
Sys.setlocale("LC_TIME", "")
