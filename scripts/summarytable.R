#Summary Table

#Load libraries
library("dplyr")
library("knitr")

#Load data frame
tourists_vs_gdp <- read.csv("./data/tourists-vs-gdp.csv",
                            stringsAsFactors = FALSE)

#Narrow data frame to just "world" data 1995 to 2016
world_tourists_vs_gdp <- tourists_vs_gdp %>%
  filter(Entity == "World") %>%
  slice(6:27) %>%
  select(-Entity) %>%
  select(-Code) %>%
  select(-X) %>%
  round(digits = 2)

#Create table using kable
#table caption
table_caption <- paste("Number of tourists outbound vs level of",
                       "prosperity of the world, 1995 to 2016")

#create table
world_table <- kable(world_tourists_vs_gdp,
                     col.names = c("Year", "Average GDP per Capita",
                                   "Number of Tourists"),
                     align = "lcr",
                     caption = table_caption)