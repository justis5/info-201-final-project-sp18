library(shiny)
library(plotly)
library(shinythemes)

# Define UI for application that draws a histogram
shinyUI(navbarPage(
  theme = shinytheme("readable"),
  # Application title
  "Exploring HPI Dataset",
  tabPanel(
    "Introduction",
    titlePanel("Happy Planet Index"),
    tags$p("The dataset we are working with is the Happy Planet Index 2016 
    downloaded from from the Happy Planet Index", a("website.", href = "http://happyplanetindex.org/"),
    "The group who collected the data is New Economics Foundation(NEF)."),
    tags$img(
      src = "https://static1.squarespace.com/static/5735c421e321402778ee0ce9/t/578cfd862994ca21a7d62685/1468968273705/?format=2500w",
      width = 500)
    
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
    )
  
))
