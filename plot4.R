data<-read.table("household_power_consumption.txt",skip=grep("1/2/2007",readLines("household_power_consumption.txt")),nrows=2879,sep=";")
colNames<-c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
colnames(data)<-colNames
data$Date<-strptime(data$Date,"%e/%m/%Y")
data$day <- wday(as.Date(data$Date),label=TRUE)
data$Date<-as.POSIXct(data$Date)
data1<-filter(data,(day=="Thurs"| data$day=="Fri"|data$day=="Sat"))
data1$TimeSeconds<-period_to_seconds(hms(as.character(data1$Time)))
data1$TimeSeconds[data1$day=="Fri"]<-data1$TimeSeconds[data1$day=="Fri"]+24*60*60
#
par(mfrow=c(2,2))
#plot 1
plot(data1$TimeSeconds,data1$Global_active_power,type="l",xlab="",ylab="Global active power (kilowatts)",ymax=8.,cex.lab=0.8,labels=NA)
axis(2)
axis(1,at=c(1,median(data1$TimeSeconds),max(data1$TimeSeconds)),labels=c("Thurs","Fri","Sat"))
#plot 2
plot(data1$TimeSeconds,data1$Voltage,type="l",xlab="datetime",ylab="Voltage",ymax=8.,cex.lab=0.8,labels=NA)
axis(2)
plot(data1$TimeSeconds,data1$Voltage,type="l",xlab="datetime",ylab="Voltage",ymax=8.,cex.lab=0.8,labels=NA)
# plot 3
plot(1,type='n',xlim=c(1,nrow(data1)),ylim=c(0.,max(data1$Sub_metering_1)),xlab="", ylab="Energy sub metering",labels=NA,cex.lab=0.8)
lines(data1$Sub_metering_1)
lines(data1$Sub_metering_2,col="red")
lines(data1$Sub_metering_3,col="blue")
axis(2)
axis(1,at=c(1,median(data1$TimeSeconds),max(data1$TimeSeconds)),labels=c("Thurs","Fri","Sat"))
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lwd=1,cex=0.5)
# plot 4
plot(data1$TimeSeconds,data1$Global_reactive_power,type="l",xlab="datetime",ylab="Global reactive power",ymax=8.,cex.lab=0.8,labels=NA)
axis(2)
axis(1,at=c(1,median(data1$TimeSeconds),max(data1$TimeSeconds)),labels=c("Thurs","Fri","Sat"))
#
dev.copy(png,file="plot4.png",width=480,height=480)
dev.off()