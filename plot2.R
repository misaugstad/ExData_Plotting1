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
                select = c("Global_active_power", "Date_and_Time"))
  png("plot2.png")
  
  plot(rel$Date_and_Time, rel$Global_active_power,
       ylab = "Global Active Power (kilowatts)", xlab = "", type = "l")
  
  dev.off()
  
}