-- Analytical Area



--Sales Performance


--1.What is the total revenue?
SELECT SUM(Revenue) FROM sales_cleaned;

--2.How many orders and transactions were completed?
SELECT COUNT(order_id) FROM orders
WHERE status = 'Completed';

--3.What is the average order value?
SELECT SUM(Revenue) / COUNT(DISTINCT(order_id)) AS Average_order_value FROM sales_cleaned;



--Product Demand

--1.Which products sell the most?
SELECT p.product_id, p.product_name , SUM(sc.quantity) as total_quantity FROM products p
JOIN sales_cleaned sc ON p.product_id = sc.product_id
GROUP BY p.product_id , p.product_name
ORDER BY total_quantity  ASC
LIMIT 1;

--2.Which products generate the most revenue?
SELECT p.product_id, p.product_name , SUM(sc.Revenue) as total_Revenue FROM products p
JOIN sales_cleaned sc ON p.product_id = sc.product_id
GROUP BY p.product_id , p.product_name
ORDER BY total_Revenue  ASC
LIMIT 1;

--3.Which categories are the strongest/weakest?
--weakest
SELECT
  p.product_id,
  p.product_name ,
  SUM(sc.quantity) AS total_quentity ,
  SUM(sc.Revenue) AS total_Revenue ,
  ROUND((SUM(sc.Revenue) / SUM(sc.quantity)) , 2 ) AS avg_unit_price
FROM products p
JOIN sales_cleaned sc ON p.product_id = sc.product_id
GROUP BY p.product_id , p.product_name
ORDER BY avg_unit_price  ASC
LIMIT 1;
--strongest
SELECT
  p.product_id,
  p.product_name ,
  SUM(sc.quantity) AS total_quentity ,
  SUM(sc.Revenue) AS total_Revenue ,
  ROUND((SUM(sc.Revenue) / SUM(sc.quantity)) , 2 ) AS avg_unit_price
FROM products p
JOIN sales_cleaned sc ON p.product_id = sc.product_id
GROUP BY p.product_id , p.product_name
ORDER BY avg_unit_price  DESC
LIMIT 1;


--Customer Behavior

--1.How many customers are purchasing?
SELECT
      COUNT(DISTINCT customer_id) as total_no_of_customer
FROM sales_cleaned;

--2.What is the average customer spend?
SELECT
      ROUND(SUM(REVENUE) / COUNT(DISTINCT customer_id),2) as avg_customer_spend
FROM sales_cleaned;

--3.Who are the highest-value customers?
SELECT
    customer_id,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(revenue) AS total_spent,
    ROUND(SUM(revenue) * 1.0 / COUNT(DISTINCT order_id), 2) AS avg_order_value
FROM sales_cleaned
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 10;



--Regional Performance

--1.Which region has the most user?
SELECT country FROM customers
GROUP BY country
ORDER BY COUNT(customer_id) DESC
LIMIT 1 ;