#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(ggplot2)
source("app_ui.R")
server <- function(input, output) {
  output$plot_histogram <- renderPlot({
    to_plot <- by_demo %>%
      filter(type == input$select) %>%
      select(-type) %>%
      gather(key = opinion , value = count, -demographic)

    p <- ggplot(data = to_plot) +
            geom_col(mapping = aes(x = demographic,
                                   y = count),
                     fill = opinion,
                     position = "fill") +
      scale_fill_brewer(palette = "Set1") +
      labs(x = "Concerned Groups", y = "Opinions")

  })
}
