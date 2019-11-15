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
