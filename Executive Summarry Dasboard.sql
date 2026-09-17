USE supply_chain;

-- =========================================
-- EXECUTIVE SUMMARY DASHBOARD
-- STEP 1: CHECK FACT ORDERS STRUCTURE
-- =========================================

DESCRIBE fact_orders;
-- =========================================
-- EXECUTIVE SUMMARY
-- KPI 1: TOTAL REVENUE
-- =========================================

SELECT
    ROUND(SUM(Revenue), 2) AS Total_Revenue
FROM fact_orders;

-- =========================================
-- KPI 2: GROSS MARGIN %
-- =========================================

SELECT
    ROUND(
        (SUM(Revenue) - SUM(COGS)) / SUM(Revenue) * 100,
        2
    ) AS Gross_Margin_Pct
FROM fact_orders;

-- =========================================
-- KPI 3: ON-TIME DELIVERY %
-- =========================================

SELECT
    ROUND(
        SUM(
            CASE
                WHEN Actual_Delivery_Date <= Promised_Delivery_Date
                THEN 1
                ELSE 0
            END
        ) / COUNT(*) * 100,
        2
    ) AS OTD_Pct
FROM fact_orders;

-- =========================================
-- KPI 4: FILL RATE %
-- =========================================

SELECT
    ROUND(
        SUM(Shipped_Quantity) / SUM(Order_Quantity) * 100,
        2
    ) AS Fill_Rate_Pct
FROM fact_orders;

-- =========================================
-- KPI 5: PERFECT ORDER RATE %
-- =========================================

SELECT
    ROUND(
        SUM(
            CASE
                WHEN Actual_Delivery_Date <= Promised_Delivery_Date
                     AND Shipped_Quantity >= Order_Quantity
                THEN 1
                ELSE 0
            END
        ) / COUNT(*) * 100,
        2
    ) AS Perfect_Order_Rate_Pct
FROM fact_orders;

-- =========================================
-- EXECUTIVE SUMMARY
-- MONTHLY REVENUE & PROFIT TREND
-- =========================================

SELECT
    DATE_FORMAT(STR_TO_DATE(Order_Date, '%Y-%m-%d'), '%Y-%m') AS Month,
    ROUND(SUM(Revenue), 2) AS Revenue,
    ROUND(SUM(COGS), 2) AS COGS,
    ROUND(SUM(Revenue - COGS), 2) AS Profit
FROM fact_orders
GROUP BY DATE_FORMAT(STR_TO_DATE(Order_Date, '%Y-%m-%d'), '%Y-%m')
ORDER BY Month;

-- =========================================
-- EXECUTIVE SUMMARY
-- REVENUE BY REGION
-- =========================================



SELECT
    w.Warehouse_Region AS Region,
    ROUND(SUM(o.Revenue), 2) AS Revenue
FROM fact_orders o
JOIN dim_warehouse w
    ON o.Warehouse_ID = w.`ï»¿Warehouse_ID`
GROUP BY w.Warehouse_Region
ORDER BY Revenue DESC;




SELECT
    ROUND(SUM(o.Revenue), 2) AS Total_Revenue,
    ROUND(SUM(CASE WHEN w.Warehouse_Region = 'Asia' THEN o.Revenue ELSE 0 END), 2) AS Asia,
    ROUND(SUM(CASE WHEN w.Warehouse_Region = 'Europe' THEN o.Revenue ELSE 0 END), 2) AS Europe,
    ROUND(SUM(CASE WHEN w.Warehouse_Region = 'North America' THEN o.Revenue ELSE 0 END), 2) AS North_America,
    ROUND(SUM(CASE WHEN w.Warehouse_Region = 'South America' THEN o.Revenue ELSE 0 END), 2) AS South_America,
    ROUND(SUM(CASE WHEN w.Warehouse_Region = 'Middle East' THEN o.Revenue ELSE 0 END), 2) AS Middle_East
FROM fact_orders o
JOIN dim_warehouse w
    ON o.Warehouse_ID = w.`ï»¿Warehouse_ID`;
    
    
    -- =========================================
--  EXECUTIVE SUMMARY
-- END OF SECTION
-- =========================================