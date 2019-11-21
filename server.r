# Load packages
library(shiny)
library(shinythemes)
library(lubridate)
library(dplyr)
library(ggplot2)
library(leaflet)

server <- function(input, output, session) {
  police_killings <- read.csv("data/police-killings-with-latlng.csv",
                              stringsAsFactors = FALSE)
  
  # myChoices <- c("Select all" = "All",
  #                "Caucasian" = "W",
  #                "African" = "B",
  #                "Asian" = "A",
  #                "Native American" = "N",
  #                "Hispanic" = "H",
  #                "Other" = "O",
  #                "Unknown" = "None")
  # 
  # observe({
  #   if (input$races == 0) {
  #     updateCheckboxGroupInput(
  #       session, "races", strong("Races:"), choices = myChoices,
  #       selected = setdiff(myChoices, "All")
  #     )
  #   }
  # })
  # 
  
  police_killings$race <- factor(police_killings$race,
                                    levels = c("W", "B", "A", "N", "H", "O", ""))
  
  killings_for_map <- reactive({
    req(input$date)
    validate(need(!is.na(input$date[1]) & !is.na(input$date[2]),
                  "Error: Please provide both a start and an end date."))
    validate(need(input$date[1] < input$date[2],
                  "Error: Start date should be earlier than end date."))
    police_killings %>%
      filter(race %in% input$races,
             date > as.POSIXct(input$date[1]) & date < as.POSIXct(input$date[2])) %>%
      group_by(state) %>%
      summarize(deaths = n(),
                lat = sum(as.numeric(lat)/n()),
                lng = sum(as.numeric(lng)/n()))
  })
  
  killings_for_plot <- reactive({
    req(input$date)
    validate(need(!is.na(input$date[1]) & !is.na(input$date[2]),
                  "Error: Please provide both a start and an end date."))
    validate(need(input$date[1] < input$date[2],
                  "Error: Start date should be earlier than end date."))
    police_killings %>% 
      filter(race %in% input$races,
             date > as.POSIXct(input$date[1]) & date < as.POSIXct(input$date[2])) %>%
      group_by(region)
  })

  output$map <- renderLeaflet({
    leaflet(data = killings_for_map) %>%
    addProviderTiles("CartoDB.Positron") %>%
    setView(lng = -98.5795, lat = 39.8283, zoom = 4) %>%
    addCircles(
      lat = ~lat,
      lng = ~lng,
      radius = ~death * 1610,
      stroke = FALSE
    )
  })
  
  output$plot <- renderPlot({
    ggplot(data = killings_for_plot(),
           aes(region, fill = race)) +
      geom_bar(stat = "count", position = "dodge") +
      labs(x = "Region",
           y = "Deaths",
           title = "Deaths by Police Shootings") +
      scale_fill_manual(
        name = "Races",
        values = c("#800080", "#4b0082", "#0000ff", "#00ff00", "#ffff00",
                   "#ffa500", "#ff0000"),
        breaks = c("W", "B", "A", "N", "H", "O", ""),
        labels = c("Caucasian", "African", "Asian", "Native American",
                   "Hispanic", "Other", "Unknown")
      )
  })
}
