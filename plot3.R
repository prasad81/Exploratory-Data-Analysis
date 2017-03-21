setwd("C:\\R\\coursera\\github\\Exploratory-Data-Analysis")
getwd()

## read the data from download files from  https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")
library(ggplot2)
 

## Change the 'type' and 'year' columns to a factor for use with ggplot2
NEI$type <- as.factor(NEI$type)
NEI$year <- as.factor(NEI$year)

## Filter for the Baltimore City location using dplyr's filter()
emission.baltimore <- filter(NEI, fips == '24510')

aggregatedTotalByYearAndType <- aggregate(Emissions ~ year + type, NEIsubset, sum)

png(filename ="plot3.png", width=680, height=480)
ggplot(data = aggregatedTotalByYearAndType, aes(x=factor(year), y=Emissions, fill=type,label = round(Emissions,2))) +
  ## Sum the data per year using the 'identity' function
  geom_bar(fill = 'steelblue', stat = 'identity') + 
  ## Split the graph in one panel per source type
  facet_grid(. ~ type) +
  labs(x = 'Year') +
  labs(y = 'PM2.5 Emission in tonnes') +
  labs(title = 'Yearly emissions in Baltimore City per source type')+
  geom_label(aes(fill = type), colour = "white", fontface = "bold")
 
dev.off()

