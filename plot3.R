filename <- "household_power_consumption.txt"

electric_data <- read.table(filename, skip = 1, sep=";", na.strings = "?",
                            colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),
                            col.names = c("Date","Time","Global_active_power","Global_reactive_power",
                                          "Voltage","Global_intensity","Sub_metering_1",
                                          "Sub_metering_2","Sub_metering_3"))

electric_data$DateTime <- strptime(paste(electric_data$Date, electric_data$Time),"%d/%m/%Y %H:%M:%S")

electric_data_subset<-subset(electric_data, Date == "1/2/2007"|Date=="2/2/2007")
electric_data_subset$DateTime <- strptime(paste(electric_data_subset$Date, electric_data_subset$Time, sep=" "),format="%e/%m/%Y %X")

# Plot 3
png(filename = "plot3.png")
plot(electric_data_subset$DateTime,electric_data_subset$Sub_metering_1,type="l",
     ylab="Energy sub metering")
points(electric_data_subset$DateTime,electric_data_subset$Sub_metering_2,type="l", col="red" )
points(electric_data_subset$DateTime,electric_data_subset$Sub_metering_3,type="l", col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"),lty=par("lty"))
dev.off()