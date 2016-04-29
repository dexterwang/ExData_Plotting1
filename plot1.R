setwd("C:/D/R/Exploratory Data Analysis/week1 project")

#load data from source file

con<-file("./household_power_consumption.txt")

data <- read.table(con,header=TRUE,sep=";",stringsAsFactors=FALSE) 

#filter data to get the targeted two day period 

filtered_data <- data[which(grepl("(^1/2/2007)|(^2/2/2007)", data$Date)),]

#convert Date and Time into POSIXct format
filtered_data$DateTime <- paste(filtered_data$Date," ",filtered_data$Time)

filtered_data$DateTime <- as.POSIXct(strptime(filtered_data$DateTime,"%d/%m/%Y %H:%M:%S"))

#convert the numeric columns into numeric type
cols = c(3:9)
filtered_data[,cols] <- apply(filtered_data[,cols], 2, function(x) as.numeric(as.character(x)))

#draw histogram plot1 
with(filtered_data,hist(Global_active_power,main=paste("Global Active Power"),col="red",xlab="Global Active Power (kilowatts)"))

#save screen output as png
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()




# obsolete code

#the data for 1/2/2007 and 2/2/2007 range from row 66637 to 69516

#minrow<-min(which(grepl("(^1/2/2007)|(^2/2/2007)", data$Date)))

#maxrow<-max(which(grepl("(^1/2/2007)|(^2/2/2007)", data$Date)))

#the code below could load the specified range of rows instead of loading the whole file
#open(con)

#read.table(con,nrow=maxrow-minrow+1,sep=";",skip=minrow) 

#close(con)