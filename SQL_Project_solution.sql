--SQL Retails Sales Analysis - P1 --

CREATE DATABASE sql_project_p1 ;    
										
-- Create Tbale--
DROP TABLE IF EXISTS retail_sales 
CREATE TABLE retail_sales 
              (transactions_id INT PRIMARY KEY,
              sale_date DATE ,
              sale_time TIME ,
              customer_id INT ,
              gender VARCHAR(15) ,
              age INT ,
              category VARCHAR(15) ,
              quantiy INT ,
              price_per_unit FLOAT ,
              cogs FLOAT ,
              total_sale Float 	
               ) ;

SELECT * FROM retail_sales 
limit 10 ;



SELECT Count(*) FROM
retail_sales 
 ;

--DATA CLEANING
SELECT * FROM retail_sales 
WHERE transactions_id IS NULL ;

SELECT * FROM retail_sales 
WHERE sale_date IS NULL ;

SELECT * FROM retail_sales 
WHERE sale_time IS NULL ;


SELECT * FROM retail_sales 
WHERE 
     transactions_id IS NULL
	 OR
	 sale_date IS NULL
	 OR
	 sale_time IS NULL
	 OR 
	 customer_id IS NULL
	 OR
	 gender IS NULL
	 OR
	 category IS NULL
	 OR
	 quantiy IS NULL
	 OR
	 cogs IS NULL
	 OR
	 total_sale IS NULL ;
	 
DELETE FROM retail_sales 
WHERE
     transactions_id IS NULL
	 OR
	 sale_date IS NULL
	 OR
	 sale_time IS NULL
	 OR 
	 customer_id IS NULL
	 OR
	 gender IS NULL
	 OR
	 category IS NULL
	 OR
	 quantiy IS NULL
	 OR
	 cogs IS NULL
	 OR
	 total_sale IS NULL ;
	 
--Data Exploration

--How many sales we have?
SELECT COUNT(*) AS total_sale from retail_sales

-- How many unique customers we have ?
SELECT COUNT(DISTINCT customer_id) AS total_sale from retail_sales

--How many category we have?
SELECT DISTINCT category FROM retail_sales;

--Data Analysis & Business Key Problems & Answers
-- Q 1. Write SQL query to retrieve all columns for sale mode on '2022-11-05'
SELECT * FROM  retail_sales
WHERE sale_date = '2022-11-05' ;

-- Q 2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022.
SELECT * FROM retail_sales
WHERE 
     category = 'Clothing'
	 AND
	 TO_CHAR(sale_date,'YYYY-MM') = '2022-11'
	 AND 
	 quantiy >= 4 ; 
	 
-- Q 3. Write a SQL query to calculate the total sales (total_sales )for each category.

SELECT category , SUM(total_sale) as net_sale ,
count(*) as total_orders
FROM retail_sales 
GROUP BY 1 ;


-- Q 4.Write a SQL query to find the avereage age of customers who purchased items from the 'Beauty' cayegory . 
SELECT
     ROUND(avg (AGE),2) as avg_age
FROM retail_sales  
WHERE category = 'Beauty';	  

-- Q 5. Write a SQL query to find all the transactions where the total sales is greater than 1000.
SELECT
    *
FROM retail_sales  
WHERE total_sale > 1000 ;

-- Q 6. Write a SQL query to find the total number of transactions (transaction_id)
--made by each gender in each categry.

SELECT
     category ,gender , count(transactions_id)as total_trans
FROM retail_sales  
   group by 
   category ,
  gender 
  ORDER BY 1;

-- Q 7. Write a SQL query to calculate the average sale for each month . Find out best selling month in each year.
SELECT
      year, 
	  month,
      avg_sale
from 
(
SELECT
     EXTRACT (YEAR FROM sale_date) as year,
     EXTRACT (MONTH FROM sale_date) as month,
     avg (total_sale)as avg_sale
	 RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date)ORDER BY avg (total_sale)DESC )AS RANK
FROM retail_sales  
    group by 1 ,2

) as t1 
where rank = 1
  --  order by 1,3 DESC

-- Q 8 Write a SQL query to find the top 5 customers based on the highest total sales .
 select customer_id , sum(total_sale)as total_sales
FROM retail_sales 
group by 1
ORDER BY 2 DESC
limit 5

-- Q 9. Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT category ,
count(DISTINCT customer_id) as count
FROM retail_sales 
group by 1 

-- Q 10. Write a SQL query to create each shift and number of orders ( examplae - morning<12 ,afternoon between 12 and 17 , evening > 17).
with hourly_sale
as 
(
select * ,
   case
       when extract (hour from sale_time)<12 then 'Morning'
	   when extract (hour from sale_time)Between 12 and 17 then 'Afternoon'
       Else 'Evening'
   END as shift
from retail_sales
)
SELECT shift,
   count (*)as orders
from hourly_sale
group by shift

--End of project
   

	   




)











