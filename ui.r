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
    choices = list("Excessive Force" = "excessive force", "Racial Profiling"
         = "racial profiling", "Police Perjury" = "police perjury",
                    "Abuse of Authority" = "abuse of authority"),
                       selected = "select one"),
    hr(),
    fluidRow(column(11, verbatimTextOutput("value")))
  ),
    img(src = "https://encrypted-tbn0.gstatic.com/images?q=tbn:
        ANd9GcTiJwGkdahnf7RFU373y8To-Z5th93SRtZugPMBDbljknH2lFeBSQ&s"
        , height = "100%", width = "100%", align = "center"),
    p("Photo by Amanda Pickett"),
    h4(strong(sQuote("Most middle-class whites have no idea
                     what if feels like to be subjected to police
                     who are rountiely suspicous, rude, belligerent,
                     and brutal"))),
    p("- Dr. Benjamin Spock")
),
mainPanel(
  h1("Who is Most Likely to be Subjected
     by the Police Based on Regions in the U.S.?"),
  h4("Problem Situation"),
  tags$head(tags$style('h4 {color:red;}')),
  tags$li(p("Minorities have overwhemingly been subjected to police brutatlity")),
  h4("What is the Problem?"),
  tags$li(p("Racial disparity amongst the victims of police violence")),
  h4("Why does it Matter?"),
  tags$li(p("The U.S. should take action on the problem of instituionalized racism")),
  h4("How will it be Addressed?" ),
  tags$li(p("By analyzing data from police killings of 2018 and
    grouping the information by numerous factors such
    as race, age, gender, etc.")),
  img(src = "https://www.aclu.org/sites/default/files/styles/blog_main_wide_580x384/public/field_image/web18-arrestbw-1160x768.jpg?itok=FxFI4Nhc"
      , height = "50%",
      width = "50%", align = "center"),
  p("Photo by Dillon Nettles, Policy Analyst, ACLU of Alabama")
)
)
)

background_page <- tabPanel(
  "Background",
  sidebarLayout(
  sidebarPanel(
    h2("Have you ever been subject to police brutality?"),
    fluidPage(
      # Copy the line below to make a select box
      selectInput("select", label = h3("Select box"),
                  choices = list("Select One" = 0,
                                 "Yes" = 1, "No" = 2, "I'm not sure" = 3),
                  selected = 0)
    ),
    img(src = "https://encrypted-tbn0.gstatic.com/images
        ?q=tbn:ANd9GcTd4k7eqgSiQS60TbbWW2zaJQEQH27
        mRejmDyPEUslCnw7Zs0iktQ&s",
        height = "50%", width = "50%"),
    p("Photo by Charles Pulliam-Moore"),
    h4(strong(sQuote("Justice cannont be something
                     that one part of society inflicts on the other."))),
    p("- Cathy O'Neil, Weapons of Math Destruction")
),
mainPanel(
  h1("Why Did We Choose This Topic?"),
  tags$div(
    tags$ul(
      tags$li("Hundreds of unarmed people have lost their 
              lives at the hands of police officers"),
      tags$li("Racial disparity in 
              the United States is right before our eyes"),
      tags$li("Differences in race, religion,
              politics, etc. exist between police and citizen"),
      tags$li("Drastic changes are needed in our approach to public safety")
    )
  ),
  img(src = "https://fresnoalliance.com/wp-content/uploads/2015/01/15014376865_930e981546_b.jpg"
      , height = "50%", width = "50%", align = "center"),
  p("Image by ep_jhu via Flickr Creative Commons"),
  h2("Research Questions"),
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
                         c("Select all" = "All",
                           "Caucasian" = "W",
                           "African" = "B",
                           "Asian" = "A",
                           "Native American" = "N",
                           "Hispanic" = "H",
                           "Other" = "O",
                           "Unknown" = "None"),
                         selected = c("All",
                                      "W",
                                      "B",
                                      "A",
                                      "N",
                                      "H",
                                      "O",
                                      "None"),
                         inline = TRUE),
<<<<<<< HEAD
      
      dateRangeInput("date", strong("Date range:"), 
=======
      dateRangeInput("date", strong("Date range:"),
>>>>>>> cde41926146c84cc18ce1e10a30c0860d8f3a8ba
                     start = "2015-01-01", end = "2019-11-09",
                     min = "2015-01-01", max = "2019-11-09")
    ),
    mainPanel(
      "main panel"
    )
    )
  )
# for following section, need to add photos
conclusion_page <- tabPanel(
  "Conclusion",
  h1 ("Conclusion"),
  p("This project gave us an opportunity
      to work on our coding and teamwork skills.
      With that said, it definetly had it's ups
      and downs. "),
  h3("Strengths"),
  p("-We were able to divide tasks based on what
     each of us was good on. Tung was very helpful
     with visualization creation. Autumn worked extensively
     to create a functioning website. Kimiko went through and 
     filled in the back end of the report, as well as 
     update the proposal to reflect our current project."),
  p("-Despite having very different schedules, we all managed
     to meet and finish our assigned tasks"),
  h3("Weaknesses"),
  p("-Our original dataset and thesis were faulty and we had to
     play a game of catch up, trying to find a new dataset."),
  p("-We all had different schedules, and it was hard to find
     times were we could all meet."),
  p("-Creating a substantial visualization was hard because we were
     missing information to make the type of visualization we wanted to
     make at first."),
  h3("Lessons"),
  p("We learned quite a bit from doing this project. We learned how 
     data can be hard to manipulate, and how it is important to find 
     datasets which fit our overall plan. We also learned the importance
     of communicating when merging, especially if on the same branch. 
     Finally, we learned the importance about consistent communication
     to make sure everyone is getting their part done and that no 
     question remain unasked."),
  h3("Future Work"),
  p("There is a lot of potential for our work to 
     be used in the future by us or by someone else. We simply
     highlighted aspects of Police Brutality within the U.S.
     for one year. Someone could analyze it for multiple years
     and maybe pull a conclusion about the fluctuation ins police 
     brutality rates. They could then take it a step further
     by adding the real world context to explain the fluctuations
     in police shootings."),
  h2("References"),
  h5("Fatal Force: 2018 Police Shootings Database.,
     The Washington Post, WP Company,
     https://www.washingtonpost.com/graphics/
     2018/national/police-shootings-2018/."),
)
#Input table or representation of all columnnames
tech_page <- tabPanel(
  "About the Tech (Appendix 1)",
  h2("Label Names"),
  h5("The following section explains the names
     of the columns in our dataset and what each
     column means."),
  p(strong("name:"),"This column contains the name
    of the victim of police violence."),
  p(strong("date:"),"This column contains the date
    which the victim died."),
  p(strong("manner_of_death:"),"This column briefly
    explains how the victim died(ex:shot, tasered"),
  p(strong("armed:"),"This column states whether
    the victim was armed and with what."),
  p(strong("age:"),"This column contains the 
    victim's name."),
  p(strong("gender:"),"This column contains the 
    gender of the victim"),
  p(strong("race:"),"This column contains the race
    of the victim"),
  p(strong("city:"),"This column contains the city
    where the victim was killed."),
  p(strong("state:"),"This column contains the state
    where the victim was killed."),
  p(strong("signs_of_mental_illness:"),"This column 
    explains whether the victim had am ental illness"),
  p(strong("threat_level:"),"This column explains
    the threat they gave to supposedly instigate
    the shooting."),
  p(strong("flee:"),"This column describes
    whether the victim was fleeing or not and how."),
  p(strong("body_camera:"),"This column answers
    whether a body camera was present on the cop
    at the time of the shooting."),
)
#Find a way to use photos from files
us_page <- tabPanel(
  "About Us",
  h1("Team Members"),
  h3("Autumn Rausch"),
  h5("Freshman studying
     Informatics, and Criminology"),
  #following header is for Autumn's bio
  p("From this project I realized one of numerous observations. 
     The first is, there are more unarmed police killings than  
     I ever thought imaginable. 
     The second is the race disparity is quite large. 
     Police brutality is a serious issue that has even more serious outcomes. 
     The most satisfactory part of the project was seeing all 
     of our current ideas come to life through shiny. 
     One of the most unsatisfactory run-ins was a simple g
     rammatical error throwing off the whole page of code created. 
     For the future this project opened a gateway to
     creativity. With every new task, we grow as creators,
     inventors, and coders."),
  h3("Kimiko Boswell"),
  h5("Senior studying International
     Studies, Immigration, and Informatics"),
  p("After doing this assignment, I learned how to
     effectively create a website using shiny and utilize
     datasources to come to conclusions. I was really frustrated
     with the merging process, but it felt so satisfying when
     the website worked and I got to see all the hard work me and 
     especially my teammates put in. In regards to the data, I was
     surprised by the outcome of our question. To see such a large
     amount of police violence in my home state (California) was very
     alarming. Although I understand that there are more police forces
     and residents in California in most states, I still think it is 
     saddening to see such a presence of police violence in that area."),
  h3("Tung Netmaneesuk"),
  h5("Junior studying Psychology"),
  #following header is for Tung's bio
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
