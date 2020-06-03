library("tidyverse")
library("shiny")

source("clean_data.R")

col_names <- unique(by_demo$type)

# input element
feature_input <- selectInput(
  inputId = "feature",
  label = "Feature of Interest",
  choices = col_names,
  selected = "Major"
)

# Shiny app ui and server function

ui_platform <- tabPanel(
  titlePanel("Influence On Users By Platform"),
  feature_input,
  plotOutput(outputId = "plot")
)