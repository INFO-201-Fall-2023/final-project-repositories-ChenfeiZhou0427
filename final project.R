# final project
library(dplyr)

traffic_df <- read.csv('Traffic_Crashes_-_Crashes.csv')
weather_df <- read.csv('3311717.csv')

weather_df <- select(weather_df, DATE, HourlyAltimeterSetting, HourlyDewPointTemperature, 
                     HourlyDryBulbTemperature, HourlyPrecipitation, HourlyPresentWeatherType, 
                     HourlyPressureChange, HourlyPressureTendency, HourlyRelativeHumidity, 
                     HourlySeaLevelPressure, HourlySkyConditions, HourlyStationPressure, 
                     HourlyVisibility, HourlyWetBulbTemperature, HourlyWindDirection, 
                     HourlyWindGustSpeed, HourlyWindSpeed)

weather_df$Year <- substr(weather_df$DATE, 1, 4)
weather_df$Month <- substr(weather_df$DATE, 6, 7)
weather_df$Day <- substr(weather_df$DATE, 9, 10)

traffic_df$Year <- substr(traffic_df$CRASH_DATE, 7, 10)
traffic_df$Month <- substr(traffic_df$CRASH_DATE, 1, 2)
traffic_df$Day <- substr(traffic_df$CRASH_DATE, 4, 5)

traffic_df$Big_damage[traffic_df$DAMAGE == 'OVER $1,500'] <- 1
traffic_df$Big_damage[traffic_df$DAMAGE != 'OVER $1,500'] <- 0

combo_df <- right_join(traffic_df, weather_df, by = c('Year', 'Month', 'Day'))


