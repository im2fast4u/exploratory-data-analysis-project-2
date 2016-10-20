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

# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?


NEIBaltimoreOnRoad <- NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD",  ]

EmissionsTotalsByYear <- aggregate(Emissions ~ year, NEIBaltimoreOnRoad, sum)



png("plot5.png", width=840, height=480)
g <- ggplot(EmissionsTotalsByYear, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from motor vehicle (type = ON-ROAD) in Baltimore City, Maryland (fips = "24510") from 1999 to 2008')
print(g)
dev.off()
