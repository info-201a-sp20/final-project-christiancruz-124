library(shiny)
source("maps/app_ui.R")

ui <- navbarPage(
  "Social Media and Online Shopping Trends",
  overview,
  map_page,
  conclusion
)
