library("shiny")
library("plotly")
library("dplyr")
library("rsconnect")
library("countrycode")

hpi.data <- read.csv("./data/hpi.csv")

# Which regions has the highest and lowest HPI?

ui <- fluidPage(
  # Application title
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