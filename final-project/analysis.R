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
            pop_pcc = cor(population, footprint),
            gdp_pcc = cor(gdp_capita, footprint))

colnames(footprint_region_summary)[colnames(footprint_region_summary) ==
                            "mean_population"] <- "mean pop (mill)"
colnames(footprint_region_summary)[colnames(footprint_region_summary) == 
                                     "mean_footprint"] <-
  "footprint (gha capita)" 

overall_pop_pcc <- cor(footprint_table$population, footprint_table$footprint)
pop_p_value <- cor.test(footprint_table$population,
                        footprint_table$footprint)$p.value

overall_gdp_pcc <- cor(footprint_table$gdp_capita, footprint_table$footprint)
gdp_p_value <- cor.test(footprint_table$gdp_capita,
                        footprint_table$footprint)$p.value
