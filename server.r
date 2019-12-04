# Load packages
library(shiny)
library(shinythemes)
library(lubridate)
library(dplyr)
library(ggplot2)
library(leaflet)
library(colourpicker)
library(plotly)

server <- function(input, output, session) {
  
  # You can access the value of the widget with input$checkGroup, e.g.
  output$value <- renderPrint({ input$select })
  
  # You can access the values of the widget (as a vector)
  # with input$checkGroup, e.g.
  output$value <- renderPrint({
    message_str <- paste0("To you, police brutality is: ", input$checkGroup)
    message_str
  })
  
  # set working directory to the file's location
  # code for setwd: setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
  
  # read the data of police shootings into data frame
  police_killings <- read.csv(file = "data/police-killings-with-latlng.csv",
                              stringsAsFactors = FALSE)
  
  # Enable the user to select/deselect all the choices
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
  
  # rename races to full name
  police_killings$race <- recode(police_killings$race,
                                 "W" = "Caucasian/White", 
                                 "B" = "African/African American", 
                                 "A" = "Asian/Asian American",
                                 "N" = "Native American",
                                 "H" = "Hispanic",
                                 "O" = "Other",
                                 .default = "Unknown")
  
  # factor races into levels for bar chart manipulation
  police_killings$race <- factor(police_killings$race,
                                 levels = c("Caucasian/White", "African/African American",
                                            "Asian/Asian American", "Native American",
                                            "Hispanic", "Other", "Unknown"))
  
  # recalculate the data for map every time user input is received
  # filter races and date, then group by region of user's choice
  # summarize into the number of deaths, center latitude and longitude
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
      summarize(state_name = first(full_state),
                deaths = n(),
                lat = sum(as.numeric(lat)/n()),
                lng = sum(as.numeric(lng)/n()))
  })
  
  # recalculate the data for map every time user input is received
  # filter races and date, then group by region the state is in
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
  
  
  # render the map with the center on the center of the US
  # each circle's size is calculated by how many deaths times 1 mile
  # label will be added
  output$map <- renderLeaflet({
    leaflet(data = killings_for_map()) %>%
      addProviderTiles("CartoDB.Positron") %>%
      setView(lng = -98.5795, lat = 39.8283, zoom = 4) %>%
      addCircles(
        lat = ~lat,
        lng = ~lng,
        radius = ~deaths * 1610,
        stroke = FALSE,
        label = sprintf(
          "<b>State:</b> %s<br><b>Deaths:</b> %g<br>",
          killings_for_map()$state_name,
          killings_for_map()$deaths
        ) %>%
          lapply(htmltools::HTML)
      )
  })
  
  # interactive plot for display
  plot_for_render <- reactive({
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
        labels = c("Caucasian/White", "African/African American", "Asian/Asian American",
                   "Native American", "Hispanic", "Other", "Unknown")
      )
  })
  
  # render the bar chart with x as the region groups and y as the amount of deaths
  # user can manipulate the races to be shown on here
  # label will be added
  output$plot <- renderPlotly({
    ggplotly(plot_for_render(), tooltip = "y")
  })
}
