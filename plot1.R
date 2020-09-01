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

## We convert Global active power column to class numeric
hhpc$Global_active_power<-as.numeric(hhpc$Global_active_power)

## We plot histogram of global active and power usage
png(file="plot1.png")

with(hhpc,hist(Global_active_power,col="red",main="Global Active Power",
                    xlab="Global Active Power (kilowatts)"))
dev.off()

