# Does higher GDP/capota correlates with a higher average life expectancy?
library(dplyr)
library(ggplot2)
hist_hpi <- read.csv("data/hpi.csv", stringsAsFactors = FALSE)


# Rename columns to make variables easier to use
colnames(hist_hpi)[colnames(hist_hpi) == "Average.Life..Expectancy"] <- 
  "avg_life_exp"
colnames(hist_hpi)[colnames(hist_hpi) == "X.GDP.capita...."] <-
  "gdp_capita"

# Remove formatting from the GDP column
hist_hpi$gdp_capita <- gsub(",", "", hist_hpi$gdp_capita)
hist_hpi$gdp_capita <- as.numeric(hist_hpi$gdp_capita)

# Think about a different column
br = seq(0, 106000,by=21200)

ranges = paste(head(br,-1), br[-1], sep=" - ")
freq = hist(hist_hpi$gdp_capita, breaks=br, include.lowest=TRUE, plot=FALSE)
table_df <- data.frame(range = ranges, frequency = freq$counts)
table_df$low <- c(0, 21200, 42400, 63600, 84800)
table_df$high <- c(21200, 42400, 63600, 84800, 106000)
hist_hpi$gdp_category <- cut(hist_hpi$gdp_capita, 
                             seq(from = 0, to = 106000,
                                 by = 21200))


# Source: 
# https://stackoverflow.com/questions/27839432/
# how-to-generate-bin-frequency-table-in-r

# https://stackoverflow.com/questions/32975801/
# specifying-bin-range-values-for-continuous-data-in-r

life_exp_table <- hist_hpi %>%
  select(Country, Region, gdp_capita, Population, avg_life_exp)

life_exp_table$gdp_capita <- life_exp_table$gdp_capita / 1000
life_exp_table$Population <- life_exp_table$Population / (10^6)
