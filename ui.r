# Load packages
library(shiny)
library(shinythemes)
library(lubridate)
library(dplyr)
library(ggplot2)


intro_page <- tabPanel(
  "Introduction",
  sidebarLayout(
  sidebarPanel(
  h2("How many people were killed in 2018?"),
  textInput(inputId = "guess", label = "What is your guess?"),
  textOutput(outputId = "message")
),
mainPanel(
  "mainpanel"
)
)
)
shinyApp(ui = "ui.R", server = "server.R" )

background_page <- tabPanel(
  "Background",
  h1("Why Did We Choose This Topic?"),
  h2("Dispariy Within the United States")
)

visualizations_page <- tabPanel(
  "Visualizations",
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

conclusion_page <- tabPanel(
  "Conclusion"
)

tech_page <- tabPanel(
  "About the Tech"
)

us_page <- tabPanel(
  "About Us"
)

ui <- navbarPage(
  "Our Shiny App",
  intro_page,
  background_page,
  visualizations_page,
  conclusion_page,
  tech_page,
  us_page
)
