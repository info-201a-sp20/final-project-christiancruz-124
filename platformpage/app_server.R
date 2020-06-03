library("tidyverse")
library("shiny")

source("app_ui.R")

server <- function(input, output) {
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
}