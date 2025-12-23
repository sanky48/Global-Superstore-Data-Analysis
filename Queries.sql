use superstore;
SELECT ROUND(SUM(Sales),2) AS Total_Revenue,SUM(Quantity) AS Total_Quantity,
ROUND(SUM(Profit),2) AS Total_Profit FROM store_data;

SELECT Segment,ROUND(SUM(Sales),2) AS Total_Sales FROM store_data
GROUP BY Segment ORDER BY Total_Sales DESC;

SELECT Product_Name,ROUND(SUM(Profit),2) AS Total_Profit FROM store_data
GROUP BY Product_Name ORDER BY Total_Profit DESC LIMIT 3;

SELECT COUNT(DISTINCT Order_ID) AS Orders_After_Jan_2016 FROM store_data
WHERE Order_Date > '2016-01-31';

SELECT COUNT(DISTINCT State) AS Mexico_States FROM store_data
WHERE Country = 'Mexico';

SELECT Sub_Category,Product_Name,ROUND(SUM(Profit), 2) AS Total_Profit FROM store_data
GROUP BY Sub_Category, Product_Name ORDER BY Total_Profit DESC LIMIT 10;

SELECT Sub_Category,Product_Name,Total_Profit,loss_rank
FROM (
    SELECT Sub_Category,Product_Name,ROUND(SUM(Profit), 2) AS Total_Profit,
        RANK() OVER (
            PARTITION BY Sub_Category
            ORDER BY SUM(Profit) ASC
        ) AS loss_rank
    FROM store_data
    GROUP BY Sub_Category, Product_Name
) ranked
WHERE loss_rank = 1
ORDER BY Total_Profit ASC;


SELECT Segment,ROUND(SUM(Sales), 2) AS Total_Revenue FROM store_data
GROUP BY Segment ORDER BY Total_Revenue DESC;

SELECT YEAR(str_to_date(Order_Date,'%d-%m-%Y')) AS Year,ROUND(SUM(Sales),2) AS Total_Sales,
ROUND(SUM(Profit),2) AS Total_Profit FROM store_data GROUP BY YEAR ORDER BY Year;

SELECT Country,ROUND(SUM(Sales), 2) AS Total_Sales FROM store_data
GROUP BY Country ORDER BY Total_Sales DESC;

SELECT City, Total_Sales,sales_rank
FROM (
    SELECT
        City,
        ROUND(SUM(Sales), 2) AS Total_Sales,
        RANK() OVER (ORDER BY SUM(Sales) DESC) AS sales_rank
    FROM store_data
    GROUP BY City
) ranked
WHERE sales_rank <= 10;

SELECT Region,ROUND(AVG(DATEDIFF(STR_TO_DATE(Ship_Date, '%d-%m-%Y'),STR_TO_DATE(Order_Date, '%d-%m-%Y'))),2) 
AS Avg_Delivery_Days FROM store_data GROUP BY Region;

SELECT Order_Priority,ROUND(SUM(Profit), 2) AS Total_Profit FROM store_data
GROUP BY Order_Priority ORDER BY Total_Profit DESC;
