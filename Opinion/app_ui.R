library("shiny")
library("tidyverse")
library("dplyr")

trial <- read.csv("data/Whatsgoodly - Thought Catalog Influencers.csv",
                stringsAsFactors = FALSE
)
# removing instance of duplicate rows

trial <- trial[-c(13:411, 4514:4516),  ]

opinion_df <- trial %>%
  filter(grepl("Does it annoy you", Question)) %>%
  mutate(Opinion = ifelse(grepl("Y", Answer), "negative",
                          ifelse(grepl("N", Answer), "positive", "neutral")
  ))

# functions for creating tidy dataframe
# dict for assigning correct type to a string key
di <- data.frame(
  key = c("identify", "voters",  "I'm in", "GPA", "your major", "make"),
  value = c("Race", "Gender", "School Level", "GPA", "Major", "Economic Class"),
  stringsAsFactors = FALSE
)

# takes a specific demographic string and returns its corresponding demographic
# type as a string
assign <- function(demographic) {
  value <- ""
  for (i in 1:nrow(di)) {
    if (grepl(di[i, "key"], demographic)) {
      return(di[i, "value"])
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
  demographic = unique(trial$Segment.Description),
  row.names = NULL,
  stringsAsFactors = FALSE
)

# adding type and counts to by_demo and filtering out "other" type
to_demo <- to_demo %>%
  mutate(
    type = sapply(to_demo$demographic, assign),
    Positive = sapply(to_demo$demographic, get_counts, "positive"),
    Neutral = sapply(to_demo$demographic, get_counts, "neutral"),
    Negative = sapply(to_demo$demographic, get_counts, "negative"),
    demographic = gsub("[^\x01-\x7F]", "", ifelse(grepl("\\?", demographic),
      substr(
        demographic,
        str_locate(demographic, "\\?") + 2,
        nchar(demographic)
      ),
      demographic
    ))
  ) %>%
  filter(type != "Other")

choices <- c("Race", "Gender", "School Level", "GPA", "Major", "Economic Class")
sidebar_content <- sidebarPanel(
  selectInput(
    inputId = "select",
    label = "Choose concerned group",
    choice = choices,
    selected = "Gender"
  )
)

main_content <- mainPanel(
  tags$p("Below is a graph that shows
      opinion of different groups towards social media marketing."),
  plotlyOutput(outputId = "plot_histogram")
)

race_panel <- tabPanel(
  "Opinion Towards Social Media Marketing",
  tags$h1(class = "header",
          "Opinion Towards Social Media Marketing"),
  sidebarLayout(
    sidebar_content,
    main_content,
    tags$h3(class= "sub",
            "Purpose"),
    hr(),
    tags$p("The bar graph aims to shown the opinion of different concern groups
           towards social media marketing. With the fill of type of opinions,
           every type of survey taker within each group shows the general ratio of opinions.
           This information can then lead to further analysis such as how ages, gender and income class
           would effect general attitudes toward social media marketing."),
    hr(),
  )
)
