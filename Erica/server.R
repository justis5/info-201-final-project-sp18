#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(gridExtra)
source("analysis.R")
source("script/build_scatter.R")
hpi <- read.csv('data/hpi.csv')
hpi_region <- read.csv ("data/region_hpi.csv")
library(plotly)
library(dplyr)
library(rsconnect)
library(countrycode)

shinyServer(function(input, output) {
  output$value <- renderPrint({ input$select })
  
  output$pop_scatter <- renderPlotly({
    footprint_df <- footprint_table %>%
      filter(if (input$region != "All") region == input$region else TRUE)
    plot <- build_scatter(footprint_df, input$region, "population")
  })
  
  
  output$gdp_scatter <- renderPlotly({
    footprint_df <- footprint_table %>%
      filter(if (input$region != "All") region == input$region else TRUE)
    plot <- build_scatter(footprint_df, input$region, "gdp_capita")
  })
  output$hpiMap <- renderPlotly({
    min.hpi <- min(input$hpi)
    max.hpi <- max(input$hpi)
    mode <- input$mode
    
    attach(hpi.data)
    # hpi.data[order(Happy.Planet.Index), ]
    
    hpi.df <- hpi.data[order(Happy.Planet.Index), ] %>% 
      filter(Happy.Planet.Index <= max.hpi & Happy.Planet.Index >= min.hpi) %>% 
      select(Country, Region, Average.Life..Expectancy, Happy.Planet.Index, 
             X.GDP.capita...PPP.., Population, HPI.Rank)
    
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
})
  
  average_le_region <- function(hpi,region){
    num_le_region <- hpi %>% select(Region, Average.Life..Expectancy) %>% 
      filter(Region == region) %>% group_by(Region) %>%
      summarise(average_le_region = 
                  round(mean(Average.Life..Expectancy),digits=2))
    return(num_le_region)
  }
  
  # average footprint by region
  average_foot_region <- function(hpi,region){
    num_foot_region <- hpi %>% select(Region, Footprint..gha.capita.) %>% 
      filter(Region == region) %>% group_by(Region) %>%
      summarise(average_foot_region= round(mean(Footprint..gha.capita.), digits=2))
    return(num_foot_region)
  }
  
  # average population by region
  average_pop_region <- function(hpi,region){
    num_pop_region <- hpi %>% select(Region, Population) %>% 
      filter(Region == region) %>% group_by(Region) %>%
      summarise(average_pop_region= round(mean(Population), digits=2))
    return(num_pop_region)
  }
  # average HPI by region
  average_HPI_region <- function(hpi,region){
    num_HPI_region <- hpi %>% select(Region, Happy.Planet.Index) %>% 
      filter(Region == region) %>% group_by(Region) %>%
      summarise(average_HPI_region= round(mean(Happy.Planet.Index), digits=2))
    return(num_HPI_region)
  }
  
  })


