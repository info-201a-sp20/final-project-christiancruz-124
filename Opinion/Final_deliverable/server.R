#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library("tidyverse")

server <- function(input, output) {
    output$plot <- renderPlot({
        to_plot <- by_demo %>%
            filter(type == input$select) %>%
            select(-type) %>%
            gather(key = opinion , value = count, -demographic)
        
        p <- ggplot(
            data = to_plot,
            mapping = aes(
                x = demographic,
                y = count,
                fill = opinion
            )
        ) +
            geom_col(position = "fill") +
            scale_fill_brewer(palette = "Set1")
        p
    })
}

