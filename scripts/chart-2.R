#Chart 2
## This chart attempts to display a map to understand GDP per capita
## and number of tourists around the globe specifically in 2016.

#Load libraries
library(dplyr)
library(htmltools)
library(plotly)

#Load data
tourists_vs_gdp <- read.csv("./data/tourists-vs-gdp.csv",
                            stringsAsFactors = FALSE)

#create plotly map function
get_map <- function(df) {

  #narrow data frame to 2016
  tourists_vs_gdp_2016 <- df %>%
  filter(Year == "2016")

  #map light grey boundaries
  l <- list(color = toRGB("grey"), width = 0.5)

  #specify map projection/options
  g <- list(
    showframe = FALSE,
    showcoastlines = FALSE,
    projection = list(type = "Mercator")
    )

  #hover text
  hover_text <- paste("Country:",
                      tourists_vs_gdp_2016$Entity, "<br>",
                      "GDP per capita:",
                      round(tourists_vs_gdp_2016$GDP.per.capita, digits = 2),
                      "<br>", "Tourists Outbound:",
                      tourists_vs_gdp_2016$Tourists)

  #create map
  chloropleth_map <- plot_geo(tourists_vs_gdp_2016) %>%
    add_trace(
      hoverinfo = "text", z = ~GDP.per.capita, color = ~GDP.per.capita,
      colors = "Blues", text = hover_text, locations = ~Code,
      marker = list(line = l)
      ) %>%
    colorbar(title = "GDP per capita", tickprefix = "$") %>%
    layout(title = "2016 Global GDP & Number of Tourists",
         geo = g)

  #return map
  chloropleth_map
}
