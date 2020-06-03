# Interactive page for platform effectiveness (not final, just for preview)

library("shiny")
library("tidyverse")

source("app_ui.R")
source("app_server.R")

shinyApp(ui = ui_platform, server = server)
