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

# Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

# from the combined data set get all the records whose short names has a word "coal"

CoalRecords  <- grepl("coal", NEISCC$Short.Name, ignore.case=TRUE)

NEISCCCoalRecords <- NEISCC[CoalRecords, ]

CoalEmissionsByYearTotals <- aggregate(Emissions ~ year, NEISCCCoalRecords, sum)



png("plot4.png", width=640, height=480)
g <- ggplot(CoalEmissionsByYearTotals, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from coal sources from 1999 to 2008')
print(g)
dev.off()
