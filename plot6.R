# Load the NEI & SCC data frames.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Gather the subset of the NEI data which corresponds to vehicles
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehicles_SCC <- SCC[vehicles,]$SCC
vehicles_NEI <- NEI[NEI$SCC %in% vehicles_SCC,]

# Subset the vehicles NEI data by each city's fip and add city name.
vehiclesBaltimore_NEI <- vehicles_NEI[vehicles_NEI$fips=="24510",]
vehiclesBaltimore_NEI$city <- "Baltimore City"

vehiclesLosAngNEI <- vehicles_NEI[vehicles_NEI$fips=="06037",]
vehiclesLosAngNEI$city <- "Los Angeles County"

# Combine the two subsets with city name into one data frame
CMBNEI <- rbind(vehiclesBaltimore_NEI,vehiclesLosAngNEI)

png("plot6.png",width=600,height=600,units="px",bg="transparent")

library(ggplot2)

ggp <- ggplot(CMBNEI, aes(x=factor(year), y=Emissions, fill=city)) +
  geom_bar(aes(fill=year),stat="identity") +
  facet_grid(scales="free", space="free", .~city) +
  guides(fill=FALSE) + theme_bw() +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Kilo-Tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008"))

print(ggp)

dev.off()
