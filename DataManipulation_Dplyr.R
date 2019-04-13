library(dplyr)

## Data manipulation - Time series using Dplyr

## Basic dplyr functions :
   # pipe
   # count
   # filter
   # groupby
   # summarise
   # mutate
   # arrange

## Data-Set Variable description
## id1 - Wind speed
## id2 - Nacelle position
## id3 - Wind Direction
## id11 - Generator Speed
## id65 - Turbine Blade Angle1
## id66 - Turbine Blade Angle2
## id67 - Turbine Blade Angle3
## id32 - Active Power
## id39 - Ambient Temperature
## id115 - Power Limitation
## id118 - Time
## id121 - Turbine state


## importing data file
data = read.csv('C:/Users/NITESH/Desktop/ESS/data.csv')

##Filtering the required columns
columns= c('id1','id2','id3','id11','id32','id118')
data=data[,columns]
colnames(data)=c('wind_speed','nac_position','wind_direction','generator_speed','active_power','time')


##Glimpse of filtered data
head(data)

     wind_speed nac_position wind_direction generator_speed    active_power      time
1       2.80       145.05          -6.39           10.14        16.10        2018-03-21T00:00:01Z
2       2.89       145.05          -6.57            9.91        19.52        2018-03-21T00:00:06Z
3       2.67       146.28          -6.92            9.95        20.38        2018-03-21T00:00:14Z
4       2.88       147.51          -6.99            9.91        19.52        2018-03-21T00:00:21Z
5       2.90       147.51          -7.14            9.93        26.36        2018-03-21T00:00:28Z
6       2.95       147.51          -7.63            9.99        24.65        2018-03-21T00:00:35Z

## Changing the time to timestamp
data$time=as.POSIXct(data$time, format='%Y-%m-%dT%H:%M:%SZ')


##Displaying time as in the calendar - time format
head(data$time)

[1] "2018-03-21 00:00:01 CDT" "2018-03-21 00:00:06 CDT" "2018-03-21 00:00:14 CDT" "2018-03-21 00:00:21 CDT"
[5] "2018-03-21 00:00:28 CDT" "2018-03-21 00:00:35 CDT"


##Pipe operator of Dplyr displays the same content as above
data$time %>% head()

[1] "2018-03-21 00:00:01 CDT" "2018-03-21 00:00:06 CDT" "2018-03-21 00:00:14 CDT" "2018-03-21 00:00:21 CDT"
[5] "2018-03-21 00:00:28 CDT" "2018-03-21 00:00:35 CDT"


##Times series 10 minutes 
##First requires assing a bin to every observation or in other words 10 minutes block
##Adding a bin for every data points
data$bin = cut(data$time , breaks = '10 mins')
data %>% head()
unique(data$bin) %>% head()

 wind_speed nac_position wind_direction generator_speed active_power        time                       bin
1       2.80       145.05          -6.39           10.14        16.10    2018-03-21 00:00:01    2018-03-21 00:00:00
2       2.89       145.05          -6.57            9.91        19.52    2018-03-21 00:00:06    2018-03-21 00:00:00
3       2.67       146.28          -6.92            9.95        20.38    2018-03-21 00:00:14    2018-03-21 00:00:00
4       2.88       147.51          -6.99            9.91        19.52    2018-03-21 00:00:21    2018-03-21 00:00:00
5       2.90       147.51          -7.14            9.93        26.36    2018-03-21 00:00:28    2018-03-21 00:00:00
6       2.95       147.51          -7.63            9.99        24.65    2018-03-21 00:00:35    2018-03-21 00:00:00

[1] 2018-03-21 00:00:00 2018-03-21 00:10:00 2018-03-21 00:20:00 2018-03-21 00:30:00 2018-03-21 00:40:00
[6] 2018-03-21 00:50:00



##The above results display how effectively every data observations are assigned a bin specific to which blocks
##Data points in each bin
##Total number of bins
data %>% group_by(bin) %>%summarise(Total_DataPoints=n())

  bin                        Total_DataPoints
   <fct>                           <int>
 1 2018-03-21 00:00:00               84
 2 2018-03-21 00:10:00               84
 3 2018-03-21 00:20:00               84
 4 2018-03-21 00:30:00               84
 5 2018-03-21 00:40:00               83
 6 2018-03-21 00:50:00               84
 7 2018-03-21 01:00:00               84
 8 2018-03-21 01:10:00               84
 9 2018-03-21 01:20:00               85
10 2018-03-21 01:30:00               84
# ... with 134 more rows



##Averaging 10 mins data for wind speed and power
data %>% group_by(bin) %>% summarise_each(funs(mean),wind_speed, active_power)

 bin                 wind_speed active_power
   <fct>                    <dbl>        <dbl>
 1 2018-03-21 00:00:00       2.76       20.0  
 2 2018-03-21 00:10:00       2.43       10.0  
 3 2018-03-21 00:20:00       2.35        9.48 
 4 2018-03-21 00:30:00       2.30        6.77 
 5 2018-03-21 00:40:00       2.15       -0.677
 6 2018-03-21 00:50:00       2.43        6.63 
 7 2018-03-21 01:00:00       2.33        5.93 
 8 2018-03-21 01:10:00       2.43        9.64 
 9 2018-03-21 01:20:00       2.84       28.2  
10 2018-03-21 01:30:00       2.92       28.0  
# ... with 134 more rows
