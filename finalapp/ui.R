# UI.R

# Load libraries
library("shiny")
library("dplyr")
library("ggplot2")
library("plotly")
library("shinythemes")

# Load data frame
df <- read.csv("../data/tourists-vs-gdp.csv",
               stringsAsFactors = FALSE)

# About page
about <- tabPanel(
  "About",
  sidebarLayout(
    sidebarPanel(
      h2("About the data"),
      p("The data was collected through several avenues. The
        country's prosperity was calculated based on the
        Global World Bank's World Development Indicators
        -- gross domestic product purchasing power parity
        (GDP PPP). This is a country's GDP converted to
        international dollars. The number of outbound tourists
        was calculated based on data from the Global World Bank
        which measured the number of times a citizen made a
        departure from their country for non-commercial purposes.
        This data set covers from 1995 to 2016."),
      actionButton(inputId='ab1', label="Learn More",
                   onclick ="window.open('https://bit.ly/3gP3Rg4', '_blank')")
    ),
    mainPanel(
      width = 6,
      tags$img(src = "tourism.png", width = 740, height = 380),
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
      h3("Number of tourists vs GDP per capita (1995 to 2016)"),
      p("This plot shows the relationship between number of
        outbound tourists and prosperity of the home country
        from 1995 to 2016. "),
      plotlyOutput("plot"),
      h3("Findings"),
      p("The plot indicates that countries with higher GDP
        per Capita is not always the country that has the
        most tourist outbound.")
    )
  )
)

ui <- navbarPage(
  "Tourism vs GDP",
  theme = shinytheme("journal"),
  about,
  chart_1_page
)
