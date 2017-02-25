setwd("~/GitHub/ExData_Plotting1")
library(readr)

dfCallback <- function(x, pos) { 
	d = as.Date(x$Date, '%d/%m/%Y')
	subset(x, d == '2007-02-01' | d == '2007-02-02') 
}
chunk3 = read_csv2_chunked("household_power_consumption.txt", 
			   callback=DataFrameCallback$new(dfCallback), 
			   col_names = TRUE, na = c("?"),
			   chunk_size =100000)
chunk3$DateTime <- as.POSIXct(strptime(chunk3$Date, '%d/%m/%Y'), tz="PST8PDT") + chunk3$Time
chunk3$Sub_metering_1 <- as.numeric(chunk3$Sub_metering_1)
chunk3$Sub_metering_2 <- as.numeric(chunk3$Sub_metering_2)
chunk3$Sub_metering_3 <- as.numeric(chunk3$Sub_metering_3)


png(file="plot3.png", height=480, width=480)
yl <- c(min(chunk3$Sub_metering_1),max(chunk3$Sub_metering_1))
with (chunk3,
    plot(x=DateTime, y=na.exclude(Sub_metering_1), xlab=NA,
         ylab="Energy sub metering", ylim=yl,
         col="black", typ="l"))
par(new=T)
with (chunk3,
      plot(x=DateTime, y=na.exclude(Sub_metering_2), axes=F, ylab=NA,
           ylim=yl, xlab=NA,    col="red", typ="l"))
par(new=T)
with (chunk3,
      plot(x=DateTime, y=na.exclude(Sub_metering_3), axes=F, ylab=NA,
           ylim=yl, xlab=NA,    col="blue", typ="l"))
legend("topright",
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1,1), col=c("black", "red", "blue"))

dev.off()
