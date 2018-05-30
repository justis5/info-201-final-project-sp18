library(shiny)
library(plotly)
library(shinythemes)
source("analysis.R")
shinyUI(navbarPage(
  theme = shinytheme("readable"),
  "Measuring Happiness Around the World",
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
))