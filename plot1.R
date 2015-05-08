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
png(filename = "plot1.png", ) # width = 480, height = 480
with(data, hist(Global_active_power,
                col = "red",
                main = "Global Active Power",
                xlab = "Global Active Power (kilowatts)"))
dev.off()
Sys.setlocale("LC_TIME", "")
