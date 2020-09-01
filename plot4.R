## Reading data set
## It useful to convert the Date and Time variables to Date/Time classes in R 
## using the strptime() and as.Date() functions.
## Note that in this dataset missing values are coded as ?.
hhpc <- read.table("household_power_consumption.txt",sep = ";",
                   header = TRUE, na.strings = "?", 
                   colClasses = "character")

hhpc$DateTime <- strptime(paste(hhpc$Date, hhpc$Time), "%d/%m/%Y %H:%M:%S")


## We will only be using data from the dates 2007-02-01 and 2007-02-02. 
## One alternative is to read the data from just those dates rather than reading 
## in the entire dataset and subsetting to those dates.
hhpc$Date <- as.Date(hhpc$Date, "%d/%m/%Y")

hhpc <- subset(hhpc, Date>='2007-02-01' & Date<='2007-02-02')

## Convert columns to numeric
hhpc$Global_active_power<-as.numeric(hhpc$Global_active_power)
hhpc$Global_reactive_power<-as.numeric(hhpc$Global_reactive_power)
hhpc$Voltage<-as.numeric(hhpc$Voltage)
hhpc$Global_intensity<-as.numeric(hhpc$Global_intensity)
hhpc$Sub_metering_1<-as.numeric(hhpc$Sub_metering_1)
hhpc$Sub_metering_2<-as.numeric(hhpc$Sub_metering_2)
hhpc$Sub_metering_3<-as.numeric(hhpc$Sub_metering_3)

## We plot four graphics for active power usage, sub metering, voltage 
## and reactive power usage variables.
png(file="plot4.png")

#Layout 2 rows, 2 columns
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

## Global active power usage time series
with(hhpc,plot(DateTime, Global_active_power,type="l", xlab="",
               ylab="Global Active Power"))


## Voltage time series graphic
with(hhpc,plot(DateTime,Voltage, ylab="Voltage", xlab="datetime", type="l"))


## Sub metering time series
with(hhpc, plot(DateTime, Sub_metering_1,type="l", xlab = "", 
                ylab = "Energy sub metering"))
lines(hhpc$DateTime, hhpc$Sub_metering_2,type="l", col="red")
lines(hhpc$DateTime, hhpc$Sub_metering_3,type="l", col="blue")

legend("topright", bty="n", lty = 1, lwd=2,col=c("black","red","blue"),
       legend=c("Sub_metering_1",
                "Sub_metering_2",
                "Sub_metering_3"))

## Global reactive power time series graphic
with(hhpc,plot(DateTime,Global_reactive_power, xlab="datetime", type="l"))

dev.off()