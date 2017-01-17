#Get the .zip file
url1 <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
filename1 <- "exdata_data_NEI_data.zip"
if (!file.exists(filename1)) {
  download.file(url1, filename1)
}

#Unzip if it does not exist
if (!file.exists("exdata_data_NEI_data")) { 
  unzip(filename1, exdir="exdata_data_NEI_data") 
}

#read the file containing the PM2.5 emissions for the selected years
PM25 <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
#SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

#total of all emissions
emissions <- aggregate(PM25[,'Emissions'],by=list(PM25$year), FUN=sum)
colnames(emissions) <- c("Year","Total")

#Plot
png("plot1.png")
barplot(emissions$Total, names=emissions$Year, main="Total Emissions per Year", xlab="Year", ylab="Emissions")
dev.off()