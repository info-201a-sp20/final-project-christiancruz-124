# ============================== setup ========================================
library(tidyverse)

# loading data
data <- read.csv("~/desktop/info 201/final-project-christiancruz-124/data/Whatsgoodly - Thought Catalog Influencers.csv",
  stringsAsFactors = FALSE
)

# filtering data for question on annoyance
opinion_df <- data %>%
  filter(grepl("Does it annoy you", Question)) %>%
  mutate(Opinion = ifelse(grepl("Y", Answer), "negative",
    ifelse(grepl("N", Answer), "positive", "neutral")
  ))

# ==================== gathering relevant data for charts =====================
overall_opinion <- opinion_df %>%
  filter(Segment.Description == "Global results") %>%
  select(Segment.Description, Opinion, Count, Percentage)

by_gender <- opinion_df %>%
  filter(Segment.Type == "Gender") %>%
  select(Segment.Description, Opinion, Count, Percentage)

by_race <- opinion_df %>%
  filter(grepl("closely", Segment.Description)) %>%
  select(Segment.Description, Opinion, Count, Percentage)

by_econ <- opinion_df %>%
  filter(grepl("parents", Segment.Description)) %>%
  mutate(Class = ifelse(grepl("240", Segment.Description), "Upper",
    ifelse(grepl("160", Segment.Description), "Upper-middle",
      ifelse(grepl("9", Segment.Description), "Lower-middle",
        "Lower"
      )
    )
  )) %>%
  mutate(Class = factor(Class, levels = c("Lower", "Lower-middle", "Upper-middle", "Upper"))) %>%
  select(Segment.Description, Opinion, Count, Percentage, Class)

by_university <- opinion_df %>%
  filter(Segment.Type == "University") %>%
  select(Segment.Description, Opinion, Count, Percentage)

by_major <- opinion_df %>%
  filter(grepl("What's your major", Segment.Description)) %>%
  select(Segment.Description, Opinion, Count, Percentage)
