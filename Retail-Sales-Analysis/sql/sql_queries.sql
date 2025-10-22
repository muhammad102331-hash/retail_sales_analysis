CREATE DATABASE sql_project_p2;

DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
            (
                transaction_id INT PRIMARY KEY,	
                sale_date DATE,	 
                sale_time TIME,	
                customer_id	INT,
                gender	VARCHAR(15),
                age	INT,
                category VARCHAR(15),	
                quantity	INT,
                price_per_unit FLOAT,	
                cogs	FLOAT,
                total_sale FLOAT
            );

SELECT * FROM retail_sales;

--Basic Table View & Count
select * from retail_sales
limit 10;


--Counts total records (number of transactions
select count(*) from retail_sales;


--Find Misssing Values
select * from retail_sales
where transaction_id is null
 or sale_date is null
 or sale_time is null
 or customer_id is null
 or gender is null
 or age is null
 or category is null
 or quantity is null
 or price_per_unit is null
 or cogs is null;


--Delete missing values:
delete from retail_sales
where transaction_id is null
 or sale_date is null
 or sale_time is null
 or customer_id is null
 or gender is null
 or age is null
 or category is null
 or quantity is null
 or price_per_unit is null
 or cogs is null;

-- 📊 . Data Exploration
--How many total sales?
select count(*) as total_sales
from retail_sales;


--How many unique customers?
select count(Distinct customer_id) as unique_customer from retail_sales;


--What categories exist?
select distinct category from retail_sales;


-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
select * from retail_sales
where sale_date = '2022-11-05';


-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022

select * from retail_sales
where category = 'Clothing'
and
TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
AND
quantity >= 4;


--
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

select category, sum(total_sale) as net_sale,
	count(*) as total_orders
	from retail_sales
	group by  1;


---- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select round(avg(age), 2) as avg_age
from retail_sales
where category = 'Beauty';


--Q5. Transactions where total sale > 1000
select * from retail_sales
where total_sale > 1000;


--Q6. Total number of transactions by gender & category
select category, gender, count(*) as total_trans
from retail_sales
group by category, gender
order by category;


--Q7. Average sale per month → Best month each year
SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE rank = 1;


--Q8. Top 5 customers by total sales
select 
	customer_id, 
	sum(total_sale) as total_sales
from retail_sales
group by customer_id
order by total_sales desc
LIMIT 5;

--Unique customers per category
select category, count(Distinct customer_id) as unique_customers
from retail_sales
group by category;


--Q10. Orders by time of day (Shift Analysis)
WITH hourly_sale AS (
    SELECT *,
        CASE
            WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
            WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) AS total_orders    
FROM hourly_sale
GROUP BY shift;



