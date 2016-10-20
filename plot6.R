# Read the National Emissions Inventory data

if(!exists("NEI")){
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}

# Read the Source Classification Code file

if(!exists("SCC")){
  SCC <- readRDS("./data/Source_Classification_Code.rds")
}

# merge the two data sets 

if(!exists("NEISCC")){
  NEISCC <- merge(NEI, SCC, by="SCC")
}


library(ggplot2)


# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor 
# vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?


NEIBaltimoreLosAngeles <- NEI[(NEI$fips=="24510"|NEI$fips=="06037") & NEI$type=="ON-ROAD",  ]

EmissionsTotalsByYearAndFips <- aggregate(Emissions ~ year + fips, NEIBaltimoreLosAngeles, sum)

EmissionsTotalsByYearAndFips$fips[EmissionsTotalsByYearAndFips$fips=="24510"] <- "Baltimore, MD"

EmissionsTotalsByYearAndFips$fips[EmissionsTotalsByYearAndFips$fips=="06037"] <- "Los Angeles, CA"

png("plot6.png", width=1040, height=480)
g <- ggplot(EmissionsTotalsByYearAndFips, aes(factor(year), Emissions))
g <- g + facet_grid(. ~ fips)
g <- g + geom_bar(stat="identity")  +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from motor vehicle (type=ON-ROAD) in Baltimore City, MD (fips = "24510") vs Los Angeles, CA (fips = "06037")  1999-2008')
print(g)
dev.off()
