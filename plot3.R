
#Obtain the files
destfile="data/exdata_data_household_power_consumption.zip" 
if(!file.exists(destfile)){download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile = destfile)}
unzip(destfile,exdir = "./data/exdata_data_household_power_consumption")

library(data.table)
columnNames<-c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
file<-data.table::fread("data/exdata_data_household_power_consumption/household_power_consumption.txt",skip = "1/2/2007",sep = ";",nrows = 2880, col.names = columnNames)

#Create plot
FileDates<-strptime(paste(file$Date,file$Time),"%d/%m/%Y %H:%M:%S")
windows(height = 7,width = 6.3)
with(file, plot(FileDates,file$Sub_metering_1 ,type = "n", ylab = "Energy sub metering",xlab = ""))
with(subset(file), points(FileDates, file$Sub_metering_1, col = "black", type="l"))
with(subset(file), points(FileDates, file$Sub_metering_2, col = "red",type="l"))
with(subset(file), points(FileDates, file$Sub_metering_3, col = "blue",type="l"))
legend("topright", lty = 1,cex = 0.8,col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))


#Save to PNG file
dev.copy(png, file="CourseProjects/Exploratory_Analysis/CourseProject1/plot3.png",width = 480, height = 480)
dev.off()

