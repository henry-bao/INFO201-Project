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

# Define variables for map
## Filter data to 2016
tourists_vs_gdp_2016 <- df %>%
filter(Year == "2016")

## Map light grey boundaries
l <- list(color = toRGB("grey"), width = 0.5)

## Specify map projection/options
g <- list(
  showframe = FALSE,
  showcoastlines = FALSE,
  projection = list(type = "Mercator")
)

## Map Hover text
hover_text <- paste(" GDP per capita:",
                    round(tourists_vs_gdp_2016$GDP.per.capita, digits = 2),
                    "<br>", "Country:",
                    tourists_vs_gdp_2016$Entity, "<br>",
                    "Tourists Outbound:", tourists_vs_gdp_2016$Tourists)


# Define server function
server <- function(session, input, output) {

  ##Render plot
  output$plot <- renderPlotly({
    get_plot(df %>% filter(Entity == input$choose_country_plot))
  })

  ##Render map
  output$map <- if (input$radio_data == "GDP.per.capita") {
    renderPlotly(
      #map
      plot_geo(tourists_vs_gdp_2016) %>%
        add_trace(
          z = ~GDP.per.capita, color = ~GDP.per.capita,
          colors = "Blues", text = hover_text,
          locations = ~Code, marker = list(line = l)
        ) %>%
        colorbar(title = "GDP per capita ($)") %>%
        layout(geo = g)
    )
  } else {
    renderPlotly(
      #map
      plot_geo(tourists_vs_gdp_2016) %>%
        add_trace(
          z = ~Tourists, color = ~Tourists,
          colors = "Blues", text = hover_text,
          locations = ~Code, marker = list(line = l)
        ) %>%
        colorbar(title = "Tourists") %>%
        layout(geo = g)
    )
  }

  ##Render bar graph
  output$bar_graph <- renderPlotly({
    get_bar_graph(df %>% filter(Entity == input$choose_country_bar))
  })
}
