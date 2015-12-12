# Read the data
colClasses = rep("character", 9) 
HPC <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", colClasses = colClasses)

# Extract correct columns and rows
dim
HPC <- HPC[which(HPC$Date == "1/2/2007" | HPC$Date == "2/2/2007"), ]
dim(HPC)

# Convert to correct format
head(HPC)
HPC$datetime <- strptime(paste(HPC$Date, HPC$Time),format="%d/%m/%Y %T")
HPC$Date <- NULL
HPC$Time <- NULL
head(HPC)
datetimecol <- grep("datetime", colnames(HPC))
length(which(HPC[,-datetimecol] == "?"))
HPC[-datetimecol] <- lapply(HPC[-datetimecol], as.numeric)
head(HPC)

# Create the plots
png(filename="plot4.png")
par(mfrow=c(2,2)) # Important that par() is called AFTER launching the graphics device

plot(HPC$datetime, HPC$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

plot(HPC$datetime, HPC$Voltage, type="l", xlab="datetime", ylab="Voltage")

colors <- c("black", "red", "blue")
subnames <- colnames(HPC[grep("Sub", colnames(HPC))])
plot(HPC$datetime, HPC$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
with(HPC$datetime, lines(HPC$datetime, HPC$Sub_metering_2, col="red"))
with(HPC$datetime, lines(HPC$datetime, HPC$Sub_metering_3, col="blue"))
legend("topright", lty=c(1,1,1), col=colors,legend=subnames, bty="n")

plot(HPC$datetime, HPC$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()
