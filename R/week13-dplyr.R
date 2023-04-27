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




# Publication