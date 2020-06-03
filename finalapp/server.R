# server.R

# Load libraries
library(dplyr)
library(shiny)
library(plotly)
library(ggplot2)

# Load data frame
df <- read.csv("../data/tourists-vs-gdp.csv",
               stringsAsFactors = FALSE)

# Load scripts
source("../scripts/summarytable.R")
source("../scripts/summaryinfo.R")
source("../scripts/chart-1.R")
source("../scripts/chart-2.R")
source("../scripts/chart-3.R")

# Define server function
server <- function(input, output) {
  
  ##Render plot
  output$plot <- renderPlotly({
    get_plot(df %>% filter(Entity == input$choose_country_plot))
  })
  
  ##Render map
  output$map <- renderPlotly({
    get_map(df, input$radio_data)
  })
  
  ##Render bar graph
  output$bar_graph <- renderPlotly({
    get_bar_graph(df %>% filter(Entity == input$choose_country_bar))
  })
}
