library(dplyr)
library(lubridate)

mData = tbl_df(read.csv("household_power_consumption.txt", sep=';', na.strings="?", stringsAsFactors=F, comment.char="", quote='\"'))
mData = filter(mData, Date == "1/2/2007" | Date == "2/2/2007")

nData = select(mutate(mData, DateTime = dmy_hms(paste(Date, Time))), -(Date:Time))

mPlot = hist(nData$Global_active_power, main="Global Active Power", ylab="Frequency", xlab="Global Active Power (kilowatts)", col="Red")

dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
