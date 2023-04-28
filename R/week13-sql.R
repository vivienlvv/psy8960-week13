# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(keyring)
library(RMariaDB)
library(tidyverse)

## Making connection
connection <- dbConnect(MariaDB(),
                        user="lee02903",
                        password=key_get("latis-mysql","lee02903"),
                        host="mysql-prod5.oit.umn.edu",
                        port=3306,
                        ssl.ca = 'mysql_hotel_umn_20220728_interm.cer')

# Analysis
dbExecute(connection, "USE cla_tntlab;")
dbGetQuery(connection, "SHOW TABLES;")

## 1. Display the total number of managers.
dbGetQuery(connection,
          "SELECT COUNT(*) AS total_manager
          FROM datascience_8960_table;")

## 2. Display the total number of unique managers (i.e., unique by id number).
dbGetQuery(connection,
          "SELECT COUNT(DISTINCT(employee_id)) AS unique_manager_num
           FROM datascience_8960_table;")

## 3. Display a summary of the number of managers split by location, but only include those who were not originally hired as managers.
dbGetQuery(connection,
          "SELECT city, COUNT(employee_id) AS manager_count
           FROM datascience_8960_table
           WHERE manager_hire = 'N'
           GROUP BY city;")

## 4. Display the average and standard deviation of number of years of employment split by performance level (bottom, middle, and top).
dbGetQuery(connection, 
           "SELECT performance_group, AVG(yrs_employed) AS mean_yr_employment, STD(yrs_employed) AS sd_yr_employment
           FROM datascience_8960_table
           GROUP BY performance_group;")

## 5. Display the location and ID numbers of the top 3 managers from each location, in alphabetical order by location and then descending order of test score. If there are ties, include everyone reaching rank 3.
dbGetQuery(connection,
           "WITH added_ranking AS(
             SELECT *, DENSE_RANK() OVER(PARTITION BY city ORDER BY city, test_score DESC) AS ranking 
             FROM datascience_8960_table)
             SELECT city, employee_id, test_score, ranking
             FROM added_ranking
             WHERE ranking <= 3
             ORDER BY city ASC, test_score DESC;")