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
country <- df %>%
  filter(Year == 2000) %>%
  filter(Entity != "World") %>%
  filter(Entity %in% Entity[!is.na(Tourists)]) %>%
  filter(Code != "")

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
      actionButton(inputId = "ab1",
                   label = "Learn More",
                   class = "btn-primary",
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
      p("1) Does a country's GDP per Capita increase on a
        yearly basis?"),
      p("2) Do outbound tourists per country increase when the
        GDP per capita increases?"),
      p("3) Do more developed countries with better economy per year
        increase tourism over time?")
    )
  )
)

# Page 1
chart_1_page <- tabPanel(
  "Tourists vs. GDP Plot",
  titlePanel("Tourists vs. GDP Plot"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "choose_country_plot",
                  label = h4("Select Location"),
                  choices = list(
                    "Country" = country$Entity,
                    "Region" = region$r_names,
                    "Income Level" = income$inc_lvl),
                  selected = "United States")
    ),
    mainPanel(
      h3("Number of Outbound Tourists vs. GDP per Capita"),
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

# Page 2
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
      h3("GDP & Number of Outbound Tourists in 2015"),
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

# Page 3
chart_3_page <- tabPanel(
  "Toursists in 1995 to 2015 Bar Chart",
  titlePanel("Toursists & GDP in 1995 to 2015 Chart"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "choose_country_bar",
                  label = h4("Select Location"),
                  choices = list(
                    "Country" = country$Entity,
                    "Region" = region$r_names,
                    "Income Level" = income$inc_lvl),
                  selected = "World")
    ),
    mainPanel(
      h3("Total Tourists per Year with Average GDP"),
      p("This chart attempts to display an interactive plot of
        all countries/entities with their average GDP per capita
        and Tourists from 1995 to 2016. This plot shows the
        relationship between number of outbound tourists and
        prosperity of the home country from 1995 to 2016. "),
      plotlyOutput("bar_graph"),
      h3("Findings"),
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
      p("1) Does a country's GDP per Capita increase on a
        yearly basis?"),
      p("As demonstrated in 'Tourists vs. GDP Plot', the GDP
        per Capita will increase on a yearly basis for most countries.
        For example, the GDP per capita in the United States increased
        from $39,476.27 in 1995 up to $51,921.98 in 2014. This insight
        implies that with time, countries will experience economic growth,
        likely as a result from the expansion of globalization and
        advancement of technology. Therefore, a country's GDP per Capita
        increases generally on a yearly basis as shown in 'Tourists vs.
        GDP Plot'."),
      h2("Takeaway 2"),
      p("2) Do outbound tourists per country increase when the
        GDP per capita increases?"),
      p("The 'GDP & Tourism Map' indicates that as GDP per Capita
        increases, so does the number of outbound tourists for
        the majority of countries. For example, when the GDP
        per capita in China was $2564.07 in 1995, the number of
        outbound tourists was 4,520,000. Later in 2016, the GDP per
        capita was $14400.89 and the number of outbound tourists was
        135,130,000. This insight suggests that as a country becomes
        more properous (higher GDP), its citizens will have more
        disposable funds to use for international travel."),
      h2("Takeaway 3"),
      p("3) Do more developed countries with better economy per year
        increase tourism over time?"),
      p("Tourists in 1995 to 2015 Bar Chart' indicates that the outbound
        tourism in most developed countries when their GDP per capita
        increases, grows over time. For example, the number of outbound
        tourists from South Korea in 2000 was 5,508,000. Later in
        2015, the number of outbound tourists was 19,310,000. This
        insight suggests that as a country develops over time, with
        a higher average GDP per Capita, it allows international
        travel to become more accessible. Additionally, its citizens
        will likely have more funds to use to travel due to a better
        economy.")
    )
  )
)

# Fun Facts page
fun_facts <- tabPanel(
  "Fun Facts",
  sidebarLayout(
    sidebarPanel(
      tags$img(src = "fun_facts.jpg", width = "100%"),
    ),
    mainPanel(
      width = 7,
      titlePanel("Fun Facts About Tourism"),
      p("1) 1/10 jobs are supported by the Tourism industry across
        the world."),
      p("2) Amongst emerging travel hotspots, Osaka, Japan is the world's
        fastest growing destination."),
      p("3) The word 'tourist' has been used since 1760 for individuals
        travelling for recreation."),
      p("4) The pilot and co-pilot should eat different meals to prevent
        them from upsetting their stomachs at the same time during a
        flight."),
      p("5) Statistically, a plane is actually the safest mode of
        transport in the world"),
      p("6) Vatican is the smallest country in the world, next being
        Monaco."),
      p("7) Las Vegas has the largest number of hotel rooms in the
      world."),
      p("8) Canada has over 2,000,000 lakes. It is more than the rest
        of the world combined."),
      p("9) You feel jet lag worse when travelling from west to east."),
      p("10) You can find a free wine fountain in a small town in Italy.")
    )
  )
)

# Define ui
ui <- navbarPage(
  "Tourism vs. GDP",
  theme = shinytheme("journal"),
  about,
  chart_1_page,
  chart_2_page,
  chart_3_page,
  conclusion,
  fun_facts
)
