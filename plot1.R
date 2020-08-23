# Load the necessary packages:
library(dplyr)

# Download the data:
if (!file.exists("./data")){dir.create("./data")}
fileurl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl, destfile = "./data/ziped.zip")
unzip("./data/ziped.zip", exdir = "./data")
# the name of the unziped file is: "household_power_consumption.txt"

# Load the data into R:
data <- read.table("./data/household_power_consumption.txt", 
                   na.strings = "?",
                   sep = ";",
                   header = TRUE)

# Subset and modify date and time variables (creating a new variable called "DateTime"):
data <- data %>% mutate(Date = strptime(data$Date, "%d/%m/%Y")) %>%
  filter(Date == strptime("01/02/2007", "%d/%m/%Y") | Date == strptime("02/02/2007", "%d/%m/%Y"))  

data <- data %>% mutate(DateTime = paste(data$Date, data$Time, sep = " ")) %>%
  select(-Date, -Time)

data <- data %>% mutate(DateTime = strptime(data$DateTime, "%Y-%m-%d %H:%M:%S"))


# Creating the plot:

dev.set(4)
png(filename = "plot1.png", width = 480, height = 480)
hist(data$Global_active_power,
     ylim = range(0,1200),
     xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency", main = "Global Active Power", 
     col = "red")
dev.off()
