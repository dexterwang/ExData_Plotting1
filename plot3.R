setwd("C:/D/R/Exploratory Data Analysis/week1 project")

#load data from source file

#as we found out while drawing the previous graph,
#the data for date 1/2/2007 and 2/2/2007 range from row 66637 to 69516
con<-file("./household_power_consumption.txt")

maxrow <- 69516
minrow <- 66637 

open(con)

headers <- names(read.table(con,nrow=1,sep=";",stringsAsFactors=FALSE,header=TRUE))

data <- read.table(con,nrow=maxrow-minrow+1,sep=";",skip=minrow-2,stringsAsFactors=FALSE)

names(data) <- headers

close(con)

#filter data to get the targeted two day period

filtered_data <- data[which(grepl("(^1/2/2007)|(^2/2/2007)", data$Date)),]

#the filtered data has the same number of rows which confirm the previous file loading step is corect
str(filtered_data)

#convert Date and Time into POSIXct format
filtered_data$DateTime <- paste(filtered_data$Date," ",filtered_data$Time)

filtered_data$DateTime <- as.POSIXct(strptime(filtered_data$DateTime,"%d/%m/%Y %H:%M:%S"))

#convert the numeric columns into numeric type
cols = c(3:9)
filtered_data[,cols] <- apply(filtered_data[,cols], 2, function(x) as.numeric(as.character(x)))

#draw the combined line graph
with(filtered_data, plot(DateTime,Sub_metering_1,type="l",xlab=NA,ylab="Energy sub metering"))
with(filtered_data,lines(DateTime,Sub_metering_2,type="l",col="red"))
with(filtered_data,lines(DateTime,Sub_metering_3,type="l",col="blue"))

legend("topright",pch=c(NA,NA,NA),lwd=1,col=c("black","red","blue"),cex=0.9,legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))


#save screen output as png
dev.copy(png,"plot3.png", width=480, height=480)
dev.off()