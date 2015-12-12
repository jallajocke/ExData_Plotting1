# Read the data
colClasses = rep("character", 9) 
HPC <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", colClasses = colClasses)

# Extract correct columns and rows
dim
cols <- c(1,2,7,8,9)
HPC <- HPC[which(HPC$Date == "1/2/2007" | HPC$Date == "2/2/2007"), cols]
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

# Create the plot
par(mfrow=c(1,1))
colors <- c("black", "red", "blue")
subnames <- colnames(HPC[grep("Sub", colnames(HPC))])
png(filename="plot3.png")
with(HPC, plot(HPC$datetime, HPC$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
with(HPC$datetime, lines(HPC$datetime, HPC$Sub_metering_2, col="red"))
with(HPC$datetime, lines(HPC$datetime, HPC$Sub_metering_3, col="blue"))
legend("topright", pch=1, col=colors,legend=subnames)
dev.off()
