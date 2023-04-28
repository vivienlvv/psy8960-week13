SHOW DATABASES;
USE cla_tntlab;

SHOW TABLES;

# Question 1
SELECT COUNT(*)
FROM datascience_8960_table;

# Question 2 
SELECT COUNT(DISTINCT(employee_id))
FROM datascience_8960_table;

# Question 3 
SELECT city, COUNT(employee_id)
FROM datascience_8960_table
WHERE manager_hire = 'N'
GROUP BY city;

# Question 4 (need to double check STD function)
SELECT performance_group, AVG(yrs_employed), STD(yrs_employed)
FROM datascience_8960_table
GROUP BY performance_group;

# Question 5 

WITH added_ranking AS(
	SELECT *, DENSE_RANK() OVER(PARTITION BY city ORDER BY city, test_score DESC) AS ranking 
    FROM datascience_8960_table)
	SELECT city, employee_id, test_score, ranking
	FROM added_ranking
	WHERE ranking <= 3
	ORDER BY city ASC, test_score DESC;




ORDER BY city ASC, test_score DESC;

SHOW TABLES;



SELECT employee_id FROM datascience_8960_table