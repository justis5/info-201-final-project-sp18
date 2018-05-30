library(dplyr)
hpi <- read.csv("data/hpi.csv", stringsAsFactors = FALSE)
import <- read.csv("data/tiv-imports-2016.csv", stringsAsFactors = FALSE)
colnames(import) <- c("Country", "import_tiv")
export <- read.csv("data/tiv-exports-2016.csv", stringsAsFactors = FALSE)
colnames(export) <- c("Country", "export_tiv")
military_expenditure <- read.csv("data/national_military_expenditure.csv", 
                                 stringsAsFactors = FALSE)
military_expenditure <- military_expenditure %>% 
  select(Country, constant_2016_usd, current_usd, share_of_gdp, 
         per_capita, share_of_govt_spending)
joined_data <- left_join(hpi, import)
joined_data <- left_join(hpi, export)
joined_data <- left_join(hpi, military_expenditure)

# One of the datasets we can work with is the SIPRI Arms Transfer database. The 
# SIPRI is the Stockholm International Peace Research Institute and an
# independent resource on global security. I accessed this database by going on 
# the SIPRI website and downloaded information from the SIPRI arms transfer 
# database as well as the SIPRI mlitary expenditure database. 
#
# The target audience could be policymakers, researchers, and media 
# since we are looking at things at a national level.
#
# The audience wants to learn from the trends and relationships at 
# the global level. 
#
# The data is available through Excel and can be easily converted into a .csv 
# file. 
#
# The types of data-wrangling needed for this data is reformatting and curating 
# data as there will be data missing. Either they were not significant enough to 
# record or there was no data available.
#
# A major challenge that I anticipate is getting the information is potraying 
# the information in a way that makes sense and that is not cluttered. Another 
# concern is the level of analysis. We may have to find another way to aggregate 
# or summarize information. That might require more data wrangling. Another major
# challenge is interpretation and creating insights that are understandable and
# useful.