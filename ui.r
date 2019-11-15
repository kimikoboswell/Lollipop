# Load packages
library(shiny)
library(shinythemes)
library(lubridate)
library(dplyr)
library(ggplot2)

ui <- fluidPage(
  
  titlePanel("What is the Correlation of Police Killings?"),
  theme = shinytheme("darkly"),
  titlePanel("Police Killings"),
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput("races", strong("Races:"),
                         c("Caucasian" = "W",
                           "African" = "B",
                           "Asian" = "A",
                           "Native American" = "N",
                           "Hispanic" = "H",
                           "Other" = "O",
                           "Unknown" = "None"),
                         selected = c("W",
                                      "B",
                                      "A",
                                      "N",
                                      "H",
                                      "O",
                                      "None"),
                         inline = TRUE),
      dateRangeInput("date", strong("Date range:"), 
                     start = "2015-01-01", end = "2019-11-09",
                     min = "2015-01-01", max = "2019-11-09")
    ),
    mainPanel(
      plotOutput(outputId = "")
    )
  )
)