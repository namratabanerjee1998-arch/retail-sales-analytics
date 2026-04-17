-- Q1: Total Revenue, Profit, Orders

SELECT
    ROUND(SUM(Sales), 2) AS Total_Revenue,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    COUNT(DISTINCT "Order ID") AS Total_Orders,
    ROUND(AVG(Sales), 2) AS Avg_Order_Value
FROM sales;
   

-- Q2: Top 10 Products by Sales
SELECT "Product Name", ROUND(SUM(Sales),2) AS Total_Sales
FROM sales
GROUP BY "Product Name"
ORDER BY Total_Sales DESC
LIMIT 10;

-- Q3: Sales & Profit by Region
SELECT Region,
    ROUND(SUM(Sales),2) AS Sales,
    ROUND(SUM(Profit),2) AS Profit,
    ROUND(SUM(Profit)*100.0/SUM(Sales),2) AS Profit_Pct
FROM sales
GROUP BY Region
ORDER BY Sales DESC;

-- Q4: Monthly Sales Trend (Year-Month)
SELECT
    strftime('%Y-%m', "Order Date") AS Month,
    ROUND(SUM(Sales),2) AS Monthly_Sales
FROM sales
GROUP BY Month
ORDER BY Month;

-- Q5: Loss-Making Sub-Categories (Negative Profit)
SELECT "Sub-Category",
    ROUND(SUM(Profit),2) AS Total_Profit
FROM sales
GROUP BY "Sub-Category"
HAVING Total_Profit < 0
ORDER BY Total_Profit;

-- Q6: Customer Segment Performance
SELECT Segment,
    COUNT(DISTINCT "Customer ID") AS Customers,
    ROUND(SUM(Sales),2) AS Sales,
    ROUND(AVG(Sales),2) AS Avg_Sales
FROM sales
GROUP BY Segment;

-- Q7: Quarterly Growth (Window Function)
SELECT Year, Quarter,
    ROUND(SUM(Sales),2) AS Quarterly_Sales,
    ROUND(SUM(Sales) - LAG(SUM(Sales),1)
        OVER (ORDER BY Year, Quarter), 2) AS QoQ_Growth
FROM sales
GROUP BY Year, Quarter;

-- Q8: Top 5 Customers by Revenue
SELECT "Customer Name",
    ROUND(SUM(Sales),2) AS Total_Revenue,
    COUNT(DISTINCT "Order ID") AS Orders
FROM sales
GROUP BY "Customer Name"
ORDER BY Total_Revenue DESC
LIMIT 5;

-- Q9: Impact of Discount on Profit
SELECT
    CASE
        WHEN Discount = 0 THEN 'No Discount'
        WHEN Discount <= 0.2 THEN 'Low (≤20%)'
        WHEN Discount <= 0.4 THEN 'Medium (21-40%)'
        ELSE 'High (>40%)'
    END AS Discount_Band,
    ROUND(AVG(Profit),2) AS Avg_Profit
FROM sales
GROUP BY Discount_Band;

-- Q10: Ship Mode Efficiency
SELECT "Ship Mode",
    COUNT(*) AS Orders,
    ROUND(AVG(ShipDays),1) AS Avg_Ship_Days,
    ROUND(SUM(Sales),2) AS Total_Sales
FROM sales
GROUP BY "Ship Mode"
ORDER BY Avg_Ship_Days;