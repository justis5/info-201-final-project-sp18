library("shiny")
library("plotly")
library("dplyr")
library("rsconnect")
library("countrycode")

hpi.data <- read.csv("./data/hpi.csv")

shinyServer(function(input, output) {
  output$explanation <- renderImage({
    list(src = "./imgs/1.png",
         width = 800)
  }, deleteFile = FALSE)
  
  output$life_scatter <- renderPlotly({
    life_exp_df <- life_exp_table %>%
      filter(if (input$life_region != "All") Region == input$life_region
             else TRUE)
    plot <- build_scatter_life_exp(life_exp_df, input$life_region)
  })
  
  
  # Define server logic required to draw a histogram
  output$life_hist <- renderImage({
    outfile <- tempfile(fileext = ".png")
    png(outfile, width = 500, height = 400)
    print(build_hist(hist_hpi, input$bins, input$color))
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
      text = paste0("HPI rank: ", hpi.df$HPI.Rank, "<br>", "GDP per capitaa: ", hpi.df$X.GDP.capita....,
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
  
  output$pop_scatter <- renderPlotly({
    footprint_df <- footprint_table %>%
      filter(if (input$region != "All") region == input$region else TRUE)
    plot <- build_scatter(footprint_df, input$region, "population")
  })
  
  output$region_summary <- renderTable(footprint_region_summary)
  output$gdp_scatter <- renderPlotly({
    footprint_df <- footprint_table %>%
      filter(if (input$region != "All") region == input$region else TRUE)
    plot <- build_scatter(footprint_df, input$region, "gdp_capita")
  })
  
})
