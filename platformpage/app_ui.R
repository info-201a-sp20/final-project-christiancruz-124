library("tidyverse")
library("shiny")

source("platformpage/clean_data.R")

col_names <- unique(by_demo$type)

# input element
feature_input <- selectInput(
  inputId = "feature",
  label = "Feature of Interest",
  choices = col_names,
  selected = "Major"
)

ui_platform <- tabPanel(
  "Platform Effectiveness",
  tags$h1(class = "header",
          "Influence On Users By Platform"),
  sidebarPanel(
    tags$h3(class = "sub",
            "Purpose"),
    hr(),
    tags$p("The Whatsgoodly survey asks survey takers \"What social platform has
      influenced your online shopping most?\" They're given five possible
      answers: Facebook, Instagram, Twitter, Snapchat and None (indicating
      that the person does not feel their shopping habits have been influenced
      by social media marketing). The bar chart to the right shows the amount
      of users that answered for each platform. Selecting a demographic from
      the options below displays the counts for each category within the
      selected demographic (some categories are nonexhaustive as our data is
      limitted to the Whatsgoodly data). Analyzing the amount of influenced
      users per category could potentially show trends for certain
      demographics."),
    hr(),
    feature_input,
  ),
  mainPanel(
    plotOutput(outputId = "plot")
  )
)
