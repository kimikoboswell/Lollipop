library(lubridate)
library(dplyr)
library(ggplot2)
library(leaflet)
library(geonames)

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

# credit: https://www.andybeger.com/2013/08/06/finding-coordinates-for-cities-etc-with-r/

# usernames: batman, harley
options(geonamesUsername = "kabuyaki")

GN_search_US <- function(city, state) {
  res <- GNsearch(name=city, adminCode1=state, country="US")
  return(res[1, ])
}

test <- GN_search_US("Weeki Wachee", "FL")

unique_cities <- police_killings %>% 
  select(city, state) %>% 
  unique()

cities_latlng <- mapply(GN_search_US,
                        unique_cities$city[1:1000],
                        unique_cities$state[1:1000])
cities_latlng2 <- mapply(GN_search_US,
                         unique_cities$city[1001:2000],
                         unique_cities$state[1001:2000])
cities_latlng3 <- mapply(GN_search_US,
                         unique_cities$city[2001:2506],
                         unique_cities$state[2001:2506])

# save for later: Cañon City,38.45009,-105.22538
# Weeki Wachee,28.51804,-82.57730

add <- read.csv(textConnection(
  "city,state,lat,lng
Mt. Auburn,OH,39.12009,-84.50748
Pinion Hills,CA,34.43309,-117.64696
West Goshen,CA,36.34861,-119.41914
North Laredo,TX,29.44003,-98.50469
St. Martin,MS,30.44284,-88.86521
East Hollywood,CA,34.09387,-118.29600
Big Bear,MO,38.33218,-92.68891
Mt. Pleasant,TN,35.53490,-87.20629
Mt. Airy,MD,39.37624,-77.15569
North Fort Collins,CO,40.57638,-105.08571
Standing Rock Reservation,ND,45.75307,-101.21129
Charleston View,CA,35.96843,-115.89417
Pelehatchie,MS,32.31241,-89.80421
Friendly Hills,CO,39.63036,-105.13671"
))


try <- do.call("rbind", cities_latlng) %>% 
  select(name, state = adminCode1, lat, lng)
try <- try %>% 
  cbind(city = rownames(try), stringsAsFactors = FALSE) %>% 
  select(city, state, lat, lng)

try2 <- do.call("rbind", cities_latlng2) %>% 
  select(name, state = adminCode1, lat, lng)
try2 <- try2 %>% 
  cbind(city = rownames(try2), stringsAsFactors = FALSE) %>% 
  select(city, state, lat, lng)

try3 <- do.call("rbind", cities_latlng3) %>% 
  select(name, state = adminCode1, lat, lng)
try3 <-  try3 %>% 
  cbind(city = rownames(try3), stringsAsFactors = FALSE) %>% 
  select(city, state, lat, lng)


all_latlng <- rbind(try,
                    try2,
                    try3,
                    add)

for (val in all_latlng$city) {
  all_latlng[all_latlng$city == val, "city"] <- gsub("\\d+",
                                               "",
                                               val)
}

withnum <- read.csv(textConnection(
  "city,state,lat,lng
300 block of State Line Road,TN,36.34703,-88.71033"
))

all_latlng <- rbind(all_latlng,
                    withnum)

police_killings <- left_join(police_killings, all_latlng, by = c("city", "state"))

write.csv(police_killings, "data/police-killings-with-latlng.csv", row.names = FALSE)

killings_by_state <- police_killings %>% 
    group_by(state) 

killings_by_state <- killings_by_state %>%
    summarize(deaths = n(),
              lat = sum(as.numeric(lat)/n()),
              lng = sum(as.numeric(lng)/n()))

leaflet(data = killings_by_state) %>%
  addProviderTiles("CartoDB.Positron") %>%
  setView(lng = -98.5795, lat = 39.8283, zoom = 4) %>%
  addCircles(
    lat = ~lat,
    lng = ~lng,
    radius = ~deaths * 1610,
    stroke = FALSE
  ) 
