library(shiny)
library(ggplot2)
install.packages(ggmap)
library(ggmap)
library(dplyr)

source("maps/app_server.R")
source("platformpage/app_ui.R")
source("Opinion/app_ui.R")
server <- function(input, output) {
  
  # leaflet for opinion by location
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
  
  # col chart on platform influence by demographic
  output$plot <- renderPlot({
    to_plot <- by_demo %>%
      filter(type == input$feature) %>%
      select(-type) %>%
      gather(key = platform, value = total, -demographic)
    
    p <- ggplot(
      data = to_plot,
      mapping = aes(
        x = demographic,
        y = total,
        fill = platform
      )
    ) +
      geom_col(position = "dodge") +
      scale_fill_brewer(palette = "Set1")
    
    p
  })
  output$plot_histogram <- renderPlot({
    to_plot <- to_demo %>%
      filter(new_type == input$select) %>%
      select(-new_type, -type) %>%
      gather(key = opinion , value = total, -demographic)
    
    p <- ggplot(
      data = to_plot,
      mapping = aes(
        x = demographic,
        y = total,
        fill = opinion
      )
    ) +
      geom_col(position = "fill") +
      scale_fill_brewer(palette = "Set1")
    p
  })
}
