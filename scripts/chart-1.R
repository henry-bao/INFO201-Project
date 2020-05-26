#Chart 1
## 

#Load libraries
library("dplyr")
library("ggplot2")
library("plotly")

#Load data
tourists_vs_gdp <- read.csv("../data/tourists-vs-gdp.csv",
                            stringsAsFactors = FALSE)

#Narrowing data extracted to data from 1995-2016
tourists_vs_gdp_1995_2016 <- tourists_vs_gdp %>%
  filter(Year == "1995" to "2016")
slice(6:27) %>%
  select(-Entity) %>%
  select(-Code) %>%
  select(-X)

#Creating plot 
chart_1 <- ggplot(data = world_tourists_vs_gdp) +
  geom_point(mapping = aes(x = GDP.per.capita, y = Tourists,
                           color = Tourists)) +
  labs(title = "Average GDP per capita in the World per Year",
       color = "Tourists")

#Making the plot interactive
ggplotly(chart_1)

chart_1