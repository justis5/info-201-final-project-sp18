#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)
library(shinythemes)

# Define UI for application that draws a histogram
shinyUI(navbarPage(
  theme = shinytheme("readable"),
  # Application title
  "Exploring HPI Dataset",
  
  # tab panel for histogram
  tabPanel(
    "life expectancy",
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
                   )
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
                   tags$p("If all countries are taken into consideration, the 
                          Pearson's correlation coefficient for these two
                          variables was found to be ", 
                          paste0(signif(overall_pop_pcc, 3), "."),"This suggests 
                          that there is a very weak negative correlation
                          between a country's population and a country's
                          footprint."),
                   tags$p("With a p-value of ",
                          paste0(signif(pop_p_value, 3), ",") , "there
                          is not enough evidence to reject the null hypothesis
                          that the true correlation is equal to 0. The results
                          were not statistically significant.")
                   ),
          tabPanel("GDP",
                   fluidRow(
                     plotlyOutput("gdp_scatter")
                   ),
                   tags$p("If all countries are taken into consideration, the 
                          Pearson's correlation coefficient for these two
                          variables was found to be ", 
                          paste0(signif(overall_gdp_pcc, 3), "."), 
                          "This suggests that there is a very strong positive
                          correlation between a country's gdp per capita and a 
                          country's footprint."),
                   tags$p("With a p-value of ", 
                          paste0(signif(gdp_p_value, 2), ","), "there 
                          is enough evidence to reject the null hypothesis that
                          the true correlation is equal to 0. The results were 
                          statistically significant.")
                   ),
          tabPanel("Summary",
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
