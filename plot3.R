subset_household_data <- getData(fileName, 
                                 skip = 63000, nrows = 20000, 
                                 header = TRUE, sep =";", stringsAsFactors =  FALSE)

par(mfrow = c(1, 1), mar = c(5, 5, 2, 1))
#plot EnergySubMetring 1~3  (Y), datetime(X), bty to set legent box
plotEnergySubMetering(subset_household_data)
dev.copy(png, file = "plot3.png", width=480, height=480, units = "px")  ## Copy my plot to a PNG file
dev.off()  ## Don't forget to close the PNG device!

