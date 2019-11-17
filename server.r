# Load packages
library(shiny)
library(shinythemes)
library(lubridate)
library(dplyr)
library(ggplot2)
library(leaflet)

server <- function(input, output, session) {
  police_killings <- read.csv("data/police-killings.csv",
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
  
  # killings_by_state <- reactive({
  #   req(input$date)
  #   validate(need(!is.na(input$date[1]) & !is.na(input$date[2]),
  #                 "Error: Please provide both a start and an end date."))
  #   validate(need(input$date[1] < input$date[2],
  #                 "Error: Start date should be earlier than end date."))
  #   police_killings %>% 
  #     filter(date > as.POSIXct(input$date[1]) & date < as.POSIXct(input$date[2]),
  #            race == input$races) %>%
  #     group_by(state) %>%
  #     summarize(deaths = n())
  # })
  
  killings_by_region <- reactive({
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

  # output$map <- renderLeaflet({
  #   leaflet(data = killings_by_state, width = "100%") %>%
  #   addProviderTiles("CartoDB.Positron") %>%
  #   setView(lng = -98.5795, lat = 39.8283, zoom = 4) %>%
  #   addCircles(
  #     radius = 10000,
  #     stroke = FALSE
  #   )
  # })
  
  output$plot <- renderPlot({
    ggplot(data = killings_by_region(), 
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
