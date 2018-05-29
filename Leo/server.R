library("shiny")
library("plotly")
library("dplyr")
library("rsconnect")
library("countrycode")


shinyServer(function(input, output) {
  
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

    ###########################
  })
})





