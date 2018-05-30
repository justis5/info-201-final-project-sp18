# relationship between footprint and population of a country
library(dplyr)
library(stringr)
hpi_df <- read.csv("data/hpi.csv", stringsAsFactors = FALSE)
footprint_table <- hpi_df %>%
  select(Country, Region, X.GDP.capita....,Population, Footprint..gha.capita.)
colnames(footprint_table)[colnames(footprint_table) ==
                            "X.GDP.capita...."] <- "GDP_capita"
colnames(footprint_table)[colnames(footprint_table) == 
                            "Footprint..gha.capita."] <- "footprint"
colnames(footprint_table) <- tolower(colnames(footprint_table))

footprint_table$gdp_capita <- gsub("\\$|,", "", footprint_table$gdp_capita)
footprint_table$gdp_capita <- as.numeric(footprint_table$gdp_capita)
footprint_table$gdp_capita <- footprint_table$gdp_capita / (1000)

footprint_table$population <- gsub(",", "", footprint_table$population)
footprint_table$population <- as.numeric(footprint_table$population)
footprint_table$population <- footprint_table$population / (10^6)

footprint_region_summary <- footprint_table %>%
  group_by(region) %>%
  summarise(countries = n(),
            mean_population = mean(population),
            mean_footprint = mean(footprint),
            pop_pearson_value = cor(population, footprint),
            gdp_pearson_value = cor(gdp_capita, footprint))



