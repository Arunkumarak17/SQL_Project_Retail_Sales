--SQL_PROJECT-Retail_Sales--

create database SQL_Project;

use SQL_Project;

--create table

create table retail_sales(
transactions_id int primary key,	
sale_date date,
sale_time time,	
customer_id	int,
gender	varchar(30),
age	int,
category varchar(30),	
quantiy	int,
price_per_unit float,	
cogs float,	
total_sale float
);


select * from retail_sales



SELECT name 
FROM sys.tables;

select count(*) FROM retail_sales


-- Data cleaning

select * from retail_sales

select * from retail_sales
where transactions_id is null

select * from retail_sales
where 
     transactions_id is null
     or 
     sale_date is null
     or
     sale_time is null
     or
     customer_id is null
     or
     gender is null
     or
     age is null
     or 
     category is null
     or
     quantity is null
     or
     price_per_unit is null
     or
     cogs is null
     or 
     total_sale is null


delete from retail_sales
where 
     transactions_id is null
     or 
     sale_date is null
     or
     sale_time is null
     or
     customer_id is null
     or
     gender is null
     or
     age is null
     or 
     category is null
     or
     quantity is null
     or
     price_per_unit is null
     or
     cogs is null
     or 
     total_sale is null


 -- data exploration

  -- how many sales we have?

     select count(*) as total_sales from retail_sales

  -- how many unique customers we have?
   
     select COUNT(distinct customer_id) as total_sales from retail_sales

  -- how many category we have?
 
     select distinct category as total_sales from retail_sales

-- Data Analysis & business key problems & solutions


-- My Analysis & Findings

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

     select *  from retail_sales
     where sale_date ='2022-11-05'

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 04 in the month of Nov-2022

     select *
      from retail_sales
      where category = 'clothing'
      and 
      format(sale_date,'yyyy-MM') = '2022-11'
      and 
      quantity >= 4;

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
      
      select category,
             SUM(total_sale) as net_sale,
             count(*) as total_orders
      from retail_sales
      group by category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

       select avg(age) as avg_age
       from retail_sales
       where category='beauty'

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

       select * from retail_sales
       where total_sale >1000

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

       select category,
              gender,
              count(*) as total_trans
       from retail_sales
       group by category,
                gender
       order by
       gender desc

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

       select
             year,
             month,avg_sale
       from( 
            select 
                  year(sale_date) as year,
                  month(sale_date) as month,
                  avg(total_sale) as avg_sale,
                  rank()over(partition by year(sale_date) order by avg(total_sale)desc
                  ) as rank
            from retail_sales
            group by year(sale_date),
                     month(sale_date)
            ) as t1
       where rank=1


 -- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

        select top 5 customer_id,
               sum(total_sale) as total_sale
        from retail_sales
        group by customer_id
        order by total_sale desc
 
 -- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

        select category,
               count(distinct customer_id) as cs_unique_id
        from retail_sales
        group by category

 -- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

         WITH hourly_sale AS
         (
         SELECT *,
              CASE
                  WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
                  WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
                  ELSE 'Evening'
          END AS shift
          FROM retail_sales
          )
          SELECT 
                shift,
                COUNT(*) AS total_orders
                FROM hourly_sale
                GROUP BY shift;

