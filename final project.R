# final project
library(dplyr)

traffic_df <- read.csv('Traffic_Crashes_-_Crashes 2.csv')
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

traffic_df[c('Month', 'Day', 'Year')] <- str_split_fixed(traffic_df$CRASH_DATE, '/', 3)
traffic_df$Year <- substr(traffic_df$Year, 1, 2)

traffic_df$Big_damage[traffic_df$DAMAGE == 'OVER $1,500'] <- 1
traffic_df$Big_damage[traffic_df$DAMAGE != 'OVER $1,500'] <- 0

combo_df <- merge(traffic_df, weather_df, by = c('Year', 'Month', 'Day'))

write.csv(combo_df, "~/Desktop/haha/info201/Final project/combo_df.csv", row.names = FALSE)


