# Read the National Emissions Inventory data

if(!exists("NEI")){
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}

# Read the Source Classification Code file

if(!exists("SCC")){
  SCC <- readRDS("./data/Source_Classification_Code.rds")
}


library(ggplot2)

# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999 2008 for Baltimore City? 
# Which have seen increases in emissions from 1999 2008? 
# Use the ggplot2 plotting system to make a plot answer this question.


NEIBaltimoreCity  <- NEI[NEI$fips=="24510", ]

EmissionsTotalsByYearAndType <- aggregate(Emissions ~ year + type, NEIBaltimoreCity, sum)


png("plot3.png", width=640, height=480)

g <- ggplot(EmissionsTotalsByYearAndType, aes(year, Emissions, color = type))

g <- g + geom_line() +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions in Baltimore City, Maryland (fips == "24510") from 1999 to 2008')

print(g)

dev.off()
