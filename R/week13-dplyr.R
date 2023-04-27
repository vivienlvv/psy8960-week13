# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)
library(keyring)
library(RMariaDB)


# Data Import and Cleaning

## Setting key
# key_set_with_value(service = "latis-mysql",
#                    username = "username",
#                    password = "password")

## Getting data "week13.csv" from LATIS for the project 
### I commented out the code after downloading the file 
# connection <- dbConnect(MariaDB(),
#                   user="lee02903",
#                   password=key_get("latis-mysql","lee02903"),
#                   host="mysql-prod5.oit.umn.edu",
#                   port=3306,
#                   ssl.ca = 'mysql_hotel_umn_20220728_interm.cer'
# )
# 
# databases_df <- dbGetQuery(connection, "SHOW DATABASES;")
# dbExecute(connection, "USE cla_tntlab;")
# dbGetQuery(connection, "SHOW TABLES;")
# datascience_8960_table = dbGetQuery(connection, "SELECT * FROM datascience_8960_table")
# write_csv(datascience_8960_table, "../data/week13.csv")

## Reading in created dataset 
week13_tbl = read_csv("../data/week13.csv", show_col_types = FALSE)

# Analysis

## Weird- I am assuming all entries are managers? NEED TO DOUBLE CHECK 1,2

# 1. Display the total number of managers.
week13_tbl %>% nrow()

# 2. Display the total number of unique managers (i.e., unique by id number).
week13_tbl %>% select(employee_id) %>%
  unique() %>% 
  nrow()

# 3. Display a summary of the number of managers split by location, but only include those who were not originally hired as managers.
week13_tbl %>% filter(manager_hire == "N") %>% 
  group_by(city) %>%
  summarize(n = n())


# 4. Display the average and standard deviation of number of years of employment split by performance level (bottom, middle, and top).
week13_tbl %>% group_by(performance_group) %>% 
  summarize(avg_yr_employment = mean(yrs_employed),
            sd_yr_employment = sd(yrs_employed))

# 5. Display the location and ID numbers of the top 3 managers from each location, in alphabetical order by location and then descending order of test score. If there are ties, include everyone reaching rank 3.
## How to define "top managerS"m test scores?

week13_tbl %>% group_by(city) %>%
  summarize(city, employee_id, test_score) %>% 
  slice_max(test_score, n =3) %>% 
  arrange(city, desc(test_score))
  