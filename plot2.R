setwd("~/GitHub/ExData_Plotting1")
library(readr)

dfCallback <- function(x, pos) { 
	d = as.Date(x$Date, '%d/%m/%Y')
	subset(x, d == '2007-02-01' | d == '2007-02-02') 
}
chunk2 = read_csv2_chunked("household_power_consumption.txt", 
			   callback=DataFrameCallback$new(dfCallback), 
			   col_names = TRUE, na = c("?"),
			   chunk_size =100000)
chunk2$DateTime <- as.POSIXct(strptime(chunk2$Date, '%d/%m/%Y'), tz="PST8PDT") + chunk2$Time

png(file="plot2.png", height=480, width=480)
chunk2$Global_active_power <- as.numeric(chunk2$Global_active_power)
plot(x=chunk2$DateTime, y=na.exclude(chunk2$Global_active_power), xlab="",
     ylab="Global Active Power (kilowatts)", 
     col="black", typ="l")
dev.off()
