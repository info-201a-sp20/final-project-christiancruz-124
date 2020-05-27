# ============================== setup ========================================
library(tidyverse)

# loading data
data <- read.csv("data/Whatsgoodly - Thought Catalog Influencers.csv",
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
  filter(Segment.Description == "Global results")

by_gender <- opinion_df %>%
  filter(Segment.Type == "Gender")

by_race <- opinion_df %>%
  filter(grepl("closely", Segment.Description))

by_econ <- opinion_df %>%
  filter(grepl("parents", Segment.Description)) %>%
  mutate(Class = ifelse(grepl("240", Segment.Description), "Upper",
    ifelse(grepl("160", Segment.Description), "Upper-middle",
      ifelse(grepl("9", Segment.Description), "Lower-middle",
        "Lower"
      )
    )
  )) %>%
  mutate(Class = factor(Class, levels = c("Lower", "Lower-middle", "Upper-middle", "Upper")))

by_university <- opinion_df %>%
  filter(Segment.Type == "University")

by_major <- opinion_df %>%
  filter(grepl("What's your major", Segment.Description))

# =============================== charts ======================================

# pie chart of overall opinion
opinion_all <- ggplot(data = overall_opinion, aes(x = "", y = Count, fill = Opinion)) +
  geom_bar(width = 1, stat = "identity") +
  geom_text(
    label = paste0(pull(overall_opinion, Percentage) * 100, "%"),
    size = 5,
    position = position_stack(vjust = .5)
  ) +
  coord_polar("y", start = 0) +
  scale_fill_brewer(palette = "Set1") +
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    panel.grid = element_blank()
  ) +
  ggtitle("Overall opinion of social media marketing")
