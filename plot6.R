setwd("C:\\R\\coursera\\github\\Exploratory-Data-Analysis")
getwd()

## read the data from download files from  https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

##merge two data sets by scc
NEISCC <- merge(NEI, SCC, by="SCC")

#### library(ggplot2)

#### subsetNEI <- NEI[(NEI$fips=="24510"|NEI$fips=="06037") & NEI$type=="ON-ROAD",  ]

#### aggregatedTotalByYearAndFips <- aggregate(Emissions ~ year + fips, subsetNEI, sum)
#### aggregatedTotalByYearAndFips$fips[aggregatedTotalByYearAndFips$fips=="24510"] <- "Baltimore, MD"
#### aggregatedTotalByYearAndFips$fips[aggregatedTotalByYearAndFips$fips=="06037"] <- "Los Angeles, CA"

#### png("plot6.png", width=1040, height=480)
####g <- ggplot(aggregatedTotalByYearAndFips, aes(factor(year), Emissions))
####g <- g + facet_grid(. ~ fips)
####g <- g + geom_bar(stat="identity")  +
####  xlab("year") +
####  ylab(expression('Total PM'[2.5]*" Emissions")) +
####  ggtitle('Total Emissions from motor vehicle (type=ON-ROAD) in Baltimore City, MD (fips = "24510") vs Los Angeles, CA (fips = "06037")  1999-2008')
####print(g)
####dev.off()


####
library(dplyr)
library(ggplot2)

baltimore.emissions<-summarise(group_by(filter(NEI, fips == "24510"& type == 'ON-ROAD'), year), Emissions=sum(Emissions))
la.emissions<-summarise(group_by(filter(NEI, fips == "06037"& type == 'ON-ROAD'), year), Emissions=sum(Emissions))

baltimore.emissions$County <- "Baltimore City, MD"
la.emissions$County <- "Los Angeles County, CA"
merge.emissions <- rbind(baltimore.emissions, la.emissions)

png(filename="plot6.png", width=840, height=480)
ggplot(merge.emissions, aes(x=factor(year), y=Emissions, fill=County,label = round(Emissions,2))) +
    geom_bar(stat="identity") + 
    facet_grid(County~., scales="free") +
    ylab(expression('Total PM'[2.5]*" Emissions")) +
    xlab("year") +
    ggtitle(expression("Motor vehicle emission variation in Baltimore and Los Angeles in tons"))+
    geom_label(aes(fill = County),colour = "white", fontface = "bold")

dev.off()
