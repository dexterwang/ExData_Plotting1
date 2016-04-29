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

#draw the line graph
with(filtered_data, plot(DateTime,Global_active_power,type="l",xlab=NA,ylab="Global Active Power (kilowatts)"))


#save screen output as png
dev.copy(png,"plot2.png", width=480, height=480)
dev.off()