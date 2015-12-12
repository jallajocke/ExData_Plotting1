# Read the data
colClasses = rep("character", 9) 
HPC <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", colClasses = colClasses)

# Extract correct columns and rows
dim(HPC)
GAP <- HPC[which(HPC$Date == "1/2/2007" | HPC$Date == "2/2/2007"), 3]
length(GAP)

# Convert to correct format
length(which(HPC$Global_active_power == "?"))
GAP <- as.numeric(GAP)

# Create the plot
par(mfrow=c(1,1))
png(filename="plot1.png")
hist(GAP, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()
