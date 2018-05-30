
build_scatter <- function(df, region_input, x_var) {
  var_units <- data.frame(variable = c("population", "gdp_capita"),
                          name = c("Population", "GDP"),
                          unit = c("Population (millions)",
                                   "GDP per capita (thousands)"),
                          color = c("gdp_capita", "population"))
  x <- df[[x_var]]
  x_name <- as.character(var_units$name[var_units$variable == x_var])
  x_axis <- as.character(var_units$unit[var_units$variable == x_var])
  y <- df[["footprint"]]
  title <- paste( "Footprint vs.", x_name)
  if (region_input == "All") {
    color <- df[["region"]]
    p <- ggplot(df) +
      geom_point(mapping = aes(x, y, fill = color)) +
      labs(
        title = title,
        x = x_axis,
        y = "Footprint (gha capita)",
        fill = "Region"
      ) +
      theme(plot.margin = unit(c(1,1,1,1), "cm"))
  } else {
    color_var <- as.character(var_units$color[var_units$variable == x_var])
    color <- df[[color_var]]
    color_label <- as.character(var_units$unit[var_units$variable == color_var])
    p <- ggplot(df) +
      geom_point(mapping = aes(x, y, color = color, alpha = 0.4)) +
      labs(
        title = title,
        x = x_axis,
        y = "Footprint (gha capita)",
        color = color_label
      ) +
      theme(plot.margin = unit(c(1,1,1,1), "cm"))
  }
  return(p)
}