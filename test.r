library(lubridate)
library(dplyr)
library(ggplot2)
library(leaflet)

police_killings <- read.csv("data/police-killings.csv",
                            stringsAsFactors = FALSE)

killings_by_region <- police_killings %>%
  group_by(region)

killings_by_region$race <- factor(killings_by_region$race,
                    levels = c("W", "B", "A", "N", "H", "O", ""))

ggplot(data = killings_by_region, aes(region, fill = race)) +
  geom_bar(stat = "count", position = "dodge") +
  labs(x = "Region",
       y = "Deaths",
       title = "Deaths by Police Shootings") +
  scale_fill_manual(
    name = "Races",
    values = c("#800080", "#4b0082", "#0000ff", "#00ff00", "#ffff00",
               "#ffa500", "#ff0000"),
    breaks = c("W", "B", "A", "N", "H", "O", ""),
    labels = c("Caucasian", "African", "Asian", "Native American",
               "Hispanic", "Other", "Unknown")
  )


killings_by_state <- police_killings %>% 
    group_by(state) %>%
    summarize(deaths = n())

leaflet(data = killings_by_state, width = "100%") %>%
  addProviderTiles("CartoDB.Positron") %>%
  setView(lng = -98.5795, lat = 39.8283, zoom = 4) %>%
  addCircles(
    radius = deaths * 1610,
    stroke = FALSE
  ) 
