require(ggplot2)

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

#Baltimore code
Baltimore_fips<-"24510"

#total of all emissions per year, per type
emissions <- aggregate(Emissions~year+fips+type, PM25, FUN=sum)
#subset to get only Baltimore's
emissions<-subset(emissions,fips==Baltimore_fips, select=c(year,type,Emissions))
#this is necessary so we only have 1999, 2002, 2005 and 2008 in the plot
emissions$year<-factor(emissions$year, levels=c(1999, 2002, 2005, 2008))

#Plot
png("plot3.png")
plot <- ggplot(data=emissions,aes(x=year, y=Emissions))
plot <- plot + facet_grid(.~type)
plot <- plot + geom_point()
plot <- plot + ggtitle("Baltimore's emissions")
print(plot)

dev.off()