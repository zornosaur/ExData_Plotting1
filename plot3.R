library(dplyr)
library(lubridate)

#Read in data and extract pertinent dates. Also convert dates from text to date format
mData = tbl_df(read.csv("household_power_consumption.txt", sep=';', na.strings="?", stringsAsFactors=F, comment.char="", quote='\"'))
mData = filter(mData, Date == "1/2/2007" | Date == "2/2/2007")

nData = select(mutate(mData, DateTime = dmy_hms(paste(Date, Time))), -(Date:Time))

#plot
plot(data = nData, Sub_metering_1~DateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
  lines(data = nData, Sub_metering_2~DateTime,col='Red')
  lines(data = nData, Sub_metering_3~DateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, legend=colnames(nData)[5:7])

#save
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()