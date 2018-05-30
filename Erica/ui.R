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
source("analysis.R")
source("summary.R")
library(dplyr)
library(knitr)
library(rsconnect)
library('countrycode')

# Define UI for application that draws a histogram
ui <- navbarPage("info201 final project",
  
  # Erica
  titlePanel("Happy Planet Index"),
  tabPanel('Introduction',
  titlePanel('Happy Planet Index'),
  p("The dataset we will be working with is the Happy Planet Index 2016 
    downloaded from from Happy Planet Index website.
    The group who collected the data is New Economics Foundation(NEF)."),
  img(src=imgs/equation.png),
  img(src=imgs/1.png),
  p(a(href="http://happyplanetindex.org/about/#how", "(source)")),
  P("The graph above shows how HPI is calculated. The  questions our project 
will answer by analysing the data downloaded on happyplanetindex.org are:
    1. Does higher GDP/capota correlates with a higher average life expectancy?
    2. Which regions has the highest and lowest HPI?
    3. What's the relationship between the footprint with population of a counrty?"),
  p ("Just by looking at the data, there are", num_country, "in the data, and the average Happy Planet Index 
    score is", average_HPI, ". The region with the highest Happy Planet Index 
    score is", HPI_max,"."),
  p ("The four indicators being used to calculate HPI, which are well being, 
average life expectany, inequality of outcomes, and ecological footprints, have 
an corresponding average results for all countries presented in the data set", 
average_wellbeing,average_life_expectancy, average_inequality,"%", average_footprint),
P ("the region with the highest average well being is", wellbeing_max,
    "The region with the highest average life expectany is", le_max, 
   ".The region with the lowest average inequality of outcomes is",inequality_min,
   ". Last but not the least, the region with the lowest average ecological footprints is", footprint_min),
dataTableOutput(region_hpi),

#  sidebarLayout(
#  selectInput("select", label = h3("Select box"), 
#             choices = list("Europe" = 1, "Sub Saharan Africa" = 2,
#                            "Asia Pacific" = 3, "Post-communist"= 4,
#                            "Middle East and North Africa"=5, "Americas" = 6), 
#             selected = 1),
# hr(),
# fluidRow(column(3, verbatimTextOutput("value")))
# )
  
  #justin
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
                          variables was found to be -0.056. This suggests that 
                          there is a very weak negative correlation
                          between a country's population and a country's
                          footprint.")
                   ),
          tabPanel("GDP",
                   fluidRow(
                     plotlyOutput("gdp_scatter")
                   ),
                   tags$p("If all countries are taken into consideration, the 
                          Pearson's correlation coefficient for these two
                          variables was found to be 0.80. This suggests that 
                          there is a very strong positive correlation
                          between a country's gdp per capita and a country's
                          footprint."))
                   )
          )
)
)
  
  #leo
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
  
)
  
shinyUI(ui)



  
  
  