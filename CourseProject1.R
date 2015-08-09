#memory required = no. of column * no. of rows * 8 bytes
print(paste("require memory [column * rows * 8 / 1024^2 ](MB) =", (9 * 2075260 * 8)/1024/1024, "MB"))

#predict memory required to read file
household_data_first1000 <- read.table(file=fileName, nrows = 1000, skip=0,
                                       header = TRUE, sep =";", stringsAsFactors =  FALSE)
data_size <- object.size(household_data_first1000) 
memSize <- data_size * 2075260 /1000 / 1024 / 1024
print(paste("predict memory[read 1000 rows to get object size first]:", memSize, "MB"))


#for performance issue using vi to find the possible range by 20000 rows only 
#then uses dplyr, lubridate packages to filter dataset on 2007/02/01, 2007/02/02
getData <- function(fileName = fileName,...) {
  household_data_first100 <- read.table(file=fileName, nrows = 100, skip=0,
                                         header = TRUE, sep =";", stringsAsFactors =  FALSE)
  
  #skip 63000 rows and read 20000 rows only
  household_data <- read.table(file=fileName,...)
  names(household_data) <- names(household_data_first100)
  # require library dplyr to use mutate, filter to get date in 2007/02/01, 2007/02/02
  library(dplyr)
  # require lubridate to get year, month, mday to filter data
  library(lubridate)
  subset_household_data <-
    household_data %>% 
    mutate(datetime = dmy_hms(paste(Date, Time) ) ) %>%
    mutate(Date = dmy(Date)) %>%
    mutate(year = year(Date)) %>%
    mutate(month = month(Date)) %>%
    mutate(mday = mday(Date)) %>%
    mutate(wday = wday(Date, label = TRUE)) %>%
    mutate(hour = hour(datetime)) %>%
    mutate(minute = minute(datetime)) %>%
    mutate(second = second(datetime)) %>%
    filter(   
      (year == 2007 & month == 2 & mday %in% c(1,2,3) )
    )
}


#place Datetime Axis by 00:00:00 
setXAxis <- function(subset_household_data){
  #pick up datetime at 00:00:00 to place x axis label
  axisSubSet = filter(subset_household_data, hour == 0 & minute == 0 & second == 0)
  #Add X-Axis to xyPlot
  with(axisSubSet, axis(1, at=datetime,labels=wday, col.axis="black", las=2) )
}


#plot EnergySubMetring 1~3  (Y), datetime(X), bty to set legent box
plotEnergySubMetering <- function (subset_household_data, bty = "o", legendCex = 0.8) {
  ## Create xyplot by Sub_metering_1 (Y), datetime (X) on screen device
  with(subset_household_data , 
       plot(x=datetime, y=Sub_metering_1 ,
            ylab="Energy sub metering",
            xlab="",
            xaxt = "n",
            type="l") )
  # draw lines for Sub_metering_2 ~ datetime
  with(subset_household_data , 
       lines(x=datetime, y=Sub_metering_2 ,
             ylab="Energy sub metering",
             xlab="",
             xaxt = "n",
             col="red",
             type="l") )
  # draw lines for Sub_metering_3 ~ datetime
  with(subset_household_data , 
       lines(x=datetime, y=Sub_metering_3 ,
             ylab="Energy sub metering",
             xlab="",
             xaxt = "n",
             col="blue",
             type="l") )
  
  #place legent on top right
  legend("topright", pch = -1, col = c("black", "red", "blue"), lty= 1, bty =bty,
         cex=legendCex, pt.cex = 1,
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
}

