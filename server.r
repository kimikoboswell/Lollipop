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
output_server <- function(input, output) {
  output$message <- renderText({
    message_str <- paste0("You guessed ", input$guess, " people were killed in 2018, but actually in total 1140 people were killed. ")
    message_str
  })
}