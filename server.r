# Load packages
library(shiny)
library(shinythemes)
library(lubridate)
library(dplyr)
library(ggplot2)

server <- function(input, output, session) {
  police_killings <- read.csv("data/fatal-police-shootings-data.csv",
                              stringsAsFactors = FALSE)
  
  observe({
    updateCheckboxGroupInput(
      session, "races", choices = choices,
      selected = if (input$bar == "All") choices
    )
  })
  
  killings_by_state <- police_killings %>% 
    group_by(state)
}
