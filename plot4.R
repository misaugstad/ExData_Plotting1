# creates a png image of four plots: active power frequency, voltage over time,
# metering over time, and reactive power over time; all over Feb 1st-2nd, 2007
make.plots <- function(){
  # read in table data
  power <- read.table("household_power_consumption.txt",
                      header = TRUE,
                      sep = ";",
                      as.is = TRUE, # gives character instead of factor
                      comment.char = "") # don't look for comments, speeds it up
  
  # add date and time column to power data frame, as POSIXlt
  power$Date_and_Time <- strptime(paste(power$Date, power$Time, sep = " "),
                                  "%d/%m/%Y %T")
  
  # subset for the data on Feb 1st and 2nd, 2007
  rel <- subset(power,
                power$Date_and_Time >=  strptime("1/02/2007 00:00:00",
                                                 "%d/%m/%Y %T")
                & power$Date_and_Time < strptime("3/2/2007 00:00:00",
                                                 "%d/%m/%Y %T"))
  
  # launch png graphics device
  png("plot4.png")
  
  # sets a grid for the four plots
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
  
  # close png device
  dev.off()
  
}