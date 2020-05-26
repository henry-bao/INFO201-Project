#Summary Table
#Load libraries
library("dplyr")
library("knitr")

#Load data frame
tourists_vs_gdp <- read.csv("../data/tourists-vs-gdp.csv")

#Summarize data by years 1995-2016
world_tourists_vs_gdp <- tourists_vs_gdp %>%
  group_by(Year) %>%
  summarize(
    total_GDP_per_capita = sum(GDP.per.capita, na.rm = TRUE),
    total_tourists = sum(Tourists, na.rm = TRUE)
  ) %>%
  slice(214:235)

#Create table
table_caption <- paste("Number of tourists outbound vs level of",
                       "prosperity of the world, 1995 to 2016")
world_table <- kable(world_tourists_vs_gdp,
                     col.names = c("Year", "GDP per Capita",
                                   "Number of Tourists"),
                     align = "lcr",
                     caption = table_caption)
  

