# final project
library(dplyr)
library(stringr)
library(ggplot2)

traffic_df <- read.csv('Traffic_Crashes_-_Crashes 2.csv')
weather_df <- read.csv('3311717.csv')

weather_df <- select(weather_df, DATE, HourlyAltimeterSetting, HourlyDewPointTemperature, 
                     HourlyDryBulbTemperature, HourlyPrecipitation, HourlyPresentWeatherType, 
                     HourlyPressureChange, HourlyPressureTendency, HourlyRelativeHumidity, 
                     HourlySeaLevelPressure, HourlySkyConditions, HourlyStationPressure, 
                     HourlyVisibility, HourlyWetBulbTemperature, HourlyWindDirection, 
                     HourlyWindGustSpeed, HourlyWindSpeed)

weather_df$Year <- substr(weather_df$DATE, 3, 4)
weather_df$Month <- substr(weather_df$DATE, 6, 7)
weather_df$Day <- substr(weather_df$DATE, 9, 10)

traffic_df[c('Month', 'Day', 'Year')] <- str_split_fixed(traffic_df$CRASH_DATE, '/', 3)
traffic_df$Year <- substr(traffic_df$Year, 1, 2)

traffic_df$Big_damage[traffic_df$DAMAGE == 'OVER $1,500'] <- 1
traffic_df$Big_damage[traffic_df$DAMAGE != 'OVER $1,500'] <- 0

combo_df <- merge(traffic_df, weather_df, by = c('Year', 'Month', 'Day'))

# df of year and number of big accident
combo_scatter_df <- select(combo_df, Year, Month, Day, Big_damage)
combo_scatter_df <- filter(combo_scatter_df, Big_damage == 1)
combo_scatter_df <- group_by(combo_scatter_df, Year, Month, Day)
combo_scatter_df <- summarise(combo_scatter_df, Num_big_damage = sum(Big_damage))
combo_scatter_df$Date <- paste0(20, combo_scatter_df$Year, combo_scatter_df$Month, combo_scatter_df$Day)
combo_scatter_df$Year <- paste0(20, combo_scatter_df$Year)

# scatterplot of year and num of big damage
overall_trend_scatter <- function(year){
  if (year == "All of above"){
    combo_data = combo_scatter_df
  } else {
    combo_data = combo_scatter_df[combo_scatter_df$Year == year, ]
  }
  scatter <- ggplot(combo_data, aes(x=Date, y=Num_big_damage, group=1)) +
    geom_line() + geom_point() + labs(title = paste("The Overall Trend of number of Big Damage of Year", year)) +
    xlab("Date(Year, Month, Day)") + ylab("Number of Big Damage(USD)")
  return(scatter)
}

combo_bar_df <- group_by(combo_df, DAMAGE, ROADWAY_SURFACE_COND)
combo_bar_df <- summarise(combo_bar_df, Count = n())
combo_bar_df[nrow(combo_bar_df)+1, ] <- list("$500 OR LESS", "SAND, MUD, DIRT", 0)
combo_bar_df[nrow(combo_bar_df)+1, ] <- list("$501 - $1,500", "SAND, MUD, DIRT", 0)

contrast_bar_plot <- function(cond1, cond2){
  combo_bar_df = combo_bar_df[(combo_bar_df$ROADWAY_SURFACE_COND == cond1) | (combo_bar_df$ROADWAY_SURFACE_COND == cond2), ]
  print(combo_bar_df)
  p <- ggplot(data=combo_bar_df, aes(x=DAMAGE, y=Count, fill=ROADWAY_SURFACE_COND)) +
    geom_bar(stat="identity", color="black", position=position_dodge()) + 
    geom_text(aes(label=Count), vjust=1.6, position = position_dodge(0.9)) + theme_minimal() +
    ggtitle(paste("Compare number of damages of", cond1, "and", cond2, "roads"))
  return(p)
}

print(contrast_bar_plot("DRY", "SAND, MUD, DIRT"))

contrast_all <- function(){
  p <- ggplot(data=combo_bar_df, aes(x=DAMAGE, y=Count, fill=ROADWAY_SURFACE_COND)) +
    geom_bar(stat="identity", color="black", position=position_dodge()) + 
    geom_text(aes(label=Count), vjust=1.6, position = position_dodge(0.9)) + theme_minimal() +
    ggtitle("Compare number of damages of of different road surface conditions")
  return(p)
}


df_weather <- subset(combo_df, select = c(INJURIES_TOTAL, WEATHER_CONDITION))
df_weather_filtered <- subset(df_weather, INJURIES_TOTAL != 0)
aggregated_df <- aggregate(INJURIES_TOTAL ~ WEATHER_CONDITION, data = df_weather_filtered, FUN = sum)

df_road <- subset(combo_df, select = c(INJURIES_TOTAL, ROADWAY_SURFACE_COND))
df_road_filtered <- subset(df_road, INJURIES_TOTAL != 0)
aggregated_road_df <- aggregate(INJURIES_TOTAL ~ ROADWAY_SURFACE_COND, data = df_road_filtered, FUN = sum)




# write.csv(combo_df, "~/Desktop/haha/info201/Final project/combo_df.csv", row.names = FALSE)