filename <- "household_power_consumption.txt"

electric_data <- read.table(filename, skip = 1, sep=";", na.strings = "?",
                            colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),
                            col.names = c("Date","Time","Global_active_power","Global_reactive_power",
                                          "Voltage","Global_intensity","Sub_metering_1",
                                          "Sub_metering_2","Sub_metering_3"))

electric_data$DateTime <- strptime(paste(electric_data$Date, electric_data$Time),"%d/%m/%Y %H:%M:%S")

electric_data_subset<-subset(electric_data, Date == "1/2/2007"|Date=="2/2/2007")
electric_data_subset$DateTime <- strptime(paste(electric_data_subset$Date, electric_data_subset$Time, sep=" "),format="%e/%m/%Y %X")

# Plot 4
png(filename = "plot4.png")
par(mfrow=c(2,2))

# First plot
with(electric_data_subset, {
        # First plot
        plot(DateTime,Global_active_power,pch=".",
             type="l", xlab="",ylab = "Global Active Power")
        
        # Second plot 
        plot(DateTime,Voltage,pch=".",
             type="l", xlab="datetime", ylab = "Voltage")
        
        # Third plot
        plot(DateTime,Sub_metering_1,type="l", xlab="",
             ylab="Energy sub metering")
        points(DateTime,Sub_metering_2,type="l", col="red" )
        points(DateTime,Sub_metering_3,type="l", col="blue")
        legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"),lty=par("lty"),bty = "n")
        
        # Fourth plot
        plot(DateTime,Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")
})
dev.off()