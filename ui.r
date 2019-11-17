# Load packages
library(shiny)
library(shinythemes)
library(lubridate)
library(dplyr)
library(ggplot2)
library(colourpicker)


intro_page <- tabPanel(
  "Introduction",
  sidebarLayout(
  sidebarPanel(
  h2("What is police brutality to you?"),
  fluidPage(
    
    # Copy the chunk below to make a group of checkboxes
    checkboxGroupInput("checkGroup", label = h3("Checkbox group"), 
                       choices = list("Excessive Force" = "excessive force", "Racial Profiling" = "racial profiling", "Police Perjury" = "police perjury", "Abuse of Authority" = "abuse of authority"),
                       selected = "select one"),
    
    
    hr(),
    fluidRow(column(12, verbatimTextOutput("value")))
    
  ),
    strong(sQuote("Most middle-class whites have no idea what if feels like to be subjected to police who are rountiely suspicous, rude, belligerent, and brutal")),
    p("- Dr. Benjamin Spock")
),
mainPanel(
  h1("Who is Most Likely to be Subjected by the Police Based on Regions in the U.S.?"),
  
  h4("Problem Situation"),
  p("Minorities have overwhemingly been subjected to police brutatlity"),
  h4("What is the Problem?"),
  p("Racial disparity amongst the victims of police violence"),
  h4("Why does it Matter?"),
  p("The U.S. should take action on the problem of instituionalized racism"),
  h4("How will it be Addressed?"),
  p("By analyzing data from police killings of 2018 and grouping the information by numerous factors such as race, age, gender, etc."),
  img("By Dillon Nettles, Policy Analyst, ACLU of Alabama", src = "https://www.aclu.org/sites/default/files/styles/blog_main_wide_580x384/public/field_image/web18-arrestbw-1160x768.jpg?itok=FxFI4Nhc"),
  imageOutput("myImage")
) 
)
)
shinyApp(ui = "ui.R", server = "server.R" )

background_page <- tabPanel(
  "Background",
  sidebarLayout(
  sidebarPanel(
    h2("Have you ever been subject to police brutality?"),
    fluidPage(
      
      # Copy the line below to make a select box 
      selectInput("select", label = h3("Select box"), 
                  choices = list("Select One" = 0, "Yes" = 1, "No" = 2, "I'm not sure" = 3), 
                  selected = 0)
    ),
    strong(sQuote("Justice cannont be something that one part of society inflicts on the other.")),
    p("- Cathy O'Neil, Weapons of Math Destruction")
    
),
mainPanel(
  h1("Why Did We Choose This Topic?"),
  img("Image by ep_jhu via Flickr Creative Commons", src = "https://fresnoalliance.com/wp-content/uploads/2015/01/15014376865_930e981546_b.jpg"),
  
  h2("Reserach Questions"),
  p("1. What is the racial breakdown of police shooting victims?"),
  p("2. Is there a disparity between races killed by police?"),
  p("3. Which region has the highest amount of shootings?"),
  p("4. Which region has the highest amount of shootings per race?")
)
)
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
      "main panel"
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
  theme = shinytheme("darkly"),
  "Police Brutality",
  intro_page,
  background_page,
  visualizations_page,
  conclusion_page,
  tech_page,
  us_page
)
