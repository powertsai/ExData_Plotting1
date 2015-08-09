#load data 2007/02/01~2007/02/03 for plot data and axis thur~sat
household_data <- getData(fileName, 
                                 skip = 63000, nrows = 20000, 
                                 header = TRUE, sep =";", stringsAsFactors =  FALSE)

subset_household_data <- filter(household_data, 
                                year == 2007 & month == 2 & mday %in% c(1,2) )


par(mfrow = c(1, 1), mar = c(4, 4, 2, 1))
## Create xyplot by Global Active Power (Y), datetime (X) on screen device
with(subset_household_data , 
     plot(x=datetime, y=Global_active_power ,
          ylab="Global Active Power (kilowatts)",
          xlab="",
          xaxt = "n",
          type="l") )

#set X-Axis by the weekday of datetime at 00:00:00
setXAxis(household_data)

dev.copy(png, file = "plot2.png", width=480, height=480, units = "px")  ## Copy my plot to a PNG file
dev.off()  ## Don't forget to close the PNG device!
