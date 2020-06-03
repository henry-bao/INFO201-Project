#Chart 2
## This chart attempts to display a map to understand GDP per capita
## and number of tourists around the globe specifically in 2016.

#Load libraries
library(dplyr)
library(htmltools)
library(plotly)

#create plotly map function
get_map <- function(df, input) {

  #narrow data frame to 2016
  tourists_vs_gdp_2015 <- df %>%
    filter(Year == "2015") %>%
    filter(Entity != "World") %>%
    filter(Code != "")

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
                      tourists_vs_gdp_2015$Entity, "<br>",
                      "GDP per capita:",
                      round(tourists_vs_gdp_2015$GDP.per.capita, digits = 2),
                      "<br>", "Tourists Outbound:",
                      tourists_vs_gdp_2015$Tourists)

  if (input == "GDP.per.capita") {
    #create map
    chloropleth_map <- plot_geo(tourists_vs_gdp_2015) %>%
      add_trace(
        hoverinfo = "text", z = ~GDP.per.capita, color = ~GDP.per.capita,
        text = hover_text, locations = ~Code,
        marker = list(line = l)
      ) %>%
      colorbar(title = "GDP per Capita", tickprefix = "$") %>%
      layout(geo = g)
  
    #return map
    chloropleth_map
  } else {
    chloropleth_map <- plot_geo(tourists_vs_gdp_2015) %>%
      add_trace(
        hoverinfo = "text", z = ~Tourists, color = ~Tourists,
        text = hover_text, locations = ~Code,
        marker = list(line = l)
      ) %>%
      colorbar(title = "Tourists") %>%
      layout(geo = g)
  
    #return map
    chloropleth_map
  }
}
