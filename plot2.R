# creates a png image of a plot of global active power for Feb 1st-2nd, 2007
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
                power$Date_and_Time >=  strptime("1/02/2007 00:00:00", "%d/%m/%Y %T")
                & power$Date_and_Time < strptime("3/2/2007 00:00:00", "%d/%m/%Y %T"),
                select = c("Global_active_power", "Date_and_Time"))
  
  # launch png graphics device
  png("plot2.png")
  
  # plot active power over time
  plot(rel$Date_and_Time, rel$Global_active_power,
       ylab = "Global Active Power (kilowatts)", xlab = "", type = "l")
  
  # close png device
  dev.off()
}