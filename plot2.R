# Read the National Emissions Inventory data

if(!exists("NEI")){
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}


# Read the Source Classification Code file

if(!exists("SCC")){
  SCC <- readRDS("./data/Source_Classification_Code.rds")
}


# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

NEIBaltimoreCity  <- NEI[NEI$fips=="24510", ]

EmissionsTotalsByYear <- aggregate(Emissions ~ year, NEIBaltimoreCity, sum)

# Create a bar plot

png('plot2.png')

barplot(height=EmissionsTotalsByYear$Emissions, 
        names.arg=EmissionsTotalsByYear$year, 
        xlab="years", 
        ylab=expression('total PM'[2.5]*' emission'),
        main=expression('Total PM'[2.5]*' in the Baltimore City, MD emissions at various years'))

dev.off()
