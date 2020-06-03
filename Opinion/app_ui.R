library("shiny")
library("tidyverse")
library("dplyr")

raw <- read.csv("data/Whatsgoodly - Thought Catalog Influencers.csv",
                stringsAsFactors = FALSE
)
# removing instance of duplicate rows

raw <- raw[-c(13:411), ]

opinion_df <- raw %>%
  filter(grepl("Does it annoy you", Question)) %>%
  mutate(Opinion = ifelse(grepl("Y", Answer), "negative",
                          ifelse(grepl("N", Answer), "positive", "neutral")
  ))

# functions for creating tidy dataframe
# dict for assigning correct type to a string key
dict <- data.frame(
  key = c("identify", "voters",  "I'm in", "GPA", "your major", "make"),
  value = c("Race", "Gender", "School level", "GPA", "Major", "Economic Class")
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
get_counts <- function(demographic, opinion) {
  count <- opinion_df %>%
    filter(
      Segment.Description == demographic,
      Opinion == opinion
    ) %>%
    select(Count) %>%
    pull(Count)
}

# clean dataframe of amount of users influenced by social media marketing
# by each demographic
to_demo <- data.frame(
  demographic = unique(raw$Segment.Description),
  row.names = NULL,
  stringsAsFactors = FALSE
)

# adding type and counts to by_demo and filtering out "other" type
to_demo <- to_demo %>%
  mutate(
    type = sapply(to_demo$demographic, assign),
    positive = sapply(to_demo$demographic, get_counts, "positive"),
    neutral = sapply(to_demo$demographic, get_counts, "neutral"),
    negative = sapply(to_demo$demographic, get_counts, "negative"),
  ) %>%
  filter(type != "Other") %>%
  mutate(new_type = ifelse(grepl(1, type), "Economic Class",
                           ifelse(grepl(2, type), "Gender",
                                  ifelse(grepl(3, type), "GPA",
                                         ifelse(grepl(4, type), "Major",
                                                ifelse(grepl(5, type), "Race", "School level")
                                      )
                             )
                    )
          )
  )


choices <- c("Race", "Gender", "School level", "GPA", "Major", "Economic Class")
sidebar_content <- sidebarPanel(
  selectInput(
    inputId = "select",
    label = "Choose concerned group",
    choice = choices,
    selected = "Gender"
  )
)

main_content <- mainPanel(
  p("Below is a graph that shows
      opinion of different groups towards social media marketing."),
  plotOutput(outputId = "plot_histogram")
)

race_panel <- tabPanel(
  "Opinion towards social media marketing",
  titlePanel("Opinion towards social media marketing"),
  sidebarLayout(
    sidebar_content,
    main_content
  )
)
