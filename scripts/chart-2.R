library(dplyr)
library(leaflet)
library(htmltools)

df <- read.csv("../data/tourists-vs-gdp.csv", stringsAsFactors = FALSE)

# Interactive Map

df$info <- paste0("Entity ", df$Entity, "<br/> ",
                  "Year ", df$Year, "<br/> ",
                  "GDP per capita ", df$GDP.per.capita, "<br/> ",
                  "Tourists ", df$Tourists) 

map_coloring <- colorFactor(topo.colors(3), df$Tourists)

interactive_map <- leaflet(data = df) %>%
  addProviderTiles("CartoDB.Positron") %>%
  addCircleMarkers(
    clusterOptions = markerClusterOptions(),
    stroke = FALSE,      
    color = map_coloring(df$Tourists),
    label = ~lapply(info, HTML))

interactive_map
