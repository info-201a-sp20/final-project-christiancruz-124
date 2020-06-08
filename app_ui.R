library(shiny)
source("maps/app_ui.R")
source("platformpage/app_ui.R")
source("Opinion/app_ui.R")

ui <- navbarPage(
  "Effectiveness and influences of social media marketing",

  # first panel: overview
  tabPanel(
    "Overview",
    includeCSS("style.css"),
    tags$h1(class = "header",
            "Overview"),
    sidebarLayout(
      sidebarPanel(
        tags$h3(class= "sub",
                "Purpose"),
        hr(),
        tags$p("In an effort to understand the effects social media marketing has on users,
        we have decided to explore social media and how marketing affects spending on
        popular social media sites as well as it's over all reception by users. The
        importance in such analysis lies in the ability to have a better understanding
        of the strategies used to influence shoppers, understand the feelings of users,
        identify social medias that have the most effect to then question why they are
        most effective, and finally to use demographical knowledge in conjunction with
        marketing data to evaluate their effectiveness in certain groups."),
        br(),
        tags$h3(class= "sub",
                "Data Sources"),
        hr(),
        tags$p("In this project we have successfully found data on",
          a("data world.", href= "https://data.world/"), "All of the datasets we chose from data.world was
        collected via survey on an app known as Whatsgoodly. The datasets provided information about 
          demographics, location, and asked questions that showed opinions of different demographics about
          social media marketing as well as questions realting to the effectiveness of different 
          social media platforms.")),

      mainPanel(
      tags$img(id = "img", "", src = "https://images.pexels.com/photos/927629/pexels-photo-927629.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
            height = 500, width = 900)
      )
    )
  ),

  # second panel: leaflet map on reactions
  map_page,

  # third panel: col chart on opinion by demographic
  race_panel,

  # fouth panel: col chart on platform effectiveness by demographic
  ui_platform,

  # fifth panel: conclusions page
  tabPanel(
    "Conclusions",
    tags$h1(class = "header",
            "Conclusions"),
    br(),
    tags$h4(class = "insight",
            "Mapping Opinions: General Trends Show Negative Responses Throughout"),
    tags$p("When comparing attitudes toward marketing in different locations,",
      "the connection between user attitude and location is not abosolute.",
      "However, we see a general trend of dislike across the country",
      "followed by neutrality in second, and finally positivity as last.",
      "This does not show whether that social media marketing is effective or not,",
      "but consumers definitely have a generally negative attitude towards this kind of marketing.",
      "Via this dataset, many of the ways effectiveness is measured is through",
      "the perspective of the users and this leads us the question their objectivity",
      "in the influence that social media holds in their own lives."),
    DT::dataTableOutput("table"),
    tags$p("The table above further highlights the points above, as we take percentage 
           of opinion from 5 different locations and compare them. We can clearly see
           that almost all regions lean toward negative or neutral as opposed to positive."),
    br(),
    tags$h4(class = "insight",
            "Demographics and Opinion: General Consensus"),
    tags$p("Based on the summary of opinion of people who took the survey,",
      "It could be found that among different group of people, opinions are varied.",
      "The general trend, however, shows a negative/neutral attitute towards social media marketing",
      "Whether social media marketing is effective cannot be told from the summary since the inluence",
      "of the advertisements may be underestimated."),br(),
      "According to",a("social media impact.", 
                       href= "http://www.socialmediaimpact.com/impact-social-media-marketing-today/
                       #:~:text=Using%20social%20media%20platforms%20like,helps%20in%20developing%20business%20tactics."),
      "Social Media Marketing is having a tremendous impact on business and market as business growth.",
      "It helps in developing business tactics.",
      "Social media marketing helps a brand/company to build a strong online presence",
      "by innovative social media marketing techniques and customer satisfaction.",
    br(),
    tags$h4(class = "insight",
            "Platform Effectiveness: Are They Really Effective?"),
    tags$p("A quick look at each of the demographic categories on platform influence
      will easily show that there are a couple platforms that dominate the ad
      game. Both Facebook and instagram show clear signs as far as numbers that
      they provide the most effective platform for social media marketting out
      of the options provided by the Whatsgoodly survey. However, an even more
      prevelant platform with bigger numbers than the two powerhouses seems to
      be neither and none of the listed apps. \"None\" is among the listed
      categories that also has a high relative count of answers in each
      demographic category, which means a large amount of people feel they
      haven't been influenced by social media marketing. This poses the
      question of whether social media ads are effective at all."),
    plotOutput("platforms_overall"),
    tags$p("Something to consider is the objectivity of the data and thus the 
           insights from the data. Becuase all of the data for this report is
           survey based, the data is all user reported. This means that a 
           survey taker may answer \"None\" when in reality, they have
           purchased a product directly from a platform without knowing or 
           may have unknowingly bought a product advertised to them while on a
           certain platform. There is no way to accurately determine this
           without better, more direct data, so further investigation with
           better data is needed to fully determine the effectiveness of social
           media marketing.")
  )
)
