
Does higher GDP/capota correlates with a higher average life expectancy?
library(dplyr)
library(ggplot2)
hpi <- read.csv("data/hpi.csv", stringsAsFactors = FALSE)

histogram_AvglifeExp <- function(dataset) {
  AvglifeExp <- dataset$Average.Life..Expectancy
  AvglifeExp <- AvglifeExp[!is.na(AvglifeExp)]
  chart <- ggplot(data = AvglifeExp) +
    geom_histogram(
      mapping = aes(
        x = Average.Life..Expectancy,
        fill = X.GDP.capita...PPP..
      ))
  labs(
    title = "Histogram of average life expectancy and GDP",
    subtitle = "Info 201 B SP18",
    x = "Average life expectancy",
    y = "Frequency",
    fill = "GDP/Capita"
  )
  return(chart)
}

gsub("\\$|,", "", X.GDP.capita...PPP.._column)
as.numeric(X.GDP.capita...PPP.._column)
