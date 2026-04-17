SELECT
    ROUND(SUM(Sales), 2) AS Total_Revenue,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    COUNT(DISTINCT "Order ID") AS Total_Orders,
    ROUND(AVG(Sales), 2) AS Avg_Order_Value
FROM sales;

SELECT "Product Name", ROUND(SUM(Sales),2) AS Total_Sales
FROM sales
GROUP BY "Product Name"
ORDER BY Total_Sales DESC
LIMIT 10;