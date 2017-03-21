setwd("C:\\R\\coursera\\github\\Exploratory-Data-Analysis")
getwd()

## read the data from download files from  https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

##merge two data sets by scc
NEISCC <- merge(NEI, SCC, by="SCC")
library(dplyr)
library(ggplot2)

baltimore.emissions <- NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD",  ]

aggregatedTotalByYear <- aggregate(Emissions ~ year, baltimore.emissions, sum) 

View(aggregatedTotalByYear) 

png(filename="plot5.png", width=840, height=480)

g <- ggplot(aggregatedTotalByYear, aes(x=factor(year), y=Emissions,fill=year, label = round(Emissions,2)))+
  geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from motor vehicle (type = ON-ROAD) in Baltimore City, Maryland (fips = "24510") from 1999 to 2008') +
  geom_label(aes(fill = year),colour = "white", fontface = "bold")
print(g)
dev.off()
