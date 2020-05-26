#Chart 1
## This chart attempts to understand the relationship between 
#Load libraries
library("dplyr")
library("ggplot2")
library("plotly")

#Load data
tourists_vs_gdp <- read.csv("../data/tourists-vs-gdp.csv",
                            stringsAsFactors = FALSE)

#Narrowing data down to "World" data 1995-2016
world_tourists_vs_gdp <- tourists_vs_gdp %>%
  filter(Entity == "World") %>%
  slice(6:27) %>%
  select(-Entity) %>%
  select(-Code) %>%
  select(-X)

#Creating plot 
chart_1 <- ggplot(data = world_tourists_vs_gdp) +
  geom_point(mapping = aes(x = Year, y = GDP.per.capita,
                           color = Tourists)) +
  labs(title = "Average GDP per capita in the World per Year",
       color = "Tourists")

#Making the plot interactive
ggplotly(chart_1)

chart_1
