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

overview <- tabPanel(
  "Overview",
  titlePanel("Overview"),
  sidebarLayout(
    sidebarPanel(
      h4("Purpose"),
      hr(),
      p("In an effort to understand the effects social media has on users, we have
        decided to explore social media and how marketing affects spending on
        popular social media sites as well as it's over all reception by users. The
        importance in such analysis lies in the ability to have a better understanding
        of the strategies used to influence shoppers, understand the feelings of users,
        identify social medias that have the most effect to then question why they are
        most effective, and finally to usedemographical knowledge in conjunction with
        marketing data to evaluate their effectivenessin certain groups."),
      br(),
      h4("Data Sources"),
      hr(),
      p("In this project we have successfully found data on",
        a("data world.", href= "https://data.world/"), "The datasets we chose from data.world was
        collected via survey on an app known as Whatsgoodly.")),
    
    mainPanel(
     img("", src = "https://images.pexels.com/photos/927629/pexels-photo-927629.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        height = 500, width = 900)
    )
  )
)


conclusion <- tabPanel(
  "Conclusions",
  titlePanel("Conclusions"),
  h4("Based on the data we had the following insights:"),
  br(),
  p("1. When comparing attitudes toward marketing in different locations,", br(),
     "the location did not affect attitude. However, we see a general trend", br(),
    "of dislike across the country followed by neutrality in second, and finally
    positivity", br(), "as last. This leads us to wonder if social media marketing is effective,", br(),
    "or leads us to question how aware users are to the level that they are influenced."),
  br(),
  p("2. Enter you conclusions here"),
  br(),
  p("3. Enter your conclusions here")
  
)

