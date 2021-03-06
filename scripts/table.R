library("dplyr")
library("knitr")

ds <- read.csv("data/WhatsgoodlyData-6.csv", stringsAsFactors = FALSE)
View(ds)
get_table <- function(ds) {
  ds %>%
    mutate(real_perc = paste0(Percentage * 100, "%")) %>%
    group_by(Segment.Description) %>%
    filter(Segment.Type == "Gender") %>%
    select(Segment.Description, Answer, real_perc, Count) %>%
    kable(col.names = c("Gender", "Platform w/ Most Shopping Influence",
                        "Percentage of Gender", "Voter Count"))

}
