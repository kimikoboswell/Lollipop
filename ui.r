# Load packages
library(shiny)
library(shinythemes)
library(lubridate)
library(dplyr)
library(ggplot2)

ui <- fluidPage(
  theme = shinytheme("darkly"),
  titlePanel("Police Killings"),
  sidebarLayout(
    
  ),
  mainPanel(
    plotOutput(outputId = "")
  )
)