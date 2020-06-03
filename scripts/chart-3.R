# Chart 3
## This chart attempts to understand the relationship between
## the total number of tourists in the world per year and
## the average GDP per Capita. In this chart, we are able to
## understand that there is a huge increase in both number of
## tourists and average GDP per Capita in the world.

# Load libraries
library("dplyr")
library("ggplot2")
library("plotly")

# Make chart 3 function
get_bar_graph <- function(df) {
  #filter data to "world" data years 1995 to 2016
  country_tourists_vs_gdp <- df %>%
    select(-Entity) %>%
    select(-Code) %>%
    select(-X)

  # Create plot
  chart_3 <- ggplot(data = country_tourists_vs_gdp) +
    geom_col(mapping = aes(x = Year, y = Tourists,
                           fill = GDP.per.capita)) +
    labs(fill = "Average GDP per Capita ($)") +
    scale_y_continuous(labels = function(x) format(x, scientific = FALSE)) +
    scale_fill_gradient(low = "yellow", high = "red", na.value = NA)

  # Return bar graph
  ggplotly(chart_3)
}
