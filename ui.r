# Load packages
library(shiny)
library(shinythemes)
library(lubridate)
library(dplyr)
library(ggplot2)
library(leaflet)
library(colourpicker)
library(plotly)

intro_page <- tabPanel(
  "Introduction",
  sidebarLayout(
    sidebarPanel(
      h2("What is police brutality to you?"),
      fluidPage(
        checkboxGroupInput("checkGroup", label = h3("Your opinion: "),
                           choices = list("Excessive Force" = "excessive force",
                                          "Racial Profiling" = "racial profiling",
                                          "Police Perjury" = "police perjury",
                                          "Abuse of Authority" = "abuse of authority"),
                           selected = "select one"),
        hr(),
        fluidRow(column(11, verbatimTextOutput("value")))
      ),
      img(src = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTiJwGkdahnf7RFU373y8To-Z5th93SRtZugPMBDbljknH2lFeBSQ&s",
          height = "100%", width = "100%", align = "center"),
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
      tags$li("Minorities have overwhemingly been subjected to police brutatlity"),
      h4("What is the Problem?"),
      tags$li("Racial disparity amongst the victims of police violence"),
      h4("Why does it Matter?"),
      tags$li("The U.S. should take action on the problem of institutionalized racism"),
      h4("How will it be Addressed?" ),
      tags$li("By analyzing data from a police killings database and
              grouping the racial and location data to create
              a graph and map that will provide visual answers to our questions."),
      br(),
      img(src = "https://www.aclu.org/sites/default/files/styles/blog_main_wide_580x384/public/field_image/web18-arrestbw-1160x768.jpg?itok=FxFI4Nhc",
          height = "50%", width = "50%", align = "center"),
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
      img(src = "https://fresnoalliance.com/wp-content/uploads/2015/01/15014376865_930e981546_b.jpg",
          height = "50%", width = "50%", align = "center"),
      p("Image by ep_jhu via Flickr Creative Commons"),
      h2("Research Questions"),
      p("1. What is the racial breakdown of police shooting victims?"),
      p("2. Is there a disparity between races killed by police?"),
      p("3. Which state has the highest amount of shootings?"),
      p("4. Can this data be misleading?")
    )
  )
)

# page with all interactive visualizations
visualizations_page <- tabPanel(
  "Visualizations",
  titlePanel("Police Killings"),
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput("races", strong("Races:"),
                         c("Caucasian/White",
                           "African/African American",
                           "Asian/Asian American",
                           "Native American",
                           "Hispanic",
                           "Other",
                           "Unknown"),
                         selected = c("Caucasian/White",
                                      "African/African American",
                                      "Asian/Asian American",
                                      "Native American",
                                      "Hispanic",
                                      "Other",
                                      "Unknown"),
                         inline = TRUE),
      dateRangeInput("date", strong("Date range:"), 
                     start = "2015-01-01", end = "2019-11-09",
                     min = "2015-01-01", max = "2019-11-09")
    ),
    mainPanel(
      tabsetPanel(
        tabPanel(
          h4("Deaths by Race"),
          plotlyOutput(outputId = "plot"),
          tags$p("At first glance, this graph merely shows us that the white ",
          "population has the highest killing numbers overall, with ",
          "the black population being second. However, when you consider the ",
          "reality that the white population makes up 70% of the United States ",
          "and the black population only makes up 13.4% of the population, ",
          "the fact that the two killing numbers are so close paints a ",
          "new image.")
        ),
        tabPanel(
          h4("Deaths by State"),
          leafletOutput(outputId = "map"),
          tags$p("The same concept applied to the previous graph can be ",
          "applied to this map, in a state-by-state way. Toggling around with ",
          "the breakdown of the number of deaths by state you can see similar ",
          "sized circles between black and white killing numbers. Additionally, ",
          "when looking at the killings by state, one may think California has ",
          "an absurdly high number of killings compared to other states. ",
          "However, California also has one of the highest state populations ",
          "in the country, which again shows how first glance data can be misleading.")
        )
      )
    )
  )
)

# for following section, need to add photos
conclusion_page <- tabPanel(
  "Conclusion",
  sidebarLayout(
    sidebarPanel(
      h2("Did your idea of police brutality change throughout our presentation?"),
      fluidPage(
        radioButtons("radio", label = h3("Answer:"),
                     choices = list("Yes" = "yes",
                                    "No" = "no",
                                    "A little" = "a little"),
                     selected = "select one"),
        hr(),
        fluidRow(column(11, verbatimTextOutput("value2")))
      )
    ),
    mainPanel(
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
         2018/national/police-shootings-2018/.")
    )
  )
)

#Input table or representation of all columnnames
tech_page <- tabPanel(
  "About the Tech (Appendix 1)",
  sidebarLayout(
    sidebarPanel(
      h2("Which R package do you think helped us the most?"),
      fluidPage(
        radioButtons("radio2", label = h3("Answer:"),
                     choices = list("Dplyr" = "dplyr was",
                                    "Shiny" = "shiny was",
                                    "GGPlot2" = "ggplot2 was",
                                    "All of the above" = "all of them")),
        hr(),
        fluidRow(column(11, htmlOutput("value3")))
      )
    ),
    mainPanel(
      h4(em("To learn more about our project and it's composition, read our
    technical report:",tags$a(href = "https://github.com/kimikoboswell/Lollipop/wiki/Technical-Report",
                              "Technical Report"))),
      p("In this project, we utilized the R shiny package to create a website.
    the website's theme was created using the shinythemes package- specifically
    the",em("darkly"),"theme to create a serious, and dark atmosphere."),
      p("To create the visualizations you see in the previous tab, we used
    an array of packages, including dplyr, ggplot, leaflet, lubridate, 
    colourpicker, and plotly. These packages allowed us to wrangle data, and 
    create the map and chart which were used to show our findings."),
      p("The last technology tool, though not on a computer, was the Envisioning
    Cards. These cards, purchased by the U.W. for anyone taking classes in
    the Informatics department, helped us to understand the greater impact
    of our data wrangling and findings. The different prompts help us to
    understand the affect our findings can have on indirect and direct
    stakeholders. They taught us to consider factors such as changes in the
    future, potential altered uses of our project, and even impact the website
    could have if a child were to view it.")
    )
  )
)

#Find a way to use photos from files
us_page <- tabPanel(
  "About Us",
  sidebarLayout(
    sidebarPanel(
      h2("What did you enjoy about the project?"),
      fluidPage(
        checkboxGroupInput("checkGroup4", label = h3("Answer(s):"),
                           choices = list("Visualizations" = "visualizations",
                                          "Concept" = "concept",
                                          "Topic Discussed" = "topic discussed",
                                          "Layout of the Website" = "layout of the website"),
                           selected = "select one"),
        hr(),
        fluidRow(column(11, verbatimTextOutput("value4")))
      )
    ),
    mainPanel(
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
      p("This project has shown me the surprising amount of police shootings 
        in each state. However, if compared to the proportion of the population,
        I believe the size of visualizations data has shown could be in reverse.
        The lack of complete data sets and data verification has thrown me off of
        my plan several times. Fortunately, there are other resources/packages
        that I could incorporate into making the data more complete and usable.
        I find the visualizations to be very pleasing when it finally works.
        In the future, I wish to find more data sets such as population by race,
        age, gender for each state, region, and country. With all those
        information, we could visualize more accurate visualizations of incidents
        and answer better to our research questions. Having participated in this
        project, I have learned so much more in structuring the code as a coder,
        as well as debugging the language that does not have quite an explicit
        debugger like others. As a creator, I learned of many other data sets
        that I could combine with the current one to form a larger database of
        visualizations for all relevant information.")
    )
  )
)

# navigation bar to access all pages
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
