setwd("~/GitHub/ExData_Plotting1")
library(readr)

dfCallback <- function(x, pos) { 
	d = as.Date(x$Date, '%d/%m/%Y')
	subset(x, d == '2007-02-01' | d == '2007-02-02') 
}
chunk4 = read_csv2_chunked("household_power_consumption.txt", 
			   callback=DataFrameCallback$new(dfCallback), 
			   col_names = TRUE, na = c("?"),
			   chunk_size =100000)
chunk4$DateTime <- as.POSIXct(strptime(chunk4$Date, '%d/%m/%Y'), tz="PST8PDT") + chunk4$Time

chunk4$Global_active_power <- as.numeric(chunk4$Global_active_power)
chunk4$Sub_metering_1 <- as.numeric(chunk4$Sub_metering_1)
chunk4$Sub_metering_2 <- as.numeric(chunk4$Sub_metering_2)
chunk4$Sub_metering_3 <- as.numeric(chunk4$Sub_metering_3)
chunk4$Voltage <- as.numeric(chunk4$Voltage)
chunk4$Global_reactive_power <- as.numeric(chunk4$Global_reactive_power)


png(file="plot4.png", height=480, width=480)
par(mfrow=c(2,2))

# Top Left plot 

plot(x=chunk4$DateTime, y=na.exclude(chunk4$Global_active_power), xlab="",
     ylab="Global Active Power (kilowatts)", 
     col="black", typ="l")

#top Right plot

plot(x=chunk4$DateTime, y=na.exclude(chunk4$Voltage/1000), 
     xlab="datetime",
     ylab="Voltage", 
     col="black", typ="l")

# bottom left Plot
yl <- c(min(chunk4$Sub_metering_1),max(chunk4$Sub_metering_1))
with (chunk4,
    plot(x=DateTime, y=na.exclude(Sub_metering_1), xlab=NA,
         ylab="Energy sub metering", ylim=yl,
         col="black", typ="l"))
par(new=T)
with (chunk4,
      plot(x=DateTime, y=na.exclude(Sub_metering_2), axes=F, ylab=NA,
           ylim=yl, xlab=NA,    col="red", typ="l"))
par(new=T)
with (chunk4,
      plot(x=DateTime, y=na.exclude(Sub_metering_3), axes=F, ylab=NA,
           ylim=yl, xlab=NA,    col="blue", typ="l"))
legend("topright",
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1,1), col=c("black", "red", "blue"), bty="n")


#bottom right plot

plot(x=chunk4$DateTime, y=na.exclude(chunk4$Global_reactive_power), 
     xlab="datetime",
     ylab="Global_reactive_power", 
     col="black", typ="l")

dev.off()

