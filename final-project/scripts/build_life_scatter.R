build_scatter_life_exp <- function(df, region_input) {
  var_units <- data.frame(variable = c("Population", "gdp_capita"),
                          name = c("Population", "GDP"),
                          unit = c("Population (millions)",
                                   "GDP per capita (thousands)"),
                          color = c("gdp_capita", "Population"))
  x <- df[["gdp_capita"]]
  x_name <- "GDP"
  x_axis <- "GDP per capita (thousands)"
  y <- df[["avg_life_exp"]]
  title <- paste( "Life Expectancy vs.", x_name)
  if (region_input == "All") {
    color <- df[["Region"]]
    p <- ggplot(df) +
      geom_point(mapping = aes(x, y, fill = color)) +
      labs(
        title = title,
        x = x_axis,
        y = "Life Expectancy (years)",
        fill = "Region"
      ) +
      theme(plot.margin = unit(c(1,1,1,1), "cm"))
  } else {
    color <- df[["Population"]]
    color_label <- "Population (millions)"
    p <- ggplot(df) +
      geom_point(mapping = aes(x, y, color = color, alpha = 0.4)) +
      labs(
        title = title,
        x = x_axis,
        y = "Life Expectancy (Years)",
        color = color_label
      ) +
      theme(plot.margin = unit(c(1,1,1,1), "cm"))
  }
  return(p)
}