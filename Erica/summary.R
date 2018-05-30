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

# average HPI
average_HPI <- round(sum(hpi$Happy.Planet.Index)/num_country, digits=2)

# average life expectancy for all country
average_life_expectancy <- round(sum(hpi$Average.Life..Expectancy)/num_country,
                                 digits=2)
# average footprint for all country
average_footprint <- mean(hpi$Footprint..gha.capita.)

#average inequality of outcomes
average_inequality <-(mean(hpi$Inequality.of.Outcomes)*100)

#average well being
average_wellbeing <-mean(hpi$Average.Wellbeing..0.10.)

# avergae life expectancy by region
average_le_region <- function(hpi,region){
        num_le_region <- hpi %>% select(Region, Average.Life..Expectancy) %>% 
                    filter(Region == region) %>% group_by(Region) %>%
                    summarise(average_le_region = 
                                round(mean(Average.Life..Expectancy),digits=2))
  return(num_le_region)
}
# average inequality of outcomes by region
average_inequality_region <- function(hpi,region){
  num_inequality_region <- hpi %>% select(Region, Inequality.of.Outcomes..out.of.1.) %>% 
    filter(Region == region) %>% group_by(Region) %>%
    summarise(average_inequality_region= (mean(Inequality.of.Outcomes..out.of.1.)*100))
  return(num_inequality_region)
}


# average footprint by region
average_foot_region <- function(hpi,region){
  num_foot_region <- hpi %>% select(Region, Footprint..gha.capita.) %>% 
                    filter(Region == region) %>% group_by(Region) %>%
                    summarise(average_foot_region= round(mean(Footprint..gha.capita.), digits=2))
  return(num_foot_region)
}

# average well being by region
average_well <- function(hpi,region){
  num_well_region <- hpi %>% select(Region, Average.Wellbeing..0.10.) %>% 
    filter(Region == region) %>% group_by(Region) %>%
    summarise(average_well= round(mean(Average.Wellbeing..0.10.), digits=2))
  return(num_well_region)
}

# average HPI by region
average_HPI_region <- function(hpi,region){
  num_HPI_region <- hpi %>% select(Region, Happy.Planet.Index) %>% 
    filter(Region == region) %>% group_by(Region) %>%
    summarise(average_HPI_region= round(mean(Happy.Planet.Index), digits=2))
  return(num_HPI_region)
}

# by region data
region_hpi<- hpi %>% 
          select(Region, Average.Life..Expectancy, Average.Wellbeing..0.10., 
                 Inequality.of.Outcomes..out.of.1., Footprint..gha.capita., Population, 
                 Happy.Planet.Index, X.GDP.capita....) %>% 
          group_by(Region) %>% 
          summarise(Average.Life.Expectancy= round(mean(Average.Life..Expectancy),digits=2),
                    Average.Wellbeing = round(mean(Average.Life..Expectancy),digits=2),
                    Footprint = round(mean(Footprint..gha.capita.),digits=2),
                    population = round(mean(Population),digits=2),
                    Happy.Planet..Index = round(mean(Happy.Planet.Index),digits=2),
                    GDP.per.capita. =round(mean(X.GDP.capita....),digits=2),
                    Inequality.of.Outcomes = round(mean(Inequality.of.Outcomes..out.of.1.)*100, digits=2))
write.csv(region_hpi,file="data/region_hpi.csv")

#highest HPI region
HPI_max <- region_hpi %>% 
            filter(Happy.Planet..Index == max(Happy.Planet..Index)) %>%
            select(Region, Happy.Planet..Index)

#highest average Life expectancy region
le_max <- region_hpi %>% 
  filter(Average.Life.Expectancy == max(Average.Life.Expectancy)) %>%
  select(Region, Average.Life.Expectancy) 

#highest well being region
wellbeing_max <- region_hpi %>% 
  filter(Average.Wellbeing == max(Average.Wellbeing)) %>%
  select(Region, Average.Wellbeing) 


#lowest inequality region
inequality_min <- region_hpi %>% 
  filter(Inequality.of.Outcomes == min(Inequality.of.Outcomes)) %>%
  select(Region, Inequality.of.Outcomes) 

#lowest footprint region
footprint_min <- region_hpi %>% 
                filter(Footprint == min(Footprint)) %>%
                select(Region, Footprint) 

#highest GDP region
GDP_max <- region_hpi %>% 
          filter(GDP.per.capita == max(GDP.per.capita)) %>%
          select(Region, GDP.per.capita) 
