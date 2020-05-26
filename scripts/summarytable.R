#Summary Table
#Load libraries
library("dplyr")
library("knitr")

#Load data frame
tourists_vs_gdp <- read.csv("../data/tourists-vs-gdp.csv",
                            stringsAsFactors = FALSE)

#Summarize data by years 1995-2016
world_tourists_vs_gdp <- tourists_vs_gdp %>%
  group_by(Year) %>%
  summarize(
    avg_GDP_per_capita = mean(GDP.per.capita, na.rm = TRUE),
    avg_tourists = mean(Tourists, na.rm = TRUE)
  ) %>%
  slice(214:235)

world_tourists_vs_gdp <- tourists_vs_gdp %>%
  filter(Entity == "World") %>%
  slice(6:27) %>%
  select(-Entity) %>%
  select(-Code) %>%
  select(-X)
  

#Create table
table_caption <- paste("Number of tourists outbound vs level of",
                       "prosperity of the world, 1995 to 2016")
world_table <- kable(world_tourists_vs_gdp,
                     col.names = c("Year", "Average GDP per Capita",
                                   "Number of Tourists"),
                     align = "lcr",
                     caption = table_caption)
  

