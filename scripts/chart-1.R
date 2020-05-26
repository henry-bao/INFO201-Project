library(dplyr)
library(ggplot2)
library(htmltools)
library(plotly)

df <- read.csv("../data/tourists-vs-gdp.csv", stringsAsFactors = FALSE)

# Plot

plot <- ggplot(df) +
  geom_point(mapping = aes(x = "Tourists", y = "Year", color = "Entity"))

