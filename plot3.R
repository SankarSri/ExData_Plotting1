#DO NOT EXECUTE DOWNLOAD AND UNZIP IF THE DATA FILE ALREADY EXISTS OR DOWNLOADED IN PREVIOUS PROGRAMS

#download the file from specified url to current directory with name elec.zip in binary mode
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile = "elec.zip",mode = "wb")

#unzip the file to obtain a txt file named household_power_consumption.txt
unzip("elec.zip")

#read the data frame with seperator and na specifier and with column classes as desired
ElecDT <- read.table("household_power_consumption.txt", na.strings = "?", sep = ";", colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"), header = T)

#subset the class to 2 days in Feb 2007, that we plan to use it for the exploratory graphs
ElecDTFeb07d1d2 <- ElecDT[ElecDT$Date == "1/2/2007" | ElecDT$Date == "2/2/2007", ]

#obtain as POSITct date by combining both date and time
ElecDTFeb07d1d2$Date <- as.POSIXct(paste(ElecDTFeb07d1d2$Date,ElecDTFeb07d1d2$Time,sep=","), format = "%d/%m/%Y ,%T")

#open a png file device with required size
png(filename = "Rplot3.png",width = 480, height = 480)

#draw an empty graph with type = "n", to plot later
with(ElecDTFeb07d1d2, plot(Date,Sub_metering_1,type="n", ylab = "Energy Sub Metering",xlab=""))

#fill with graph with data & desired color
with(subset(ElecDTFeb07d1d2,select = c(Date,Sub_metering_1)), points(Date,Sub_metering_1,type="l",col="black"))
with(subset(ElecDTFeb07d1d2,select = c(Date,Sub_metering_2)), points(Date,Sub_metering_2,type="l",col="red"))
with(subset(ElecDTFeb07d1d2,select = c(Date,Sub_metering_3)), points(Date,Sub_metering_3,type="l",col="blue"))

#show the legend at the topright corner
legend("topright", pch = 20, col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#close the PNG file device
dev.off()