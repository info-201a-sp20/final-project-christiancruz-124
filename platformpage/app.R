# Interactive page for platform effectiveness (not final, just for preview)

library("shiny")
library("tidyverse")

raw <- read.csv("~/desktop/info 201/final-project-christiancruz-124/data/Whatsgoodly - Thought Catalog Influencers.csv",
  stringsAsFactors = FALSE
) %>%
  filter(
    grepl("social platform", Question),
    Segment.Type != "University"
  )

# removing instance of duplicate rows
raw <- raw[-c(296:300), ]

# functions for creating tidy dataframe

# dict for assigning correct type to a string key
dict <- data.frame(
  key = c("identify", "voters", "job", "I'm in", "GPA", "your major", "make"),
  value = c("Race", "Gender", "Employment Status", "School level", "GPA", "Major", "Economic Class")
)

# takes a specific demographic string and returns its corresponding demographic
# type as a string
assign <- function(demographic) {
  value <- ""
  for (i in 1:nrow(dict)) {
    if (grepl(dict[i, "key"], demographic)) {
      return(dict[i, "value"])
    }
  }
  return("Other")
}

# takes a specific demographic string and a platform string and returns its
# corresponding number of users on that platform
get_counts <- function(demographic, platform) {
  count <- raw %>%
    filter(
      Segment.Description == demographic,
      Answer == platform
    ) %>%
    select(Count) %>%
    pull(Count)
}

# clean dataframe of amount of users influenced by social media marketing
# by each demographic
by_demo <- data.frame(
  demographic = unique(raw$Segment.Description),
  row.names = NULL,
  stringsAsFactors = FALSE
)

# adding type and counts to by_demo and filtering out "other" type
by_demo <- by_demo %>%
  mutate(
    type = sapply(by_demo$demographic, assign),
    facebook = sapply(by_demo$demographic, get_counts, "Facebook"),
    instagram = sapply(by_demo$demographic, get_counts, "Instagram"),
    snapchat = sapply(by_demo$demographic, get_counts, "Snapchat"),
    twitter = sapply(by_demo$demographic, get_counts, "Twitter"),
    none = sapply(by_demo$demographic, get_counts, "None")
  ) %>%
  filter(type != "Other")

col_names <- unique(by_demo$type)

# input element
feature_input <- selectInput(
  inputId = "feature",
  label = "Feature of Interest",
  choices = col_names,
  selected = "Major"
)

# Shiny app ui and server function

ui <- fluidPage(
  titlePanel("Influence On Users By Platform"),
  feature_input,
  plotOutput(outputId = "plot")
)

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

shinyApp(ui = ui, server = server)
