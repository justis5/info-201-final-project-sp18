library(dplyr)
hpi <- read.csv("data/hpi.csv")
 
# num of country
num_country <- nrow(hpi)

# num of country by their region
num_country_region <- function(hpi,region) {
  num_region <- nrow(hpi %>% 
                      filter(Region== region))
  return(num_region)
}

# average life expectancy for all country
average_life_expectancy <- sum(hpi$Average.Life..Expectancy)/num_country

# avergae life expectancy by region
average_le_region <- function(hpi,region){
        num_le_region <- hpi %>% select(Region, Average.Life..Expectancy) %>% 
                    filter(Region == region) %>% group_by(Region) %>%
                    summarise(average_le_region = 
                                round(mean(Average.Life..Expectancy),digits=2))
  return(num_le_region)
}

# average footprint for all country
average_footprint <- mean(hpi$Footprint..gha.capita.)

# average footprint by region
average_foot_region <- function(hpi,region){
  num_foot_region <- hpi %>% select(Region, Footprint..gha.capita.) %>% 
                    filter(Region == region) %>% group_by(Region) %>%
                    summarise(average_foot_region= round(mean(Footprint..gha.capita.), digits=2))
  return(num_foot_region)
}

#aver
# by region data
region_hpi<- hpi %>% 
          select(Region, Average.Life..Expectancy, Average.Wellbeing..0.10., 
                 Happy.Life.Years, Footprint..gha.capita., Population, 
                 Happy.Planet.Index, X.GDP.capita....) %>% 
          group_by(Region) %>% 
          summarise(Average.Life.Expectancy= round(mean(Average.Life..Expectancy),digits=2),
                    Average.Wellbeing = round(mean(Average.Life..Expectancy),digits=2),
                    Happy.Life.Year = round(mean(Happy.Life.Years),digits=2),
                    Footprint = round(mean(Footprint..gha.capita.),digits=2),
                    population = round(mean(Population),digits=2),
                    Happy.Planet..Index = round(mean(Happy.Planet.Index),digits=2),
                    GDP.per.capita =round(mean(X.GDP.capita....),digits=2))
write.csv(region_hpi,file="data/region_hpi.csv")