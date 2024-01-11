####################################
## Chapter 3: Data Transformation ##
####################################
#https://r4ds.hadley.nz/data-transform
#####
# 3.1 Introduction

# visualization is important for generating insight but rare that data comes neat and tidy for that purpose

library(nycflights13)
library(tidyverse)

flights
# flights is a tibble which is a special type of data frame used by the tidyverse
# tibbles print differently to dataframes, such that they only show the first few 
# rows since they are desgined for larger datasets
# to view an entire tibble 
View(flights)

print(flights, width = Inf)

glimpse(flights)

# dplyr basics
# 1. the first argument is always a dataframe
# 2. the subsequent arguments typically describe which columns to operate on, 
# using the variable names (without quotes)
# 3. the output is always a new data frame

# dplyrs verbs can be piped or combined to solve complex problems
# the pipe basically means 'then'

# dplyrs verbs are organised into four groups based on what they operate on
# rows
# columns
# groups
# tables - will be covered in chapter 19

#####
# Rows


