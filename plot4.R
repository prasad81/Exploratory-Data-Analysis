setwd("C:\\R\\coursera\\github\\Exploratory-Data-Analysis")
getwd()

## read the data from download files from  https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

##merge two data sets by scc
NEISCC <- merge(NEI, SCC, by="SCC")
 
library(ggplot2)

 

# fetch all NEIxSCC records with Short.Name (SCC) Coal
coalMatches  <- grepl("coal", NEISCC$Short.Name, ignore.case=TRUE)

## subset
NEISCCsubset <- NEISCC[coalMatches, ]


aggregatedTotalByYear <- aggregate(Emissions ~ year, NEISCCsubset, sum)

png(filename="plot4.png", width=480, height=480)
 
ggplot(data = aggregatedTotalByYear, aes(x=factor(year), y=Emissions/1000, fill=year,label = round(Emissions/1000,2))) +
  ## Sum the data per year using the 'identity' function
  geom_bar(stat="identity") +
  labs(x = 'Year') +
  labs(y = 'PM2.5 Emission in tonnes') +
  labs(title = 'Yearly emissions in Baltimore City per source type')+
  geom_label(aes(fill = year), colour = "white", fontface = "bold")

dev.off()
