-- =========================================
-- REVENUE & CUSTOMERS
-- =========================================

-- =========================================
-- REVENUE & CUSTOMERS
-- KPI 1: REVENUE BY REGION
-- =========================================

SELECT
    w.Warehouse_Region AS Region,
    ROUND(SUM(o.Revenue), 2) AS Revenue
FROM fact_orders o
JOIN dim_warehouse w
    ON o.Warehouse_ID = w.`ï»¿Warehouse_ID`
GROUP BY w.Warehouse_Region
ORDER BY Revenue DESC;


-- =========================================
-- REVENUE & CUSTOMERS
-- KPI 2: TOP 10 PRODUCTS
-- CHECK PRODUCT DATA
-- =========================================

DESCRIBE dim_product;


-- =========================================
-- REVENUE & CUSTOMERS
-- KPI 2: TOP 10 PRODUCTS
-- =========================================

SELECT
    p.Product_Name,
    ROUND(SUM(o.Revenue), 2) AS Revenue
FROM fact_orders o
JOIN dim_product p
    ON o.Product_ID = p.`ï»¿Product_ID`
GROUP BY
    p.Product_Name
ORDER BY Revenue DESC
LIMIT 10;


-- =========================================
-- REVENUE & CUSTOMERS
-- KPI 3: REVENUE PER CUSTOMER
-- CHECK CUSTOMER DATA
-- =========================================

DESCRIBE dim_customer;


-- =========================================
-- REVENUE & CUSTOMERS
-- KPI 3: REVENUE PER CUSTOMER
-- =========================================

SELECT
    c.`ï»¿Customer_ID` AS Customer_ID,
    c.Customer_Region AS Region,
    c.Customer_Segment AS Segment,
    ROUND(SUM(o.Revenue), 2) AS Revenue
FROM fact_orders o
JOIN dim_customer c
    ON o.Customer_ID = c.`ï»¿Customer_ID`
GROUP BY
    c.`ï»¿Customer_ID`,
    c.Customer_Region,
    c.Customer_Segment
ORDER BY Revenue DESC;


-- =========================================
-- REVENUE & CUSTOMERS
-- KPI 4: REVENUE BY CUSTOMER SEGMENT
-- =========================================

SELECT
    c.Customer_Segment AS Segment,
    ROUND(SUM(o.Revenue), 2) AS Revenue
FROM fact_orders o
JOIN dim_customer c
    ON o.Customer_ID = c.`ï»¿Customer_ID`
GROUP BY c.Customer_Segment
ORDER BY Revenue DESC;



-- =========================================
-- REVENUE AND CUSTOMERS DASHBOARD
-- END OF SECTION
-- =========================================
    