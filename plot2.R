subset_household_data <- getData(fileName, 
                                 skip = 63000, nrows = 20000, 
                                 header = TRUE, sep =";", stringsAsFactors =  FALSE)

par(mfrow = c(1, 1), mar = c(4, 4, 2, 1))
## Create xyplot by Global Active Power (Y), datetime (X) on screen device
with(subset_household_data , 
     plot(x=datetime, y=Global_active_power ,
          ylab="Global Active Power (kilowatts)",
          xlab="",
          xaxt = "n",
          type="l") )

#set X-Axis by the weekday of datetime at 00:00:00
setXAxis(subset_household_data)

dev.copy(png, file = "plot2.png", width=480, height=480, units = "px")  ## Copy my plot to a PNG file
dev.off()  ## Don't forget to close the PNG device!
