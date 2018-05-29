library(gridExtra)
source("analysis.R")
source("script/build_scatter.R")

shinyServer(function(input, output) {
  
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
})

