make.hist <- function(){

  power <- read.table("household_power_consumption.txt",
                      header = TRUE,
                      sep = ";",
                      as.is = TRUE,
                      comment.char = "")

  rel <- subset(power,
                strptime(power$Date, "%d/%m/%Y") >=  strptime("1/02/2007", "%d/%m/%Y")
                & strptime(power$Date, "%d/%m/%Y") < strptime("3/2/2007", "%d/%m/%Y"),
                select = "Global_active_power")

  png("plot1.png")
  
  hist(as.numeric(rel[,1]), breaks = 12, col = "red", xlab = "Global Active Power (kilowatts)", 
       main = "Global Active Power")
  
  dev.off()
}