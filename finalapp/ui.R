# UI.R

# Load libraries
library("shiny")
library("dplyr")
library("ggplot2")
library("plotly")

# Load data frame
df <- read.csv("../data/tourists-vs-gdp.csv",
               stringsAsFactors = FALSE)

# About page
about <- tabPanel(
  "About",
  sidebarLayout(
    sidebarPanel(
      h2("About the data"),
      tags$a(hrep = "https://ourworldindata.org/grapher
      /number-of-tourists-outbound-vs-level-of-prosperity
      -of-the-home-country", "Number of Outbound Tourists
      vs GDP Data-Set"),
      p("The data was collected through several avenues. The
        country's prosperity was calculated based on the
        Global World Bank's World Development Indicators
        -- gross domestic product purchasing power parity
        (GDP PPP). This is a country's GDP converted to
        international dollars. The number of outbound tourists
        was calculated based on data from the Global World Bank
        which measured the number of times a citizen made a
        departure from their country for non-commercial purposes.
        This data set covers from 1995 to 2016.")
    ),
    mainPanel(
      tags$img(src = "tourism.png"),
      h2("Why Tourism ?"),
      p("Tourism is a popular economic activity that has
        developed significantly over the years. It's an
        activity that can bring benefits to a country's
        government and its local residents. Such activity
        is recognized in almost every nation in the world.
        Thus, it is important for us to know how can the wealth
        of a country can impact tourism. Accordingly, for this
        group project our team is going to analyze the correlation
        between a country's GDP and the number of each country's
        outbound tourists.")
    )
  )
)

chart_1_page <- tabPanel(
  "Country vs Tourism Visualization",
  titlePanel("Country vs Tourism Visualization"),
  sidebarLayout(
    sidebarPanel(
      selectInput("Country", "Select Country",
                  choices = unique(df$Entity[!is.na(df$Tourists)]),
                  selected = "United States")
    ),
    mainPanel(
      p("This plot shows the relationship between number of
        outbound tourists and prosperity of the home country
        from 1995 to 2016. "),
      plotlyOutput("plot")
    )
  )
)

ui <- navbarPage(
  "Tourism vs GDP",
  about,
  chart_1_page
)
