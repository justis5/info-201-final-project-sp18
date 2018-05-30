build_hist <- function(df, bin_num) {
  chart <- ggplot(df) +
    geom_histogram(
      mapping = aes(
        x = avg_life_exp,
        fill = gdp_category
      ), binwidth = bin_num) +
    labs(
      title = "Histogram of average life expectancy and GDP",
      subtitle = "Info 201 B SP18",
      x = "Average life expectancy",
      y = "Frequency",
      fill = "GDP/Capita"
    )
  return(chart)
}