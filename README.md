# SQL Project Retail Sales

## Project Overview

**Project Title**: Retail Sales Analysis

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `SQL_Project`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold ,COGS and total sale amount.

```sql
CREATE DATABASE sql_project;

USE sql_project

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);
```

#### 2. Data Cleaning & exploration

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT COUNT(*) FROM retail_sales;

SELECT COUNT(DISTINCT customer_id) FROM retail_sales;

SELECT DISTINCT category FROM retail_sales;

select * from retail_sales
where transactions_id is null or sale_date is null or sale_time is null
      or customer_id is null or gender is null or age is null or category is null
      or quantity is null or price_per_unit is null or cogs is null
      or total_sale is null


Delete from retail_sales
where transactions_id is null or sale_date is null or sale_time is null
      or customer_id is null or gender is null or age is null or category is null
      or quantity is null or price_per_unit is null or cogs is null
      or total_sale is null


 * how many sales we have?

    select count(*) as total_sales from retail_sales

 * how many unique customers we have?
  
    select COUNT(distinct customer_id) as total_sales from retail_sales

 * how many category we have?

    select distinct category as total_sales from retail_sales


```

###### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:

```sql
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:

```sql
SELECT
  *
FROM retail_sales
WHERE
    category = 'Clothing'
    AND
    TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
    AND
    quantity >= 4
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:

```sql
SELECT
    category,
    SUM(total_sale) as net_sale,
    COUNT(*) as total_orders
FROM retail_sales
GROUP BY category
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:

```sql
SELECT
     AVG(age) as avg_age
FROM retail_sales
WHERE category = 'Beauty'
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:

```sql
SELECT * FROM retail_sales
WHERE total_sale > 1000
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:

```sql
select category,
       gender,
       count(*) as total_trans
from retail_sales
group by category,
         gender
order by
gender desc
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:

```sql
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
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:

```sql
select top 5 customer_id,
       sum(total_sale) as total_sale
from retail_sales
group by customer_id
order by total_sale desc
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:

```sql
select category,
       count(distinct customer_id) as cs_unique_id
from retail_sales
group by category
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:

```sql
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
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## Author - Arun

