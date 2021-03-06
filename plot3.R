## Generates a plot with timestamp on x-axis and sub metering levels on y-axis and saves it plot3.png

plot3 <- function(file) {
  power <- read.table(file, header=T, sep=";")
  power$Date <- as.Date(power$Date, format="%d/%m/%Y")
  df <- power[(power$Date=="2007-02-01") | (power$Date=="2007-02-02"),]
  
  df$Global_active_power <- as.numeric(as.character(df$Global_active_power))
  df <- transform(df, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
  
  plot(df$timestamp, df$Sub_metering_1, type="l", col="black",
       xlab="", ylab="Energy sub metering")
  lines(df$timestamp, df$Sub_metering_2, col="red")
  lines(df$timestamp, df$Sub_metering_3, col="blue")
  legend("topright",
         col=c("black", "red", "blue"),
         c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
         lty=1,
         box.lwd=0)
  
  dev.copy(png, file="plot3.png", width=480, height=480)
  dev.off()
  cat("plot3.png has been saved in", getwd())
}