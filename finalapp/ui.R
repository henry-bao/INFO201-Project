# ui.R

# Load libraries
library("shiny")
library("dplyr")
library("ggplot2")
library("plotly")
library("shinythemes")

# Load data frame
df <- read.csv("../data/tourists-vs-gdp.csv",
               stringsAsFactors = FALSE)

# Get location names
t <- data.frame(unique(df$Entity[!is.na(df$Tourists)]))

# Get country names
country <- t %>%
  select(1) %>%
  slice(1:21, 23:35, 40:44, 50:59, 61:63, 66:78, 83:85,
        88:95, 97:104, 106, 108:116, 118:127, 130:149, 151:154, 156) %>%
  rename(c_names = unique.df.Entity..is.na.df.Tourists...)

# Get region names
region <- t %>%
  select(1) %>%
  slice(22, 37, 45:46, 80, 105, 128, 155) %>%
  rename(r_names = unique.df.Entity..is.na.df.Tourists...)

# Get income names
income <- t %>%
  select(1) %>%
  slice(39, 48, 60, 82, 86:87, 96, 150) %>%
  rename(inc_lvl = unique.df.Entity..is.na.df.Tourists...)

# About page
about <- tabPanel(
  "About",
  sidebarLayout(
    sidebarPanel(
      h2("Data Source"),
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
      tags$img(src = "money.jpg", width = "100%"),
      p(" "),
      actionButton(inputId = "ab1", label = "Learn More",
                   onclick = "window.open('https://bit.ly/3gP3Rg4', '_blank')")
    ),
    mainPanel(
      width = 7,
      tags$img(src = "tourism.png", width = "100%"),
      h2("Why Tourism?"),
      p("Tourism is a popular economic activity that has
        developed significantly over the years. Many people all
        over the world enjoy travelling as a way to get away from
        reality like work, to explore new cultures and foods, or
        to simply spend quality time with their loved ones. It is
        also an activity that can bring benefits to a country's
        government and its local residents. Such activity
        is recognized in almost every nation in the world."),
      h3("What's GDP and what does it have to do with Tourism?"),
      p("GDP stands for Gross Domestic Product. GDP measures 
        the value of economic activity within a country. 
        It is important for us to know how the wealth of
        each country, and specifically a country's monetary value
        of finished goods and services they produce, can impact
        tourism. Therefore, for this group project our team is
        going to analyze the correlation between a country's GDP
        and the number of each country's outbound tourists."),
      h3("Questions We Hope to Answer: "),
      p("1) Does a country's GDP per Capita increrase on a 
        yearly basis?"),
      p("2) Do outbound tourists per country increase when the 
        GDP per capita increases?"),
      p("3) ")
    )
  )
)

chart_1_page <- tabPanel(
  "Country vs. Tourism Visualization",
  titlePanel("Country vs. Tourism Visualization"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "choose_country_plot",
                  label = h4("Select Location"),
                  choices = unique(df$Entity[!is.na(df$Tourists)]),
                  selected = "United States")
    ),
    mainPanel(
      h3("Number of Tourists vs. GDP per Capita (1995 - 2016)"),
      p("This chart attempts to understand the relationship 
        between the total number of tourists in the world 
        per year and the average GDP per Capita. In this chart, 
        we are able to understand that there is a huge increase 
        in both number of tourists and average GDP per Capita 
        in the world. This plot shows the relationship between 
        number of outbound tourists and prosperity of the home 
        country from 1995 to 2016. "),
      plotlyOutput("plot"),
      h3("Findings"),
      p("- For most countries, their GDP per Capita increased on
        a yearly basis."),
      p("- The plot also indicates that for the majority of countries,
        as GDP per Capita increases the number of outbound tourists
        also increases.")
    )
  )
)

chart_2_page <- tabPanel(
  "GDP & Tourism Map",
  titlePanel("GDP & Tourism Map"),
  
  # Sidebar with a selectInput for the population variable
  sidebarLayout(
    
    sidebarPanel(
      # Radio buttons for the color of the graph
      radioButtons(
        inputId = "radio_data",
        label = h4("Display Data By"),
        choiceNames = c("GDP Per Capita", "Tourists"),
        choiceValues = c("GDP.per.capita", "Tourists"),
        selected = "GDP.per.capita"
      )
    ),
    
    # Display bar graph in main panel
    mainPanel(
      h3("2015 Global GDP & Number of Tourists Outbound"),
      p("This chart attempts to display an interactive map 
        to understand GDP per capita and number of tourists 
        around the globe specifically in 2015. Using this 
        interactive map, we are able to compare and contrast 
        the difference in GDP per capita and number of tourists 
        between each country in 2015."),
      plotlyOutput("map")
    )
  )
)

chart_3_page <- tabPanel(
  "GDP vs. Tourism Chart",
  titlePanel("GDP vs. Tourism Chart"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "choose_country_bar",
                  label = h4("Select Location"),
                  choices = unique(df$Entity[!is.na(df$Tourists)]),
                  selected = "World")
    ),
    mainPanel(
      h3("Total Tourists Outbound (1995 - 2016)"),
      p("This chart attempts to display an interactive plot of 
        all countries/entities with their average GDP per capita 
        and Tourists from 1995 to 2016. This plot shows the 
        relationship between number of outbound tourists and 
        prosperity of the home country from 1995 to 2016. "),
      plotlyOutput("bar_graph"),
      h3("Findings"),
      p("- The plot indicates that countries with higher GDP
        per Capita is not always the country that has the
        most tourist outbound."),
      p("- In general, all countries seem to have a higher 
        GDP per Capita when they have a higher number of outbound
        tourists as the years go by.")
    )
  )
)


# Conclusion page
conclusion <- tabPanel(
  "Conclusion",
  sidebarLayout(
    sidebarPanel(
      tags$img(src = "tourists.jpg", width = "100%"),
    ),
    mainPanel(
      width = 7,
      h1("Key Takeaways"),
      h2("Takeaway 1"),
      p("As demonstrated in 'Country vs. Tourism Visualization', the GDP
       per Capita will increase on a yearly basis for most countries.
       For example, the GDP per capita in the United States increased
       from $39,476.27 in 1995 up to $51,921.98 in 2014. This insight
       implies that with time, countries will experience economic growth,
       likely as a result from the expansion of globalization and
       advancement of technology."),
      h2("Takeaway 2"),
      p("The 'Country vs. Tourism Visualization' also indicates that 
        as GDP per Capita increases, so does the number of outbound
        tourists for the majority of countries. For example, when the
        GDP per capita in China was $2564.07 in 1995, the number of
        outbound tourists was 4,520,000. Later in 2016, the GDP per
        capita was $14400.89 and the number of outbound tourists was
        135,130,000. This insight suggests that as a country becomes
        more properous (higher GDP), its citizens will have more
        disposable funds to use for international travel."),
      h2("Takeaway 3"),
      p("The 'GDP vs. Tourism Chart' indicates that an increase in
        GDP per Capita does not always correlate with a country's
        increase its number of outbound tourists. For example, when the
        GDP per capita in Denmark was $45865.80 in 2008, the number of
        outbound tourists was 6,347,000. The year after in 2009, the
        GDP per capita decreased to $43,382.63, while the number of
        outbound tourists increased to 7,037,000. This insight suggests
        that while a country's GDP per capita can impact its number of
        outbound tourists, it is not a directly proportional relationship.
        Additionally, this suggests there are other factors outside the
        scope of this data that impact a country's number of outbound
        tourists (for example, weather and political climate).")
    )
  )
)


ui <- navbarPage(
  "Tourism vs. GDP",
  theme = shinytheme("journal"),
  about,
  chart_1_page,
  chart_2_page,
  chart_3_page,
  conclusion)