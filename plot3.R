# creates a png image of a plot of three sub meterings over Feb 1st-2nd, 2007
make.plot <- function(){
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
                                                 "%d/%m/%Y %T"),
                select = c("Sub_metering_1", "Sub_metering_2",
                           "Sub_metering_3", "Date_and_Time"))
  
  # launch png graphics device
  png("plot3.png")
  
  # plot the three sub meterings over time
  plot(rel$Date_and_Time, rel$Sub_metering_1, type = "l", col = "black",
       xlab = "", ylab = "Energy sub meeting")
  points(rel$Date_and_Time, rel$Sub_metering_2, type = "l", col = "red")
  points(rel$Date_and_Time, rel$Sub_metering_3, type = "l", col = "blue")
  # put legend in top right corner
  legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
         col = c("black", "red", "blue"), lwd = 2, cex = 0.75)
  
  # close png device
  dev.off()
}