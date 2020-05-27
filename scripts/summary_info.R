library("dplyr")
get_summary_info <- function(dataset) {
  ret <- list()
  ret$length <- length(dataset)
  ret$type_of_questions <- unique(dataset$Question)
  ret$type_of_answer <- unique(dataset$Answer)
  ret$total_participant <- dataset %>%
    filter(Segment.Type == "Gender") %>%
    select(Count) %>%
    sum()
  ret$type_of_participant <- unique(dataset$Segment.Type)
  return (ret)
} 

