# ================================ setup ======================================
library(tidyverse)

data = read.csv("../data/Whatsgoodly - Thought Catalog Influencers.csv", stringsAsFactors = FALSE)

platform_df <- data %>% 
  filter(grepl("social platform", Question))

# ==================== gathering relevant data for charts =====================
global_results <- platform_df %>% 
  filter(Segment.Description == "Global results")


# =============================== charts ======================================

# pie chart of global results
ggplot(data = global_results, aes(x = "", y = Count, fill = Answer)) +
  geom_bar(width = 1, stat = "identity") +
  geom_text(label = paste0(pull(global_results, Percentage) * 100, "%"),
            position = position_stack(vjust = 0.5)
  ) +
  coord_polar("y", start = 0) +
  scale_fill_brewer(palette = "Set1") +
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    panel.grid = element_blank()
  )
