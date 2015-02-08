library(dplyr)
library(lubridate)

mData = tbl_df(read.csv("household_power_consumption.txt", sep=';', na.strings="?", stringsAsFactors=F, comment.char="", quote='\"'))
mData = filter(mData, Date == "1/2/2007" | Date == "2/2/2007")

nData = select(mutate(mData, DateTime = dmy_hms(paste(Date, Time))), -(Date:Time))

par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

plot(data = nData, Global_active_power ~ DateTime, type="l", ylab="Global Active Power", xlab="")

plot(data = nData, Voltage ~ DateTime, type="l", ylab="Voltage", xlab="")

plot(data = nData, Sub_metering_1 ~ DateTime, type="l", ylab="Global Active Power", xlab="")

lines(data = nData, Sub_metering_2~DateTime,col='Red')
lines(data = nData, Sub_metering_3~DateTime,col='Blue')
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n", legend=colnames(nData)[5:7])

plot(data = nData, Global_reactive_power~DateTime, type="l", ylab="Global Rective Power",xlab="", ylim = c(0,0.5))

dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()