library(shiny)
library(ggplot2)
library(ggmap)
library(dplyr)

source("maps/app_server.R")

server <- function(input, output) {
  output$map <- renderLeaflet({
    
    final_data <- cleanup_data %>%
      mutate(lat = latlon$lat,
             lon = latlon$lon) %>%
      mutate(description = paste(sep = "<br/>", Segment.Description,
                                 paste(input$view, "Opinion:", perc, "%"))) %>%
      select(Segment.Description, Count, Opinion, lat, lon, perc, description)
    
    widget_data <- final_data %>%
      filter(Opinion == input$view)
    
    m <- leaflet(data = widget_data) %>%
      addProviderTiles("CartoDB.Positron") %>%
      setView(lng = -100.066594, lat = 39.220817, zoom = 3.5) %>%
      addCircles(
        lat = ~lat,
        lng = ~lon,
        stroke = FALSE,
        popup = ~description,
        radius = ~perc * 1000,
        color = "blue")
    
    return(m)
  })
}
