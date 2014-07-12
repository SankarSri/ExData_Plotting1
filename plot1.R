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
png(filename = "Rplot1.png",width = 480, height = 480)

#draw a histogram of Global Active Power
hist(ElecDTFeb07d1d2$Global_active_power,col = "red", xlab = "Global Active Power (Kilowatts)", main ="Histogram of Global Active Power")

#close the PNG file device
dev.off()



