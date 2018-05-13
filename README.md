# info 201 final Project Proposal
By Erica, Emily, Leo, and Justin

## Project Description
_**What is the dataset you'll be working with?  Please include background on who collected the data, where you accessed it, and any additional information we should know about how this data came to be.**_
  The dataset we will be working with is the _Happy Planet Index 2016_ downloaded from from [Happy Planet Index website](http://happyplanetindex.org//).The group who collected the data is _New Economics Foundation(NEF)_, whom is 
  >  UK's leading think tank promoting social, economic and environmental justice.
  
_**Who is your target audience?  Depending on the domain of your data, there may be a variety of audiences interested in using the dataset.  You should hone in on one of these audiences.**_
  Our targeted audience is the general public who are interested in learning how well each country is living calcultaed by the scale of each country's wellbeing, life expectancy, inequality of outcomes, and excological footprint; and how to improve the living condition of a country with improvement on one of the above mentioned categories.

_**What does your audience want to learn from your data?  Please list out at least 3 specific questions that your project will answer for your audience.**_
  Just by looking at our project, our target audience will see a clear presentation of our data, summary and also charts. Our main database and topics are strongly related to our everyday life, we determine our delivery by making all the codes and analysis as clear and simple as possible, and charts as representative as it can be. The questions we will answer for our audiences are: 
  1. Does higher GDP/capota correlates with a higher average life expectancy? 
  2. Which regions has the highest and lowest HPI? 
  3. What's the relationship between the footprint with population of a counrty?

## Technical Description
_**How will you be reading in your data (i.e., are you using an API, or is it a static .csv/.json file)?**_
  We will be using packages such as httr, dplyr and .csv files. They all allows scripts to always work with the most correct data in the system or provided, and specifies where and how particular data is used in programming R.

_**What types of data-wrangling (reshaping, reformatting, etc.) will you need to do to your data?**_

_**What (major/new) libraries will be using in this project (no need to list common libraries that are used in many projects such as dplyr)**_
  Since our project loads data from csv.files rather than any special API's, it seems that no major/new libraries will required. We'll be using the libraries used so far during the quarter. The project will certainly use dplyr to perform data.frame manipulation as well as a combination of ggplot2 or plotly to create visualizations. The shiny library will be used to create the interactive application.  The stringr library may be used to use helpful functions like gsub.

_** What major challenges do you anticipate?**_
  One of the challenges I anticipate is portraying the information in a way that makes sense and that is not cluttered. You want to make sure that people understand what you are looking at and why. We have to make sure we provide enough detail on the things we talk about so that people aren't overwhelmed with too much info or confused because of not enough info. Another concern is the level of analysis. In order to get useful insights, we may have to find other way to aggregate, group, or summarize information. That might require more data manipulation, complicating things. Another concern is cleaning up data because when you work with multiple different frames, you may have to deal with na data or inconsistent labels or categories when you want to calculate or determine certain values. One last challenge is working with Shiny itself because sharing a Shiny App is more involved than pushing code to GitHub. Publishing is considered most of the hard parts of working with Shiny.