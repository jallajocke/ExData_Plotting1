# Read the data
colClasses = rep("character", 9) 
HPC <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", colClasses = colClasses)

# Extract correct columns and rows
dim(HPC)
HPC <- HPC[which(HPC$Date == "1/2/2007" | HPC$Date == "2/2/2007"), 1:3]
dim(HPC)

# Convert to correct format
head(HPC)
HPC$datetime <- strptime(paste(HPC$Date, HPC$Time),format="%d/%m/%Y %T")
HPC$Date <- NULL
HPC$Time <- NULL
head(HPC)
length(which(HPC$Global_active_power == "?"))
HPC$Global_active_power <- as.numeric(HPC$Global_active_power)

# Create the plot
png(filename="plot2.png")
par(mfrow=c(1,1))
plot(HPC$datetime, HPC$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
