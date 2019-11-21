# Load packages
library(shiny)
library(shinythemes)
library(lubridate)
library(dplyr)
library(ggplot2)

server <- function(input, output) {
  police_killings <- read.csv("data/fatal-police-shootings-data.csv",
                              stringsAsFactors = FALSE)
  
  killings_by_state <- police_killings %>% 
    group_by(state)
}

function(input, output) {
  
  # You can access the value of the widget with input$select, e.g.
  output$value <- renderPrint({ input$select })
  
}
function(input, output) {
  
  # You can access the values of the widget (as a vector)
  # with input$checkGroup, e.g.
  output$value <- renderPrint({
    message_str <- paste0("To you, police brutality is: ", input$checkGroup)
    message_str
    })
  
}