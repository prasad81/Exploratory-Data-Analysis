setwd("C:\\R\\coursera\\github\\Exploratory-Data-Analysis")
getwd()

## read the data from download files from  https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

table(NEI$year)

aggregatedTotalByYear <- aggregate(Emissions ~ year, NEI, sum)
 
png(filename='plot1.png') 
barplot(height=aggregatedTotalByYear$Emissions, names.arg=aggregatedTotalByYear$year, xlab="years", ylab=expression('total PM'[2.5]*' emission'),main=expression('Total PM'[2.5]*' emissions at various years'))
dev.off()
