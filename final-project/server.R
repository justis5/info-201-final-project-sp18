#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library("shiny")
library("plotly")
library("dplyr")
library("rsconnect")
library("countrycode")


source("histogram_analysis.R")
source("scripts/build_histogram.R")
hpi.data <- read.csv("./data/hpi.csv")

shinyServer(function(input, output) {
  
  # Define server logic required to draw a histogram
  output$life_hist <- renderImage({
    outfile <- tempfile(fileext = ".png")
    png(outfile, width = 500, height = 400)
    print(build_hist(hist_hpi, input$bins))
    dev.off()
    list(src = outfile,
         content = "image/png",
         width = 500,
         height = 400,
         alt = "This is alternate text")
    
  }, deleteFile = TRUE)
  
  output$hpiMap <- renderPlotly({
    min.hpi <- min(input$hpi)
    max.hpi <- max(input$hpi)
    mode <- input$mode
    
    attach(hpi.data)
    # hpi.data[order(Happy.Planet.Index), ]
    
    hpi.df <- hpi.data[order(Happy.Planet.Index), ] %>% 
      filter(Happy.Planet.Index <= max.hpi & Happy.Planet.Index >= min.hpi) %>% 
      select(Country, Region, Average.Life..Expectancy, Happy.Planet.Index, 
             X.GDP.capita...., Population, HPI.Rank)
    
    ##########################
    
    hpi.df$Country.code <- countrycode(hpi.df$Country, "country.name", "iso3c")
    
    plot_ly (
      type = 'choropleth',
      locations = hpi.df$Country.code , locationmode = 'world' , colorscale = 'Viridis' ,
      z = hpi.df$Happy.Planet.Index,
      text = paste0("HPI rank: ", hpi.df$HPI.Rank, "<br>", "GDP per capia: ", hpi.df$X.GDP.capita...PPP..,
                    "<br>", "HPI: ", hpi.df$Happy.Planet.Index, "<br>", "Population: ",
                    hpi.df$Population, "<br>", "Average Life Expectancy: ",
                    hpi.df$Average.Life..Expectancy)
    ) %>%
      layout (geo = list(scope = 'world',
                         showland = TRUE,
                         landcolor = toRGB("gray95")),
              title = paste0("Worldwide Happy Planet Index", "<br>", "(hover for more information)"))
    
    ###########################
  })
  
})
