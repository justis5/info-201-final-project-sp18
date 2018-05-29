
# Does higher GDP/capota correlates with a higher average life expectancy?
library(dplyr)
library(ggplot2)
hpi <- read.csv("data/hpi.csv", stringsAsFactors = FALSE)


# Rename columns to make variables easier to use
colnames(hpi)[colnames(hpi) == "Average.Life..Expectancy"] <- 
  "avg_life_exp"
colnames(hpi)[colnames(hpi) == "X.GDP.capita...."] <-
  "gdp_capita"

# Remove formatting from the GDP column
hpi$gdp_capita <- gsub(",", "", hpi$gdp_capita)
hpi$gdp_capita <- as.numeric(hpi$gdp_capita)

# Think about a different column
br = seq(0, 106000,by=21200)

ranges = paste(head(br,-1), br[-1], sep=" - ")
freq = hist(hpi$gdp_capita, breaks=br, include.lowest=TRUE, plot=FALSE)
table_df <- data.frame(range = ranges, frequency = freq$counts)
table_df$low <- c(0, 21200, 42400, 63600, 84800)
table_df$high <- c(21200, 42400, 63600, 84800, 106000)
hpi$gdp_category <- cut(hpi$gdp_capita, seq(from = 0, to = 106000, by = 21200))


# Source: 
# https://stackoverflow.com/questions/27839432/
# how-to-generate-bin-frequency-table-in-r

# https://stackoverflow.com/questions/32975801/
# specifying-bin-range-values-for-continuous-data-in-r


hpi$gdp_under_value <- c(hpi$gdp < 50000)

histogram_AvglifeExp <- function(dataset) {
  chart <- ggplot(dataset) +
    stat_bin(
      mapping = aes(
        x = avg_life_exp,
        color = gdp_category
      ), binwidth = 7) +
  labs(
    title = "Histogram of average life expectancy and GDP",
    subtitle = "Info 201 B SP18",
    x = "Average life expectancy",
    y = "Frequency",
    fill = "GDP/Capita"
  )
  return(chart)
}


