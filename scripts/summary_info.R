get_summary_info <- function(dataset) {
  ret <- list()
  ret$length <- length(dataset)
  ret$type_of_questions <- unique(dataset$question)
  ret$type_of_answer <- unique(dataset$answer)
  ret$total_participant <-sum(dataset$count)
  ret$type_of_participant <- unique(dataset$segment_type)
  return (ret)
} 
