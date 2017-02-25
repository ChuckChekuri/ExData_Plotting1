setwd("~/GitHub/ExData_Plotting1")
library(readr)


dfCallback <- function(x, pos) { 
	d = as.Date(x$Date, '%d/%m/%Y')
	subset(x, d == '2007-02-01' | d == '2007-02-02') 
}
chunk1 = read_csv2_chunked("household_power_consumption.txt", 
			   callback=DataFrameCallback$new(dfCallback), 
			   col_names = TRUE, na = c("?"),
			   chunk_size =100000)
chunk1$DateTime <- as.POSIXct(strptime(chunk1$Date, '%d/%m/%Y'), tz="PST8PDT") + chunk1$Time

png(file="plot1.png", height=480, width=480)
hist(as.numeric(chunk1$Global_active_power), 
     xlab="Global Active Power (kilowatts)", 
     main="Global Active Power", col="red")
dev.off()
