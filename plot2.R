

# Load the NEI & SCC data frames.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


baltimore_NEI <- NEI[NEI$fips=="24510",]

# Aggregate the total sum of the Baltimore emissions data by year
aggTotals_Baltimore <- aggregate(Emissions ~ year, baltimore_NEI,sum)

png("plot2.png",width=600,height=600,units="px",bg="transparent")

barplot(
  aggTotals_Baltimore$Emissions,
  names.arg=aggTotals_Baltimore$year,
  xlab="Year",
  ylab="PM2.5 Emissions (Tons)",
  main="Total PM2.5 Emissions From all Baltimore City Sources"
)

dev.off()
