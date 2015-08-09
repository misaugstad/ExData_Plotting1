make.plots <- function(){
  
  power <- read.table("household_power_consumption.txt",
                      header = TRUE,
                      sep = ";",
                      as.is = TRUE,
                      comment.char = "")
  
  power$Date_and_Time <- strptime(paste(power$Date, power$Time, sep = " "),
                                  "%d/%m/%Y %T")
  
  rel <- subset(power,
                power$Date_and_Time >=  strptime("1/02/2007 00:00:00", "%d/%m/%Y %T")
                & power$Date_and_Time < strptime("3/2/2007 00:00:00", "%d/%m/%Y %T"))
  
  png("plot4.png")
  
  par(mfrow = c(2,2))
  
  # active power graph
  plot(rel$Date_and_Time, rel$Global_active_power,
       ylab = "Global Active Power (kilowatts)", xlab = "", type = "l")
  
  # voltage graph
  plot(rel$Date_and_Time, rel$Voltage,
       ylab = "Voltage", xlab = "datetime", type = "l")
  
  # Metering graph
  plot(rel$Date_and_Time, rel$Sub_metering_1, type = "l", col = "black",
       xlab = "", ylab = "Energy sub meeting")
  points(rel$Date_and_Time, rel$Sub_metering_2, type = "l", col = "red")
  points(rel$Date_and_Time, rel$Sub_metering_3, type = "l", col = "blue")
  
  legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
         col = c("black", "red", "blue"), lwd = 2, cex = 0.75, bty = "n")
  
  # reactive power graph
  plot(rel$Date_and_Time, rel$Global_reactive_power,
       xlab = "datetime", type = "l")
  
  dev.off()
  
}