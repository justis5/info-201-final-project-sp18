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
        sliderInput(
          "bins",
          "Number of bins",
          min = 5,
          max = 10,
          value = 7)
          
      ),
      mainPanel(
        imageOutput("life_hist")
  
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
  )
  
  
))
