make.plot <- function(){
  
  power <- read.table("household_power_consumption.txt",
                      header = TRUE,
                      sep = ";",
                      as.is = TRUE,
                      comment.char = "")
  
  power$Date_and_Time <- strptime(paste(power$Date, power$Time, sep = " "),
                                  "%d/%m/%Y %T")
  
  rel <- subset(power,
                power$Date_and_Time >=  strptime("1/02/2007 00:00:00", "%d/%m/%Y %T")
                & power$Date_and_Time < strptime("3/2/2007 00:00:00", "%d/%m/%Y %T"),
                select = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3", "Date_and_Time"))
  
  png("plot3.png")
  
  plot(rel$Date_and_Time, rel$Sub_metering_1, type = "l", col = "black",
       xlab = "", ylab = "Energy sub meeting")
  points(rel$Date_and_Time, rel$Sub_metering_2, type = "l", col = "red")
  points(rel$Date_and_Time, rel$Sub_metering_3, type = "l", col = "blue")
  
  legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
         col = c("black", "red", "blue"), lwd = 2, cex = 0.75)
  
  dev.off()
  
}