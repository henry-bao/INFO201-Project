#Chart 3
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

# Creating plot
chart_3 <- ggplot(data = world_tourists_vs_gdp) +
  geom_col(mapping = aes(x = Year, y = Tourists,
                           fill = GDP.per.capita)) +
  labs(title = "World Tourism and GDP by Year",
       fill = "Average GDP per Capita ($)")