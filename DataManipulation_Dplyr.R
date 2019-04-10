## Data manipulation - Time series using Dplyr

## Variable description
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
