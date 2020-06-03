library(dplyr)
library(shiny)
library(leaflet)

### Loading Data Into File ###

data = read.csv("data/Whatsgoodly - Thought Catalog Influencers.csv",
                stringsAsFactors = FALSE)

### Creating Variable for Widget Control ###

opinions <- list("Positive", "Negative", "Neutral")


### Developing Map UI for US's opnion on social media marketing ###

map_page <- tabPanel(
  "Mapping Marketing Responses",
  titlePanel("Regional Opinions of Social Media Marketing in the US"),
  sidebarLayout(
    sidebarPanel(
      h4("Purpose"),
      hr(),
      p("The map on the right aims to depict opinions of social media users
        in regards to social media marketing by location. By creating such a map,
        possible trends in opinion by region can be brought to light as well as the overall 
        understanding of attitudes in the US in general. This information can 
        then lead to further analysis such as the causes of regional disparites and 
        general attitudes toward social media marketing."),
      
      hr(),
      radioButtons(inputId = "view", label = "Select an Opinion",
                   choices = opinions, selected = "Positive")
    ),
    mainPanel(
      leafletOutput("map")
    )
  )
)

