# app.R

# Load libraries so they are available
library("shiny")

# Use source() to execute the `ui.R` and `server.R` files. These will
# define the UI value and server function respectively.
source("finalapp/ui.R")
source("finalapp/server.R")

# Create a new `shinyApp()` using the loaded `ui` and `server` variables
shinyApp(ui = ui, server = server)
