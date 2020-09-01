## Reading data set
## It useful to convert the Date and Time variables to Date/Time classes in R 
## using the strptime() and as.Date() functions.
## Note that in this dataset missing values are coded as ?.
hhpc <- read.table("household_power_consumption.txt",sep = ";",
                   header = TRUE, na.strings = "NA", 
                   colClasses = "character")

hhpc$DateTime <- strptime(paste(hhpc$Date, hhpc$Time), "%d/%m/%Y %H:%M:%S")

## We will only be using data from the dates 2007-02-01 and 2007-02-02. 
## One alternative is to read the data from just those dates rather than reading 
## in the entire dataset and subsetting to those dates.
hhpc$Date <- as.Date(hhpc$Date, "%d/%m/%Y")

hhpc <- subset(hhpc, Date>='2007-02-01' & Date<='2007-02-02')

## We convert Sub_metering columns to numeric
hhpc$Sub_metering_1<-as.numeric(hhpc$Sub_metering_1)
hhpc$Sub_metering_2<-as.numeric(hhpc$Sub_metering_2)
hhpc$Sub_metering_3<-as.numeric(hhpc$Sub_metering_3)

## We plot sub metering time series graphic
png(file="plot3.png")

with(hhpc,plot(DateTime,Sub_metering_1,
                    ylab="Energy sub metering",
                    xlab="",
                    type="n"))
with(subset(hhpc,Sub_metering_1>=0),
     points(DateTime,Sub_metering_1,col="black",type="l"))

with(subset(hhpc,Sub_metering_2>=0),
     points(DateTime,Sub_metering_2,col="red",type="l"))

with(subset(hhpc,Sub_metering_3>=0),
     points(DateTime,Sub_metering_3,col="blue",type="l"))

legend("topright",lwd=1,col=c("black","red","blue"),
       legend=c("Sub_metering_1",
                "Sub_metering_2",
                "Sub_metering_3"))
dev.off()
