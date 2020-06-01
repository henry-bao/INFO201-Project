#Chart 3
## This chart attempts to understand the relationship between
## the total number of tourists in the world per year and
## the average GDP per Capita. In this chart, we are able to
## understand that there is a huge increase in both number of
## tourists and average GDP per Capita in the world.

#Load libraries
library("dplyr")
library("ggplot2")
library("plotly")

#Load data
df <- read.csv("./data/tourists-vs-gdp.csv",
               stringsAsFactors = FALSE)

#make chart 3 function
get_bar_graph <- function(df) {
  #filter data to "world" data years 1995 to 2016
  world_tourists_vs_gdp <- df %>%
    filter(Entity == "World") %>%
    slice(6:27) %>%
    select(-Entity) %>%
    select(-Code) %>%
    select(-X)

  #create plot
  chart_3 <- ggplot(data = world_tourists_vs_gdp) +
    geom_col(mapping = aes(x = Year, y = Tourists,
                           fill = GDP.per.capita)) +
    labs(title = "Total Tourists (outbound) in the World, 1995 to 2016",
         fill = "Average GDP per Capita ($)")

  #return bar graph
  ggplotly(chart_3)
}
