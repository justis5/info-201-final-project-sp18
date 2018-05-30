build_hist <- function(df, bin_num, color_var) {
  color_vars <- data.frame(variable = c("gdp_category", "Region"),
                           name = c("GDP/Capita", "Region"))
  color_column <- df[[color_var]]
  color_name <- as.character(color_vars$name[color_vars$variable == color_var])
  chart <- ggplot(df) +
    geom_histogram(
      mapping = aes(
        x = avg_life_exp,
        fill = color_column
      ), binwidth = bin_num) +
    labs(
      title = "Histogram of average life expectancy",
      x = "Average life expectancy",
      y = "Frequency",
      fill = color_name
    )
  return(chart)
}