library(shiny)
library(ggplot2)
library(tidyr)
library(leaflet)
library(ggmap)
library(stringr)
source("api_keys.R")

### Loading Data Into File ###

ggmap::register_google(key = api_key)

data = read.csv("data/Whatsgoodly - Thought Catalog Influencers.csv",
                stringsAsFactors = FALSE)

### Data cleanup ###

cleanup_data <- data %>%
  filter(str_detect(Question, "annoy"),
         Segment.Type == "University") %>%
  mutate(Opinion = ifelse(grepl("Y", Answer), "Negative",
                          ifelse(grepl("N", Answer), "Positive", "Neutral")))

new_perc <- cleanup_data %>%
  group_by(Segment.Description) %>%
  mutate(total_count = sum(Count, na.rm = TRUE)) %>%
  mutate(perc = Count/total_count * 100)

cleanup_data <- cleanup_data %>%
  mutate(perc = new_perc$perc)

### Using geocode to get lat/lon by university name ###

latlon <- geocode(cleanup_data $Segment.Description, output = "latlon")

### Merging together the cleaned up data and lat/lon as well as selecting ###

final_data <- cleanup_data %>%
  mutate(lat = latlon$lat,
         lon = latlon$lon) %>%
  mutate(description = paste(sep = "<br/>", Segment.Description,
                             paste(perc, "%"))) %>%
  select(Segment.Description, Count, Opinion, lat, lon, perc, description)

### Creating Server to Render Map ###
server <- function(input, output) {
  output$map <- renderLeaflet({
    
    final_data <- cleanup_data %>%
      mutate(lat = latlon$lat,
             lon = latlon$lon) %>%
      mutate(description = paste(sep = "<br/>", Segment.Description,
                                 paste(input$view, "Opinion:", perc, "%"))) %>%
      select(Segment.Description, Count, Opinion, lat, lon, perc, description)
    
    widget_data <- final_data %>%
      filter(Opinion == input$view)
    
    m <- leaflet(data = widget_data) %>%
      addProviderTiles("CartoDB.Positron") %>%
      setView(lng = -100.066594, lat = 39.220817, zoom = 3.5) %>%
      addCircles(
        lat = ~lat,
        lng = ~lon,
        stroke = FALSE,
        popup = ~description,
        radius = ~perc * 1000,
        color = "blue")
    
    return(m)
  })
}
