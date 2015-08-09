# creates a png image of the frequency histogram of global active power for Feb
# 1st and 2nd, 2007 in a single household
make.hist <- function(){
  # read in table data
  power <- read.table("household_power_consumption.txt",
                      header = TRUE,
                      sep = ";",
                      as.is = TRUE, # gives character instead of factor
                      comment.char = "") # don't look for comments, speeds it up

  # subset for the data on Feb 1st and 2nd, 2007
  rel <- subset(power,
                strptime(power$Date, "%d/%m/%Y") >=  strptime("1/2/2007", "%d/%m/%Y")
                & strptime(power$Date, "%d/%m/%Y") < strptime("3/2/2007", "%d/%m/%Y"),
                select = "Global_active_power") # only need active power in hist

  # launch png graphics device
  png("plot1.png")
  
  # put frequency of global active power in histogram
  hist(as.numeric(rel[,1]), breaks = 12, col = "red", xlab = "Global Active Power (kilowatts)", 
       main = "Global Active Power")
  
  # close png device
  dev.off()
}