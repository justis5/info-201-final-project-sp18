library(shiny)
library(plotly)
library(shinythemes)

shinyUI(navbarPage(
  theme = shinytheme("flatly"),
  # Application title
  "Exploring HPI Dataset",
  tabPanel(
    "Introduction",
    titlePanel("Happy Planet Index"),
    tags$p("The dataset we are working with is the Happy Planet Index 2016 
    downloaded from from the Happy Planet Index", a("website.",
                                                    href = "http://happyplanetindex.org/"),
           "The group who collected the data is New Economics Foundation(NEF)."),
    tags$p("New Economics Foundation (NEF) is the UK's leading think tank 
           promoting social, economic and environmental justice."),
    tags$h3("What is HPI?"),
    tags$p("HPI calculates how satisfied the residents are with their lives in 
           that country. It takes into account variables that we will explore
           such as a country’s ecological footprint per capita,
           average life expectancy, and GDP per capita($)."),
    tags$p("HPI provides a metric that is able to assess 'the production of 
           human well-being (not necessarily material goods) per unit of
           extraction of or imposition upon nature' in a quantitative 
           measurement."),
    tags$img(
      src = "https://static1.squarespace.com/static/5735c421e321402778ee0ce9/t/578cfd862994ca21a7d62685/1468968273705/?format=2500w",
      width = 500),
    imageOutput("explanation"),
    tags$h3("What sort of data does this dataset have?"),
    tags$p("For each country, there is information on HPI rank/score, life
           expectancy, well-being, ecological footprint, inequality, 
           GDP per capita($), and population."),
    
    tags$ul(tags$li(tags$b("Qualitative variables:"), "region"),
            tags$li(tags$b("Quantitative variables:"), "average life expectancy 
                    at birth, average well-being on a scale of ten, happy life 
                    years, footprint in gha capita, inequality of outcome, 
                    inequality-adjusted life expectancy, inequality-adjusted 
                    wellbeing,  the Happy Planet index score, GDP per capita, and 
                    population.")
      
    ),
    tags$h3("What questions will be answered?"),
    tags$p("The graph above shows how HPI is calculated. The questions our project 
will answer by analysing the data downloaded on happyplanetindex.org are:"),
    tags$ol(
      tags$li("Does higher GDP/capota correlates with a higher average life expectancy?"),
      tags$li("Which regions has the highest and lowest HPI?"),
      tags$li("What's the relationship between the footprint with population of a counrty?")
    ),
    tags$h3("Summary"),
    tags$p("Just by looking at the data, there are", num_country, "in the data, 
            and the average Happy Planet Index score is", average_HPI,
           ". The region with the highest Happy Planet Index score is", HPI_max,
           "."),
    tags$p("The four indicators being used to calculate HPI, which are 1) well being, 
2) average life expectany, 3) inequality of outcomes, and 4) ecological footprints, have 
       an corresponding average results for all countries presented in the data set"),
    tags$ol(tags$li(round(average_wellbeing, 2)), tags$li(average_life_expectancy), 
            tags$li(paste0(round(average_inequality, 2),"%")), tags$li(average_footprint)),
    tags$p("Here are several other insights"),
    tags$ul(tags$li("The region with the highest average well being is", wellbeing_max),
       tags$li("The region with the highest average life expectany is", le_max), 
       tags$li("The region with the lowest average inequality of outcomes is",inequality_min),
       tags$li("Last but not the least, the region with the lowest average ecological footprints is", footprint_min))
  ),
  # tab panel for histogram
  tabPanel(
    "Life Expectancy",
    titlePanel("Life Expectancy"),
    # create sidebar layout for histogram
    sidebarLayout(
      sidebarPanel(
        tags$h4("Scatterplot Options"),
        selectInput(
          "life_region",
          label = "Select region",
          choices = c(as.list(life_exp_table[, 2]), "All"),
          selected = "All"
        ),
        tags$h4("Histogram Options"),
        sliderInput(
          "bins",
          "Number of bins",
          min = 5,
          max = 10,
          value = 7),
        selectInput(
          "color",
          "Color variable",
          choices = list(
            "GDP/Capita" = "gdp_category",
            "Region" = "Region"
          )
        )
          
      ),
      mainPanel(
        tabsetPanel(
          tabPanel("Scatterplot",
                   fluidRow(
                     plotlyOutput("life_scatter")
                   ),
                   tags$p("If all countries are taken into consideration,",
                          tags$i("the Pearson's correlation coefficient"), 
                          "for these two variables was found to be ", 
                          paste0(signif(overall_life_pcc, 3), "."),"This suggests 
                          that there is a",
                          tags$b("moderate positive correlation"),
                          "between a country's gdp per capita and
                          life expectancy."),
                   tags$p("With a",
                          tags$i("p-value"), "of",
                          tags$b(paste0(signif(life_p_value, 3), ",")), "there 
                          is enough evidence to reject the null hypothesis that
                          the true correlation is equal to 0. The results were 
                          statistically significant.")
                   ),
          tabPanel("Histogram",
                   fluidRow(
                     imageOutput("life_hist")
                   )
            
          )
        )
        
  
      )
    )
    
    
  ),
  
  tabPanel(
    "HPI",
    titlePanel("Worldwide HPI"),
    
    sidebarLayout(
      sidebarPanel(
        
        sliderInput("hpi",
                    "hpi range:",
                    min = 12.8,
                    max = 44.7,
                    value = c(20, 35))
      ),
      
      mainPanel(
        plotlyOutput("hpiMap")
      )
    )
  ),
  
  tabPanel(
    "Footprint",
    titlePanel("Footprint Trends"),
    # create sidebar layout
    sidebarLayout(
      sidebarPanel(
        selectInput(
          "region",
          label = "Select region",
          choices = c(as.list(footprint_table[, 2]), "All"),
          selected = "All"
        )
      ),
      mainPanel(
        tabsetPanel(
          tabPanel("Population",
                   fluidRow(
                     plotlyOutput("pop_scatter"),
                     textOutput("pop_info")
                   ),
                   tags$p("If all countries are taken into consideration,",
                          tags$i("the Pearson's correlation coefficient"),
                          "for these two variables was found to be ", 
                          paste0(signif(overall_pop_pcc, 3), "."),"This suggests 
                          that there is a ",
                          tags$b("very weak negative"), "correlation
                          between a country's population and a country's
                          footprint."),
                   tags$p("With a",
                          tags$i("p-value"), "of",
                          tags$b(paste0(signif(pop_p_value, 3), ",")), "there
                          is not enough evidence to reject the null hypothesis
                          that the true correlation is equal to 0. The results
                          were not statistically significant.")
                   ),
          tabPanel("GDP",
                   fluidRow(
                     plotlyOutput("gdp_scatter")
                   ),
                   tags$p("If all countries are taken into consideration,",
                          tags$i("the Pearson's correlation coefficient"),
                          "for these two variables was found to be ", 
                          tags$b(paste0(signif(overall_gdp_pcc, 3), ".")), 
                          "This suggests that there is a",
                          tags$b("very strong positive"),
                          "correlation between a country's gdp per capita and a 
                          country's footprint."),
                   tags$p("With a", tags$i("p-value"), "of", 
                          tags$b(paste0(signif(gdp_p_value, 2), ",")), "there 
                          is enough evidence to reject the null hypothesis that
                          the true correlation is equal to 0. The results were 
                          statistically significant.")
                   ),
          tabPanel("Region Summary",
                   fluidRow(
                     column(6,
                            tableOutput("region_summary")
                       
                     )
                   ),
                   tags$h2("Note"),
                   tags$p("Within the region specified, pop_pcc is the 
                          Pearson correlation coefficient between
                          a country's population and their footprint."),
                   tags$p("Within the region specified, gdp_pcc is the
                          Pearson correlation coefficient between
                          a country's gdp per capita and their footprint.")
                   )
          )
        )
      )
    ),
    tabPanel(
      "About Us",
      titlePanel("Info201 group BC6"),
      tags$p("We are a group of students enrolled in the INFO 201B in spring 2018,
             and this is our final project."),
      tags$b("Emily Liu"),
      tags$p("Emily is a Freshmen intend to major in Business."),
      tags$b("Leo Guo"),
      tags$p("Leo is a Sophomore intend to major in Infomatics."),
      tags$b("Justin Sim"),
      tags$p("Justin is a Junior pursuing Sociology and Infomatics."),
      tags$b("Erica Tan"),
      tags$p("Erica is a Junior pursuing Sociology and minor in Infomatics.")
    )
  
))
