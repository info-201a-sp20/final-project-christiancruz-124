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
