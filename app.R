library(shiny)
library(plotly)
source("final project.R")

ui <- navbarPage("Info201!",
                 tabPanel("Introduction",
                          titlePanel("Welcome to the Traffic Analysis Dashboard!"),
                          br(),
                          fluidRow(
                            column(
                              width = 6,
                              img(src = "traffic.jpeg", height = 100)
                            ),
                            column(
                              width = 6,
                              p("Discover Insights from Traffic Data"),
                              p("Gain a Deeper Understanding of Traffic Patterns"),
                              p("Explore the Factors Contributing to Accidents"),
                              p("Make Data-Informed Decisions to Improve Road Safety"),
                              br(),
                              p("The Traffic Analysis Dashboard is a powerful tool designed to provide you with valuable insights into traffic data. Whether you are a traffic analyst, transportation planner, or simply interested in understanding traffic patterns, this dashboard will help you unlock the potential of your data."),
                              p("Through interactive visualizations and data exploration, you can uncover trends, spot patterns, and identify factors that contribute to accidents. This information can guide your decision-making process and support efforts to enhance road safety."),
                              br(),
                              p("To get started, simply click the 'Get Started' button below. We invite you to explore the various tabs and interact with the visualizations to gain a comprehensive understanding of the data."),
                              br(),
                              actionButton(
                                inputId = "get_started",
                                label = "Get Started",
                                icon = icon("arrow-right")
                              )
                            )
                          )
                 ),
  tabPanel("Change over time",
    titlePanel("Examining the Trend of Big Damage Over Time"),
    
    br(),
    
    p("Let's examine the trend of car accidents over year 2019 to year 2022 in United States, and explore how new traffic polices change the traffic situation."),
    br(),
    
    p("In year 2019, stricter drunk driving laws are implemented. Also, speed cameras are introduced to enforce speed limit.
      Bike lanes and infrastructure are improved to enhance the safety level of cycling."),
    
    br(),
    
    p("In year 2020, congestion pricing schemes are introduced in some cities. Stricter distracted driving laws are enforced to enhance driving safety."),
    
    br(),
    
    p("In year 2021, in order to eliminate traffic fatalities and serious injuries, Vision Zero policies are adopted.
      Stricter rules on micromobility devices is introduced. "),
    
    br(),
    
    p("In year 2022, new blood-alcohol level is introduced, which lower from 0.08 to 0.05. Also, right turn on red lights are prohibitted. In addition, speed camera in work zone are installed."),
    
    sidebarLayout(
      sidebarPanel(
        radioButtons(
          inputId = "Year",
          label = "Select a Year",
          choices = list(2019, 2020, 2021, 2022, "All of above")
        )
      ),
      mainPanel(
        plotlyOutput("scatter_of_year")
      )
    )
  ),
  tabPanel("Contrast",
    titlePanel("The Contrast of Different Road Condition's Damages"),
    
    br(), # the br() function adss line breaks
    
    p("Let's examine the pattern of the count of damages at different level of damages for different road type "),
    br(),
    
    h4("Which pair do you want to compare?"),
    sidebarLayout(
      sidebarPanel(
        selectInput(
          inputId = "road_condition_1",
          label = "Select one",
          choices = list("DRY", "ICE", "OTHER", "SAND, MUD, DIRT", "SNOW OR SLUSH", "UNKNOWN", "WET")
        ),
        selectInput(
          inputId = "road_condition_2",
          label = "Select another",
          choices = list("DRY", "ICE", "OTHER", "SAND, MUD, DIRT", "SNOW OR SLUSH", "UNKNOWN", "WET")
        )
      ),
      mainPanel(
        plotlyOutput("box_plot_compare")
      )
    ),
    sidebarLayout(
      sidebarPanel(
        checkboxInput(
          inputId = "road_condition_all",
          label = "Put everything together?",
          value = FALSE
        )
      ),
      mainPanel(
        plotlyOutput("box_plot_everything")
      )
    )
  ),
  tabPanel("Factor",
           titlePanel("Analysis of Factors Influencing Injury Counts"),
           br(),
           h3("Explore Injuries by Posted Speed Limit: Select a Speed Limit from the Dropdown to Visualize the Impact on Injury Counts"),
           p("The highest injury count was observed at a posted speed limit of 30 mph. This could be attributed to the prevalence of 30 mph speed limits on non-highway roads, where accidents involving pedestrians and cyclists are more likely. Additionally, the commonality of the 30 mph limit across different areas might lead some drivers to exceed this speed, contributing to the high injury rate. Conversely, the lower injury counts on roads with higher speed limits, such as 50 or 55 mph, can be explained by their implementation on highways with controlled traffic flow. The occurrence of injuries at 0 mph suggests rear-end collisions, where stationary vehicles are struck by others failing to stop in time. These findings emphasize the importance of road safety measures, driver education, and attentive driving practices to reduce accidents and injuries across various speed limits."),
           br(),
           br(),
           selectInput("speed_limit", "Select Posted Speed Limit:",
                       choices = c(0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55),
                       selected = 30),
           plotlyOutput("injuriesPlot", width = 500, height = 200),
           br(),
           br(),
           
           h3("Explore Injuries by Weather Condition: Select a Weather Condition from the Dropdown to Visualize the Impact on Injury Counts"),
           p("An analysis of the data reveals that there are more injuries reported when the weather condition is clear, which may suggest that more people feel comfortable driving when the weather is favorable. This finding could be indicative of the usual climate in the analyzed area, where clear weather conditions are more prevalent compared to rain or snow. The higher injury count during clear weather conditions underscores the importance of maintaining caution and safe driving practices even when weather conditions are favorable. It is crucial to recognize that clear weather does not eliminate the potential for accidents and injuries, and drivers should remain vigilant regardless of the weather conditions."),
           br(),
           br(),
           selectInput("weather_condition", "Select Weather Condition:",
                       choices = c("BLOWING SNOW", "CLEAR", "CLOUDY/OVERCAST", "FOG/SMOKE/HAZE", "FREEZING RAIN/DRIZZLE", "OTHER", "RAIN", "SLEET/HAIL", "SNOW", "UNKNOWN"),
                       selected = "RAIN"),
           plotlyOutput("weatherPlot", width = 500, height = 200),
           br(),
           br(),
           
           h3("Explore Injuries by Road Condition: Select a Road Condition from the Dropdown to Visualize the Impact on Injury Counts"),
           p("In the analysis, it was found that the highest number of accidents occurred on dry roads, while the occurrence of accidents was lower during rainy conditions. Several factors could contribute to this observation. The analysis might reflect the usual climate patterns of the analyzed region, where dry road conditions are more prevalent compared to rainy conditions. Also, drivers may adjust their behavior and exercise more caution when driving in wet conditions.Wet roads can still pose risks, such as hydroplaning or reduced visibility, which can lead to accidents if drivers do not adapt their driving behavior accordingly. "),
           br(),
           br(),
           selectInput("road_condition", "Select Road Condition:",
                       choices = c("DRY", "ICE", "WET", "OTHER", "SNOW OR SLUSH", "UNKNOWN", "WET"),
                       selected = "DRY"),
           plotlyOutput("roadPlot", width = 500, height = 200),
           br(),
           br(),
           
           h3("Explore Injuries by Light Condition: Select a Light Condition from the Dropdown to Visualize the Impact on Injury Counts"),
           p("The analysis of the data reveals interesting trends in injury occurrence based on lighting conditions. Fewer injuries are reported during daylight hours compared to well-lit darkness, indicating that people feel more comfortable driving in the daytime when visibility is higher. This highlights the importance of good lighting infrastructure for road safety. Also, the lowest number of injuries occurs during darkness with no lights, indicating that well-illuminated roads or streetlights contribute to safer driving conditions. Adequate lighting plays a significant role in reducing the likelihood of accidents. In terms of time, the least number of injuries occurs at dawn, which can be attributed to lower traffic volume and reduced activity during that time. This suggests that fewer people venture out on the roads during the early morning hours, resulting in a lower risk of accidents."),
           selectInput("light_condition", "Select Light Condition:",
                       choices = c("DUSK", "DAYLIGHT", "UNKNOWN", "DARKNESS, LIGHTED ROAD", "DAWN", "DARKNESS"),
                       selected = "DAWN"),
           plotlyOutput("lightPlot", width = 500, height = 200),
           br(),
           br(),
           
           h3("Explore Injuries by the Type of Crash: Select a Type of Crash from the Dropdown to Visualize the Impact on Injury Counts"),
           p("The analysis reveals that rear-end and angle crashes are responsible for the highest number of injuries. These types of collisions pose significant risks to road safety. Rear-end crashes occur when one vehicle hits the back of another, often due to factors like distracted driving or tailgating. Angle crashes involve vehicles colliding at an angle, often at intersections, due to factors like failure to yield or misjudgment. Addressing these issues requires promoting attentive driving, improving intersection safety, and enforcing traffic regulations to reduce injuries in these types of crashes."),
           selectInput("crash_type", "Select Crash Type:",
                       choices = c("TURNING", "PEDALCYCLIST", "PEDESTRIAN", "FIXED OBJECT", "ANGLE", "SIDESWIPE SAME DIRECTION", "PARKED MOTOR VEHICLE", "REAR END", "SIDESWIPE OPPOSITE DIRECTION", "HEAD ON", "OTHER NONCOLLISION", "OTHER OBJECT", "OVERTURNED","REAR TO REAR", "REAR TO SIDE", "REAR TO FRONT"),
                       selected = "TURNING"),
           plotlyOutput("crashPlot", width = 500, height = 200),
           
  ),

  tabPanel("Summary",
    titlePanel("Summary takeways!"),
    br(),
    h4("In this project, we explore different factors that impact the traffic conditions.
       For Change over time, we explore how public policies of traffic impact the amount of big traffic damages.
       For Contrast, we explore the how road surface condition impact the traffic accidents.
       For Factors, we explore various factors that influence traffic conditions, including driver behavior, vehicle characteristics, and environmental factors. By studying these factors, we aim to identify the key contributors to traffic accidents and develop strategies to mitigate their impact."),
    br(),
    h5("What we found after doing all of the analysis is that: "),
    h5("According to the scatterplot of number of big damages of year 2019, 2020, 2021, 2022, 
        we found that number of big damages is lowest on 2021, and highest on 2022. 
        This shows that Vision Zero policies is effective, but the new alcohol-blood level policies doesn't effecive.
        According to bar plot of number of damages of different road condition, 
        dry road is the road condition type that happens most traffic damages. The analysis of factors influencing injury counts reveals several key findings. The highest injury count occurs at a posted speed limit of 30 mph, likely due to its prevalence on non-highway roads and potential for exceeding the limit. Clear weather conditions are associated with more injuries, indicating drivers' increased comfort and the usual climate patterns of the analyzed area. Dry road conditions have the highest number of accidents, highlighting the need for caution even in non-adverse weather. Fewer injuries occur during daylight hours, emphasizing the importance of good lighting infrastructure. Rear-end and angle crashes result in the most injuries, underscoring the need to address factors like distracted driving and failure to yield. Overall, the findings stress the significance of adhering to speed limits, driving attentively in all weather conditions, and promoting safer behaviors to reduce accidents and injuries on the road.")
  )
  
)



server <- function(input, output) {
  output$scatter_of_year <- renderPlotly({
    return(overall_trend_scatter(input$Year))
  })
  
  output$box_plot_compare <- renderPlotly({
    return(contrast_bar_plot(input$road_condition_1, input$road_condition_2))
  })
  
  output$box_plot_everything <- renderPlotly({
    if (input$road_condition_all == TRUE){
      return(contrast_all())
    }
  })
  
  output$injuriesPlot <- renderPlotly({
    # Filter the data based on the selected speed limit
    filtered_df <- subset(combo_df, POSTED_SPEED_LIMIT == input$speed_limit)
    
    grouped_df <- aggregate(INJURIES_TOTAL ~ POSTED_SPEED_LIMIT, data = filtered_df, FUN = sum)
    
    plot <- ggplot(grouped_df, aes(x = factor(POSTED_SPEED_LIMIT), y = INJURIES_TOTAL)) +
      geom_bar(stat = "identity", fill = "darkgreen") +
      geom_text(aes(label = INJURIES_TOTAL), position = position_stack(vjust = 0.5), color = "white") +
      labs(x = "Posted Speed Limit", y = "Total Number of Injuries") +
      theme_bw()
    
    plotly_obj <- ggplotly(plot)
    
    return(plotly_obj)
  })
  
  output$weatherPlot <- renderPlotly({
    df_weather <- subset(combo_df, select = c(INJURIES_TOTAL, WEATHER_CONDITION))
    df_weather_filtered <- subset(df_weather, INJURIES_TOTAL != 0)
    aggregated_df <- aggregate(INJURIES_TOTAL ~ WEATHER_CONDITION, data = df_weather_filtered, FUN = sum)
    
    selected_weather <- input$weather_condition
    
    filtered_aggregated_df <- subset(aggregated_df, WEATHER_CONDITION == selected_weather)
    
    plot2 <- ggplot(filtered_aggregated_df, aes(x = WEATHER_CONDITION, y = INJURIES_TOTAL)) +
      geom_bar(stat = "identity", fill = "steelblue") +
      labs(x = "Weather Condition", y = "Total Number of Injuries") +
      geom_text(aes(label = INJURIES_TOTAL), position = position_stack(vjust = 0.5), color = "white") +
      theme_bw()
    
    plotly_object <- ggplotly(plot2)
    
    return(plotly_object)
  })
  output$roadPlot <- renderPlotly({
    df_road <- subset(combo_df, select = c(INJURIES_TOTAL, ROADWAY_SURFACE_COND))
    df_road_filtered <- subset(df_road, INJURIES_TOTAL != 0)
    aggregated_road_df <- aggregate(INJURIES_TOTAL ~ ROADWAY_SURFACE_COND, data = df_road_filtered, FUN = sum)
    
    selected_road_condition <- input$road_condition
    
    filtered_aggregated_road_df <- subset(aggregated_road_df, ROADWAY_SURFACE_COND == selected_road_condition)
    
    plot3 <- ggplot(filtered_aggregated_road_df, aes(x = ROADWAY_SURFACE_COND, y = INJURIES_TOTAL)) +
      geom_bar(stat = "identity", fill = "pink") +
      labs(x = "Road Condition", y = "Total Number of Injuries") +
      geom_text(aes(label = INJURIES_TOTAL), position = position_stack(vjust = 0.5), color = "white") +
      theme_bw()
    
    plotly_object3 <- ggplotly(plot3)
    
    return(plotly_object3)
  })
  
  output$lightPlot <- renderPlotly({
    df_light <- subset(combo_df, select = c(INJURIES_TOTAL, LIGHTING_CONDITION))
    df_light_filtered <- subset(df_light, INJURIES_TOTAL != 0)
    aggregated_light_df <- aggregate(INJURIES_TOTAL ~ LIGHTING_CONDITION, data = df_light_filtered, FUN = sum)
    
    selected_light_condition <- input$light_condition
    
    filtered_aggregated_light_df <- subset(aggregated_light_df, LIGHTING_CONDITION == selected_light_condition)
    
    plot4 <- ggplot(filtered_aggregated_light_df, aes(x = LIGHTING_CONDITION, y = INJURIES_TOTAL)) +
      geom_bar(stat = "identity", fill = "orange3") +
      labs(x = "Light Condition", y = "Total Number of Injuries") +
      geom_text(aes(label = INJURIES_TOTAL), position = position_stack(vjust = 0.5), color = "white") +
      theme_bw()
    
    plotly_object4 <- ggplotly(plot4)
    
    return(plotly_object4)
  })
  
  output$crashPlot <- renderPlotly({
    df_crash <- subset(combo_df, select = c(INJURIES_TOTAL, FIRST_CRASH_TYPE))
    df_crash_filtered <- subset(df_crash, INJURIES_TOTAL != 0)
    aggregated_crash_df <- aggregate(INJURIES_TOTAL ~ FIRST_CRASH_TYPE, data = df_crash_filtered, FUN = sum)
    
    selected_crash_type <- input$crash_type
    
    filtered_aggregated_crash_df <- subset(aggregated_crash_df, FIRST_CRASH_TYPE == selected_crash_type)
    
    plot5 <- ggplot(filtered_aggregated_crash_df, aes(x = FIRST_CRASH_TYPE, y = INJURIES_TOTAL)) +
      geom_bar(stat = "identity", fill = "red4") +
      labs(x = "Crash Type", y = "Total Number of Injuries") +
      geom_text(aes(label = INJURIES_TOTAL), position = position_stack(vjust = 0.5), color = "white") +
      theme_bw()
    
    plotly_object5 <- ggplotly(plot5)
    
    return(plotly_object5)
  })
  

}


shinyApp(ui = ui, server = server)