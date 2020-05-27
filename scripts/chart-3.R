#Chart 3
## This chart attempts to understand the relationship between 
## the total number of tourists in the world per year and
## the average GDP per Capita. In this chart, we are able to
## understand that there is a huge increase in both number of
## tourists and average GDP per Capita in the world. 

#Load libraries
library("dplyr")
library("ggplot2")

#Load data
tourists_vs_gdp <- read.csv("./data/tourists-vs-gdp.csv",
                            stringsAsFactors = FALSE)

#Narrowing data down to "World" data 1995-2016
world_tourists_vs_gdp <- tourists_vs_gdp %>%
  filter(Entity == "World") %>%
  slice(6:27) %>%
  select(-Entity) %>%
  select(-Code) %>%
  select(-X)

#Creating plot 
chart_3 <- ggplot(data = world_tourists_vs_gdp) +
  geom_col(mapping = aes(x = Year, y = Tourists,
                         fill = GDP.per.capita)) +
  labs(title = "Total Number of Tourists in the World per Year",
       fill = "Average GDP per Capita ($)")

chart_3
