-- =========================================
-- Dashboard 3
-- INVENTORY HEALTH
-- =========================================

-- =========================================
-- INVENTORY HEALTH
-- CHECK INVENTORY DATA
-- =========================================

DESCRIBE fact_inventory;


-- =========================================
-- INVENTORY HEALTH
-- KPI 1: STOCKOUT RATE %
-- =========================================

SELECT
    ROUND(
        SUM(CASE
            WHEN Stockout_Flag = 1 THEN 1
            ELSE 0
        END) / COUNT(*) * 100,
        2
    ) AS Stockout_Rate_Pct
FROM fact_inventory;



-- =========================================
-- INVENTORY HEALTH
-- CHECK STOCKOUT FLAG VALUES
-- =========================================

SELECT
    Stockout_Flag,
    COUNT(*) AS Record_Count
FROM fact_inventory
GROUP BY Stockout_Flag
ORDER BY Stockout_Flag;


-- =========================================
-- INVENTORY HEALTH
-- KPI 1: STOCKOUT RATE %
-- BASED ON STOCK ON HAND
-- =========================================

SELECT
    ROUND(
        SUM(
            CASE
                WHEN Stock_On_Hand = 0 THEN 1
                ELSE 0
            END
        ) / COUNT(*) * 100,
        2
    ) AS Stockout_Rate_Pct
FROM fact_inventory;

-- =========================================
-- INVENTORY HEALTH
-- CHECK INVENTORY STOCK LEVELS
-- =========================================

SELECT
    MIN(Stock_On_Hand) AS Minimum_Stock,
    MAX(Stock_On_Hand) AS Maximum_Stock,
    AVG(Stock_On_Hand) AS Average_Stock,
    COUNT(*) AS Total_Records
FROM fact_inventory;


-- =========================================
-- INVENTORY HEALTH
-- CHECK REORDER LEVEL
-- =========================================

SELECT
    MIN(Reorder_Level) AS Minimum_Reorder_Level,
    MAX(Reorder_Level) AS Maximum_Reorder_Level,
    AVG(Reorder_Level) AS Average_Reorder_Level
FROM fact_inventory;



-- =========================================
-- INVENTORY HEALTH
-- KPI 2: DAYS OF SUPPLY
-- =========================================

SELECT
    ROUND(AVG(Days_Of_Supply), 2) AS Average_Days_Of_Supply
FROM fact_inventory;

-- =========================================
-- INVENTORY HEALTH
-- KPI 3: INVENTORY TURNOVER
-- =========================================

SELECT
    ROUND(
        SUM(Units_Shipped) / SUM(Stock_On_Hand),
        2
    ) AS Inventory_Turnover
FROM fact_inventory;


-- =========================================
-- INVENTORY HEALTH
-- KPI 4: WAREHOUSE UTILIZATION %
-- =========================================

SELECT
    ROUND(
        SUM(i.Stock_On_Hand) / SUM(w.Capacity_Units) * 100,
        2
    ) AS Warehouse_Utilization_Pct
FROM fact_inventory i
JOIN dim_warehouse w
    ON i.Warehouse_ID = w.`ï»¿Warehouse_ID`;
    
    
    
    -- =========================================
-- INVENTORY HEALTH
-- PRODUCT × WAREHOUSE HEATMAP
-- =========================================

SELECT
    i.`ï»¿Product_ID` AS Product_ID,
    i.Warehouse_ID,
    ROUND(AVG(i.Stock_On_Hand), 2) AS Average_Stock_On_Hand
FROM fact_inventory i
GROUP BY
    i.`ï»¿Product_ID`,
    i.Warehouse_ID
ORDER BY
    i.`ï»¿Product_ID`,
    i.Warehouse_ID;
    
    
    -- =========================================
-- INVENTORY HEALTH
-- MONTHLY STOCKOUT TREND
-- =========================================

SELECT
    DATE_FORMAT(
        STR_TO_DATE(Snapshot_Date, '%Y-%m-%d'),
        '%Y-%m'
    ) AS Month,

    ROUND(
        SUM(
            CASE
                WHEN Stockout_Flag = 1 THEN 1
                ELSE 0
            END
        ) / COUNT(*) * 100,
        2
    ) AS Stockout_Rate_Pct

FROM fact_inventory

GROUP BY DATE_FORMAT(
    STR_TO_DATE(Snapshot_Date, '%Y-%m-%d'),
    '%Y-%m'
)

ORDER BY Month;



-- =========================================
-- INVENTORY HEALTH DASHBOARD
-- END OF SECTION
-- =========================================
    