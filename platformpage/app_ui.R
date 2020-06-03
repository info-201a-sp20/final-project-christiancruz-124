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
  titlePanel("Influence On Users By Platform"),
  sidebarPanel(
    h4("Purpose"),
    hr(),
    p(""),
    hr(),
    feature_input,
  ),
  mainPanel(
    plotOutput(outputId = "plot")
  )
)