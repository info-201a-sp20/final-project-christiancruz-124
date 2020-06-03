library(shiny)
source("maps/app_ui.R")
source("platformpage/app_ui.R")

ui <- navbarPage(
  "Social Media and Online Shopping Trends",
  
  # first panel: overview
  tabPanel(
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
  ),
  
  # second panel: leaflet map on reactions
  map_page,
  
  # third panel: col chart on opinion by demographic
  
  
  # fouth panel: col chart on platform effectiveness by demographic
  ui_platform,
  
  # fifth panel: conclusions page
  tabPanel(
    "Conclusions",
    titlePanel("Conclusions"),
    h4("Based on the data we had the following insights:"),
    br(),
    p("1. When comparing attitudes toward marketing in different locations,", br(),
      "the location did not affect attitude. However, we see a general trend", br(),
      "of dislike across the country followed by neutrality in second, and finally
    positivity", br(), "as last. This leads us to wonder if social media marketing is effective", br(),
      "and what features would make it more appealing to more users."),
    br(),
    p("2. Based on the summary of opinion of people who took the survey,)",br(),
      "It could be found that among different group of people,opinions are varied.",br(),
      "The general trend, however, shows a negative attitute towards social media marketing",br(),
      "Whether social media marketing is effective cannot be told from the summary since the inluence",br(),
      "of the advertisements may be unrealized.",
    br(),
    p("3. Enter your conclusions here")
    
  )
)
