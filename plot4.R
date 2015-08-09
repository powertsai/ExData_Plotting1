household_data <- getData(fileName, 
                          skip = 63000, nrows = 20000, 
                          header = TRUE, sep =";", stringsAsFactors =  FALSE)

subset_household_data <- filter(household_data, 
                                year == 2007 & month == 2 & mday %in% c(1,2) )

par(mfcol = c(2, 2), mar = c(4, 4, 2, 1))

## Create xyplot by Global Active Power (Y), datetime (X) on screen device
with(subset_household_data , 
     plot(x=datetime, y=Global_active_power ,
          ylab="Global Active Power",
          xlab="",
          xaxt = "n",
          type="l") )

#set X-Axis by the weekday of datetime at 00:00:00
setXAxis(household_data)


#plot EnergySubMetring 1~3  (Y), datetime(X), bty to set legent box
plotEnergySubMetering(subset_household_data, bty="n", legendCex = 0.7)

#set X-Axis by the weekday of datetime at 00:00:00
setXAxis(household_data)

#plot Voltage(Y), datetime(X), bty to set legent box
with(subset_household_data , 
     plot(x=datetime, y=Voltage ,
          ylab="Voltage",
          xlab="datetime",
          xaxt = "n",
          type="l") )

#set X-Axis by the weekday of datetime at 00:00:00
setXAxis(household_data)


#plot Global_reactive_power(Y), datetime(X), bty to set legent box
with(subset_household_data , 
     plot(x=datetime, y=Global_reactive_power ,
          ylab="Global_reactive_power",
          xlab="datetime",
          xaxt = "n",
          type="l") )

#set X-Axis by the weekday of datetime at 00:00:00
setXAxis(household_data)

dev.copy(png, file = "plot4.png", width=480, height=480, units = "px")  ## Copy my plot to a PNG file
dev.off()  ## Don't forget to close the PNG device!

