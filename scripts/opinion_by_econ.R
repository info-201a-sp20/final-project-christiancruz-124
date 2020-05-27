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

# =============================== charts ======================================
# stacked bar plot of opinion count by class
chart_econ <- ggplot(data = by_econ, aes(x = Class, Count, fill = Opinion)) +
  geom_col() +
  geom_text(
    label = paste0(pull(by_econ, Percentage) * 100, "%"),
    size = 3,
    position = position_stack(vjust = .5)
  ) +
  scale_fill_brewer(palette = "Set1") +
  ggtitle("Opinion on social media marketing by economic class")