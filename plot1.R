#load data
subset_household_data <- getData(fileName, 
                                 skip = 63000, nrows = 20000, 
                                 header = TRUE, sep =";", stringsAsFactors =  FALSE)
#check dataset by head
head(subset_household_data)
#check dataset by tail
tail(subset_household_data) 
names(subset_household_data)
## Create Histograms of Global Active Power on screen device
par(mfrow = c(1, 1), mar = c(5, 5, 2, 0))
with(subset_household_data, 
     hist(Global_active_power, col="red", 
     main = "Global Active Power",
     xlab="Global Active Power (kilowatts)"))  
dev.copy(png, file = "plot1.png", width=480, height=480, units = "px")  ## Copy my plot to a PNG file
dev.off()  ## Don't forget to close the PNG device!

