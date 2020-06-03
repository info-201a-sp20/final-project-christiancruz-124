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
    p("2. Enter you conclusions here"),
    br(),
    h5("Platform Effectiveness: Are They Really Effective?"),
    p("A quick look at each of the demographic categories on platform influence
      will easily show that there are a couple platforms that dominate the ad 
      game. Both Facebook and instagram show clear signs as far as numbers that
      they provide the most effective platform for social media marketting out 
      of the options provided by the Whatsgoodly survey. However, an even more 
      prevelant platform with bigger numbers than the two powerhouses seems to 
      be neither and none of the listed apps. \"None\" is among the listed
      categories that also has a high relative count of answers in each 
      demographic category, which means a large amount of people feel they 
      haven't been influenced by social media marketing. This poses the 
      question of whether social media ads are effective at all.")
  )
)
