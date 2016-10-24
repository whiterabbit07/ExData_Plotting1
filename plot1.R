data<-read.table("household_power_consumption.txt",skip=grep("1/2/2007",readLines("household_power_consumption.txt")),nrows=2879,sep=";")
colNames<-c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
colnames(data)<-colNames
data$Date<-strptime(data$Date,"%e/%m/%Y")
hist(data$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
dev.copy(png,file="plot1.png",width=480,height=480)
dev.off(5)