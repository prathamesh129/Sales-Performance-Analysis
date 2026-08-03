-- SALES ANALYSIS -- 

USE sales_analysis;


-- OVERALL PERFORMANCE -- 

-- 1. Total Sales --
SELECT SUM(sales) AS Total_sales
FROM sales;

-- 2. Total Orders --
SELECT COUNT(*) AS Total_orders
FROM sales;

-- 3. Total Customers --
SELECT COUNT(DISTINCT `Customer id`) AS Total_customers
FROM sales;

-- 4. Average Sales
SELECT (AVG(sales), AS Average_ales
FROM sales;

-- 5. Highest Sale --
SELECT MAX(sales) AS Highest_sales
FROM sales;

-- 6. Lowest Sale --
SELECT MIN(sales) AS Lowest_ales
FROM sales;


-- CATEGORY ANALYSIS --

-- 7. Total Sales by Category
SELECT Category, SUM(sales) AS Total_sales
FROM sales
GROUP BY Category
ORDER BY Total_sales DESC;

-- 8. Total Orders by Category --
SELECT Category, COUNT(*) AS Total_orders
FROM sales
GROUP BY Category
ORDER BY Total_orders DESC;

-- 9. Average Sales by Category --
SELECT Category, AVG(Sales), AS Average_sales
FROM sales
GROUP BY Category
ORDER BY Average_sales DESC;

-- 10. Highest Selling Product --
SELECT `Product name`, SUM(sales) AS Total_sales
FROM sales
GROUP BY `Product name`
ORDER BY Total_sales DESC
LIMIT 1;

-- 11. Top 5 Products by Sales --
SELECT `Product name`, SUM(sales) AS Total_sales
FROM sales
GROUP BY `Product name`
ORDER BY Total_sales DESC
LIMIT 5;


-- REGION & STATE ANALYSIS --

-- 12. Total Sales by Region --
SELECT Region, SUM(sales) AS Total_sales
FROM sales
GROUP BY Region
ORDER BY Total_sales DESC;

-- 13. Total Orders by Region --
SELECT Region, COUNT(*) AS Total_orders
FROM sales
GROUP BY Region
ORDER BY Total_orders DESC;

-- 14. Average Sales by Region --
SELECT Region, AVG(sales), AS Average_sales
FROM sales
GROUP BY Region
ORDER BY Average_sales DESC;

-- 15. Total Sales by State --
SELECT State, SUM(sales) AS Total_sales
FROM sales
GROUP BY State
ORDER BY Total_sales DESC;

-- 16. Top 5 States by Sales --
SELECT State, SUM(sales) AS Total_sales
FROM sales
GROUP BY State
ORDER BY Total_sales DESC
LIMIT 5;

-- 17. Total Orders by State --
SELECT State, COUNT(*) AS Total_orders
FROM sales
GROUP BY State
ORDER BY Total_orders DESC;


-- 4. CUSTOMER ANALYSIS --

-- 18. Top 10 Customers by Total Sales --
SELECT `Customer name`, SUM(sales) AS Total_sales
FROM sales
GROUP BY `Customer name`
ORDER BY Total_sales DESC
LIMIT 10;

-- 19. Total Orders by Customer --
SELECT `Customer name`, COUNT(*) AS Total_orders
FROM sales
GROUP BY `Customer name`
ORDER BY Total_Orders DESC;

-- 20. Customers with Total Sales Greater Than 1000 --
SELECT `Customer name`, SUM(sales) AS Total_sales
FROM sales
GROUP BY `Customer name`
HAVING Total_sales > 1000
ORDER BY Total_sales DESC;

-- 21. Highest Revenue-Generating Customer --
SELECT `Customer name`, SUM(sales) AS Total_sales
FROM sales
GROUP BY `Customer name`
ORDER BY Total_sales DESC
LIMIT 1;

-- 22. Customers Above Average Total Sales --
WITH Customer_sales AS
(
SELECT `Customer name`, SUM(sales) AS Total_sales
FROM sales
GROUP BY `Customer name`
)
SELECT * FROM Customer_sales
WHERE Total_sales >
( 
SELECT AVG(Total_sales) FROM Customer_sales
); 

-- 23. Customer Ranking by Total Sales
WITH Customer_sales AS
(
SELECT `Customer name`, SUM(sales) AS Total_sales,
RANK() OVER(ORDER BY SUM(sales) DESC) AS Customer_rank
FROM sales 
GROUP BY `Customer name`
)
SELECT * FROM Customer_sales;


-- 5. PRODUCT ANALYSIS & ADVANCED SQL --

-- 24. Highest Selling Product in Each Category
WITH Rankedproducts AS
(
SELECT Category, `Product name`, SUM(sales) AS Total_sales,
ROW_NUMBER() OVER(PARTITION BY Category ORDER BY SUM(sales) DESC) AS Row_Num
FROM sales
GROUP BY Category, `Product name`
)
SELECT * FROM Rankedproducts
WHERE Row_Num = 1;

-- 25. Top 3 Customers by Total Sales
SELECT `Customer name`, SUM(sales) AS Total_sales 
FROM sales
GROUP BY `Customer name`
ORDER BY Total_sales DESC
LIMIT 3;

-- 26. Sales Classification
SELECT `Order ID`, Sales,
CASE WHEN Sales >= 1000 THEN 'High sales'
ELSE 'Low sales'
END AS Sales_category
FROM sales;

-- 27. Second Highest Selling Product
WITH Rankedsales AS
(
SELECT `Product name`, SUM(sales) AS Total_sales ,
RANK() OVER(ORDER BY SUM(sales) DESC) AS Rank_num
FROM Sales
GROUP BY `Product name`
)
SELECT * FROM Rankedsales
WHERE Rank_num = 2;

-- 28. Top 3 Products in Each Category
WITH Product_rank AS 
(
SELECT Category, `Product name`, SUM(Sales) AS Total_sales,
ROW_NUMBER() OVER(PARTITION BY Category ORDER BY SUM(sales) DESC) AS Row_num
FROM sales 
GROUP BY Category, `Product name`
)
SELECT * FROM Product_rank
WHERE Row_num <= 3;

-- 29. Customer Ranking Within Each Region
WITH Customer_rank AS
(
SELECT Region, `Customer name`, SUM(sales) AS Total_sales,
RANK() OVER(PARTITION BY Region ORDER BY SUM(sales) DESC) AS Rank_num
FROM sales
GROUP BY Region, `Customer name`
)
SELECT * FROM Customer_rank;

-- 30. Highest Selling Customer in Each Region
WITH Customer_sales AS
(
SELECT Region, `Customer name`, SUM(sales) AS Total_sales,
ROW_NUMBER() OVER(PARTITION BY Region ORDER BY SUM(sales) DESC) AS Row_Num
FROM sales
GROUP BY Region, `Customer name`
)
SELECT * FROM Customer_sales
WHERE Row_Num = 1;

-- 31. Highest Selling Product in Each Region
WITH Product_sales AS
(
SELECT Region, `Product name`, SUM(sales) AS Total_sales,
ROW_NUMBER() OVER(PARTITION BY Region ORDER BY SUM(sales) DESC) AS Row_Num
FROM sales
GROUP BY Region, `Product name`
)
SELECT * FROM Product_sales
WHERE Row_Num = 1;

-- 32. Top 3 Customers in Each Region
WITH Top_customers AS
(
SELECT Region, `Customer name`, SUM(sales) AS Total_sales,
ROW_NUMBER() OVER(PARTITION BY Region ORDER BY SUM(sales) DESC) AS Row_num
FROM sales
GROUP BY Region, `Customer name`
)
SELECT * FROM Top_customers
WHERE Row_num <= 3;

-- 33. Top Selling Category in Each Region
WITH Top_category AS
(
SELECT Region, Category, SUM(sales) AS Total_sales,
ROW_NUMBER() OVER(PARTITION BY Region ORDER BY SUM(sales) DESC) AS Row_num
FROM sales
GROUP BY Region, Category
)
SELECT * FROM Top_category
WHERE Row_num = 1;

-- 34. Highest Selling State in Each Region
WITH Top_state AS
(
SELECT Region, State, SUM(sales) AS Total_sales,
ROW_NUMBER() OVER(PARTITION BY Region ORDER BY SUM(sales) DESC) AS Row_num
FROM sales
GROUP BY Region, State
)
SELECT * FROM Top_state
WHERE Row_num = 1;

-- 35. Customer with Highest Number of Orders
SELECT `Customer name`, COUNT(*) AS Total_orders
FROM sales
GROUP BY `Customer name`
ORDER BY Total_orders DESC
LIMIT 1;

-- 36. Customers with More Than 5 Orders
SELECT `Customer name`, COUNT(*) AS Total_orders
FROM sales
GROUP BY `Customer name`
HAVING Total_orders > 5
ORDER BY Total_orders DESC;


