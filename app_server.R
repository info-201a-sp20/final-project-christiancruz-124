library(shiny)
library(ggplot2)
install.packages(ggmap)
library(ggmap)
library(dplyr)
library(plotly)

source("maps/app_server.R")
source("platformpage/app_ui.R")
source("Opinion/app_ui.R")
server <- function(input, output) {

  # leaflet for opinion by location
  output$map <- renderLeaflet({
    final_data <- cleanup_data %>%
      mutate(
        lat = latlon$lat,
        lon = latlon$lon
      ) %>%
      mutate(description = paste(
        sep = "<br/>", Segment.Description,
        paste(input$view, "Opinion:", perc, "%")
      )) %>%
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
        radius = ~ perc * 1000,
        color = "blue"
      )

    return(m)
  })

  # col chart on platform influence by demographic
  output$plot <- renderPlotly({
    plot.new()
    to_plot <- by_demo %>%
      filter(type == input$feature) %>%
      select(-type) %>%
      gather(key = platform, value = total, -demographic)

    if (input$feature == "GPA") {
      to_plot <- to_plot %>%
        mutate(demographic = fct_relevel(demographic, "Below 1.0 ", "1.0 to 2.0", "2.0 to 3.0", "3.0 to 4.0", "Above 4.0 "))
    } else if (input$feature == "Economic Class") {
      to_plot <- to_plot %>%
        mutate(demographic = fct_relevel(demographic, "Poor (< ~$50K) ", "Middle / lower-middle class (~$90K)", "Upper-middle class (~$160K", "Upper class (> $240K)"))
    } else if (input$feature == "School Level") {
      to_plot <- to_plot %>%
        mutate(demographic = fct_relevel(demographic, "High School", "College", "Grad School", "Post-grad", "Other"))
    }

    p <- ggplot(
      data = to_plot,
      mapping = aes(
        x = demographic,
        y = total,
        fill = platform
      )
    ) +
      geom_col(position = "dodge") +
      scale_fill_brewer(name = "Platforms", palette = "Set1") +
      title("User Influence by Demographic") +
      xlab(input$feature) +
      ylab("Users Influenced") +
      theme(
        axis.text.x = element_text(angle = 45, hjust = 1)
      )
    
    p <- ggplotly(p)
  })

  output$plot_histogram <- renderPlotly({
    plot.new()
    to_plot <- to_demo %>%
      filter(type == input$select) %>%
      select(-type) %>%
      gather(key = opinion, value = total, -demographic)
    
    if (input$select == "GPA") {
      to_plot <- to_plot %>%
        mutate(demographic = fct_relevel(demographic, "Below 1.0 ", "1.0 to 2.0", "2.0 to 3.0", "3.0 to 4.0", "Above 4.0 "))
    } else if (input$select == "Economic Class") {
      to_plot <- to_plot %>%
        mutate(demographic = fct_relevel(demographic, "Poor (< ~$50K) ", "Middle / lower-middle class (~$90K)", "Upper-middle class (~$160K", "Upper class (> $240K)"))
    } else if (input$select == "School Level") {
      to_plot <- to_plot %>%
        mutate(demographic = fct_relevel(demographic, "High School", "College", "Grad School", "Post-grad", "Other"))
    }

    p <- ggplot(
      data = to_plot,
      mapping = aes(
        x = demographic,
        y = total,
        fill = opinion
      )
    ) +
      geom_col(position = "fill") +
      scale_fill_brewer(name = "Opinion", palette = "Set1") +
      title("Opinion by Demographic") +
      xlab(input$select) +
      ylab("Count") +
      theme(
        axis.text.x = element_text(angle = 45, hjust = 1)
      )
    
    p <- ggplotly(p)
  })
  
  output$platforms_overall <- renderPlot({
    to_plot <- raw %>%
      filter(Segment.Description == "Global results", )
    
    p <- ggplot(data = to_plot, aes(x = "", y = Count, fill = Answer)) +
      geom_bar(width = 1, stat = "identity") +
      geom_text(label = paste0(pull(to_plot, Percentage) * 100, "%"),
                position = position_stack(vjust = 0.5)
      ) +
      coord_polar("y", start = 0) +
      scale_fill_brewer(palette = "Set1") +
      labs(
        title = "Global results of platform use",
        subtitle = raw$Question
      ) +
      theme(
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        panel.grid = element_blank()
      )
    p
  })
}
