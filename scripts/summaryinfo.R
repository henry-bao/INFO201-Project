# final project - summary info script

# Import Libraries
library(dplyr)

# A function that takes in a dataset and returns a list of info about it:
get_summary_info <- function(tour) {
  ret <- list()
  ret$length <- length(tour)

  ret$num_countries <- length(unique(tour$Code))

  # the following 4 values are related
  ret$highest_gdp <- tour %>%
    filter(!is.na(GDP.per.capita)) %>%
    filter(GDP.per.capita == max(GDP.per.capita)) %>%
    pull(GDP.per.capita)

  ret$highest_gdp_country <- tour %>%
    filter(GDP.per.capita == ret$highest_gdp) %>%
    pull(Entity)

  ret$highest_gdp_year <- tour %>%
    filter(GDP.per.capita == ret$highest_gdp) %>%
    pull(Year)

  ret$highest_gdp_tourists <- tour %>%
    filter(GDP.per.capita == ret$highest_gdp) %>%
    pull(Tourists)

  ret$total_tourists_in_2010 <- tour %>%
    filter(Year == "2010") %>%
    filter(!is.na(Tourists)) %>%
    summarize(total_tourists = sum(Tourists)) %>%
    pull(total_tourists)

  # the following 3 values are related
  ret$most_tourists_in_world <- tour %>%
    filter(!is.na(Tourists)) %>%
    filter(Entity == "World") %>%
    filter(Tourists == max(Tourists)) %>%
    pull(Tourists)

  ret$most_tourists_in_world_year <- tour %>%
    filter(!is.na(Tourists)) %>%
    filter(Entity == "World") %>%
    filter(Tourists == max(Tourists)) %>%
    pull(Year)

  ret$most_tourists_in_world_gdp <- tour %>%
    filter(!is.na(Tourists)) %>%
    filter(Entity == "World") %>%
    filter(Tourists == max(Tourists)) %>%
    pull(GDP.per.capita)

  return(ret)
}
