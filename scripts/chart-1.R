# Chart 1
## This chart attempts to display an interactive plot of all
## countries/entities with their average GDP per capita and
## Tourists from 1995 to 2016.

# Load libraries
library("dplyr")
library("ggplot2")
library("plotly")

# Create plot function
get_plot <- function(df) {

  # Narrowing data extracted to data from 1995-2016
  tourists_vs_gdp_1995_2016 <- df %>%
    filter(
          Year == "1995" | Year == "1996" | Year == "1997" | Year == "1998" |
          Year == "1999" | Year == "2000" | Year == "2001" | Year == "2002" |
          Year == "2003" | Year == "2004" | Year == "2005" | Year == "2006" |
          Year == "2007" | Year == "2008" | Year == "2009" | Year == "2010" |
          Year == "2011" | Year == "2012" | Year == "2013" | Year == "2014" |
          Year == "2015" | Year == "2016")

  # Creating plot
  chart_1 <- ggplot(data = tourists_vs_gdp_1995_2016) +
    geom_point(mapping = aes(x = GDP.per.capita, y = Tourists,
                             color = Year, text = paste("Entity:", Entity),
                             size = Tourists, alpha = 0.7)
               ) +
    scale_size(range = c(.1, 10)
               ) +
    labs(
      x = "GDP per capita", y = "Tourists Outbound", color = "Year") +
    scale_y_continuous(labels = function(x) format(x, scientific = FALSE)) +
    scale_color_gradient(high = "red", low = "yellow")

  # Making the plot interactive
  ggplotly(chart_1) %>%
    layout(xaxis = list(autorange = TRUE),
           yaxis = list(autorange = TRUE))
}
