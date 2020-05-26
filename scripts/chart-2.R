library(dplyr)
library(leaflet)
library(htmltools)
library(plotly)
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



#plotly map
#narrow data frame to 2016
df_2016 <- df %>%
  filter(Year == "2016")

# light grey boundaries
l <- list(color = toRGB("grey"), width = 0.5)

# specify map projection/options
g <- list(
  showframe = FALSE,
  showcoastlines = FALSE,
  projection = list(type = 'Mercator')
)

#hover text
hover_text <- paste("Country:", df_2016$Entity, '<br>',
                    "Tourists:", df_2016$Tourists)

#map
chloropleth_map <- plot_geo(df_2016) %>%
  add_trace(
    z = ~GDP.per.capita, color = ~GDP.per.capita, colors = 'Blues',
    text = hover_text, locations = ~Code, marker = list(line = l)
    ) %>%
  colorbar(title = 'GDP per capita', tickprefix = '$') %>%
  layout(title = '2016 Global GDP & Number of Tourists',
         geo = g)

chloropleth_map


