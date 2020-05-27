#Summary Table

#Load libraries
library("dplyr")
library("knitr")

#Load data frame
tourists_vs_gdp <- read.csv("./data/tourists-vs-gdp.csv",
                            stringsAsFactors = FALSE)

#Function that returns dataset 
get_summary_table <- function(df) {
  #Narrow data frame to just "world" data 1995 to 2016
  #There is no group-by function because the dataset already groups
  #all the countries information into an Entity called "World" in
  #the data frame. Filtering to "World" is the equivalent of grouping
  #by year in this case.
  world_tourists_vs_gdp <- df %>%
    filter(Entity == "World") %>%
    slice(6:27) %>%
    select(-Entity) %>%
    select(-Code) %>%
    select(-X) %>%
    round(digits = 2)
  
  #table caption
  table_caption <- paste("Number of tourists outbound vs level of",
                       "prosperity of the world, 1995 to 2016")
  #create table using kable
  world_table <- kable(world_tourists_vs_gdp,
                     col.names = c("Year", "Average GDP per Capita",
                                   "Number of Tourists"),
                     align = "lcr",
                     caption = table_caption)
  
  world_table
}
