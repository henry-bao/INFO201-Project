# Load libraries so they are available
library("shiny")

# Use source() to execute the `app_ui.R` and `app_server.R` files. These will
# define the UI value and server function respectively.
source("ui.R")
source("server.R")

# Load data frame
df <- read.csv("../data/tourists-vs-gdp.csv",
               stringsAsFactors = FALSE)

# Load scripts
source("../scripts/summarytable.R")
source("../scripts/summaryinfo.R")
source("../scripts/chart-1.R")
source("../scripts/chart-2.R")
source("../scripts/chart-3.R")

# Create a new `shinyApp()` using the loaded `ui` and `server` variables
shinyApp(ui = ui, server = server)
