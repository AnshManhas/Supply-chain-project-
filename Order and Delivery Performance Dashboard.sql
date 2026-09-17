-- =========================================
-- DASHBOARD 2
-- ORDER & DELIVERY PERFORMANCE
-- =========================================

-- =========================================
-- CHECK DELIVERY STATUS
-- =========================================

SELECT
    Delivery_Status,
    COUNT(*) AS Order_Count
FROM fact_orders
GROUP BY Delivery_Status
ORDER BY Order_Count DESC;

-- =========================================
-- ORDER & DELIVERY PERFORMANCE
-- KPI 1: TOTAL ORDERS
-- =========================================

SELECT
    COUNT(*) AS Total_Orders
FROM fact_orders;

-- ============================================
-- ORDER & DELIVERY PERFORMANCE
-- KPI 2: AVERAGE ORDER VALUE
-- ============================================

SELECT
    ROUND(SUM(Revenue) / COUNT(*), 2) AS Average_Order_Value
FROM fact_orders;

-- =============================================
-- ORDER & DELIVERY PERFORMANCE
-- KPI 3: AVERAGE DELIVERY DELAY
-- =============================================

SELECT
    ROUND(AVG(Delay_Days), 2) AS Average_Delivery_Delay_Days
FROM fact_orders;


-- =================================================
-- ORDER & DELIVERY PERFORMANCE
-- KPI 4: ON-TIME DELIVERY %
-- =================================================

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


-- =============================================
-- ORDER & DELIVERY PERFORMANCE
-- KPI 5: FILL RATE %
-- =============================================

SELECT
    ROUND(
        SUM(Shipped_Quantity) / SUM(Order_Quantity) * 100,
        2
    ) AS Fill_Rate_Pct
FROM fact_orders;


-- ============================================
-- ORDER & DELIVERY PERFORMANCE
-- DELIVERY STATUS BREAKDOWN
-- =============================================

SELECT
    Delivery_Status,
    COUNT(*) AS Order_Count
FROM fact_orders
GROUP BY Delivery_Status
ORDER BY Order_Count DESC;


-- ==============================================
-- ORDER & DELIVERY PERFORMANCE
-- MONTHLY ORDER & DELIVERY TREND
-- ==============================================

SELECT
    DATE_FORMAT(
        STR_TO_DATE(Order_Date, '%Y-%m-%d'),
        '%Y-%m'
    ) AS Month,

    COUNT(*) AS Total_Orders,

    SUM(
        CASE
            WHEN Actual_Delivery_Date <= Promised_Delivery_Date
            THEN 1
            ELSE 0
        END
    ) AS On_Time_Orders,

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

FROM fact_orders

GROUP BY DATE_FORMAT(
    STR_TO_DATE(Order_Date, '%Y-%m-%d'),
    '%Y-%m'
)

ORDER BY Month;



-- =============================================
-- ORDER & DELIVERY PERFORMANCE
-- DELIVERY DELAY BY CARRIER
-- =============================================

SELECT
    Carrier,
    COUNT(*) AS Total_Orders,
    ROUND(AVG(Delay_Days), 2) AS Average_Delay_Days
FROM fact_orders
GROUP BY Carrier
ORDER BY Average_Delay_Days DESC;


-- =========================================
-- ORDER & DELIVERY PERFORMANCE
-- ORDER VS SHIPPED QUANTITY
-- =========================================

SELECT
    SUM(Order_Quantity) AS Total_Order_Quantity,
    SUM(Shipped_Quantity) AS Total_Shipped_Quantity,
    ROUND(
        SUM(Shipped_Quantity) / SUM(Order_Quantity) * 100,
        2
    ) AS Fill_Rate_Pct
FROM fact_orders;



-- =========================================
-- ORDER & DELIVERY PERFORMANCE
-- ORDER CYCLE TIME
-- =========================================

SELECT
    ROUND(
        AVG(
            DATEDIFF(
                STR_TO_DATE(Actual_Delivery_Date, '%Y-%m-%d'),
                STR_TO_DATE(Order_Date, '%Y-%m-%d')
            )
        ),
        2
    ) AS Avg_Order_Cycle_Time_Days
FROM fact_orders;


-- =========================================
-- ORDER & DELIVERY PERFORMANCE
-- DELIVERY STATUS BY MONTH
-- =========================================

SELECT
    DATE_FORMAT(
        STR_TO_DATE(Order_Date, '%Y-%m-%d'),
        '%Y-%m'
    ) AS Month,
    Delivery_Status,
    COUNT(*) AS Order_Count
FROM fact_orders
GROUP BY
    DATE_FORMAT(
        STR_TO_DATE(Order_Date, '%Y-%m-%d'),
        '%Y-%m'
    ),
    Delivery_Status
ORDER BY
    Month,
    Delivery_Status;
    
    
    -- =========================================
-- ORDER & DELIVERY PERFORMANCE
-- DELIVERY DELAY DISTRIBUTION
-- =========================================

SELECT
    Delay_Days
FROM fact_orders
WHERE Delay_Days IS NOT NULL
ORDER BY Delay_Days;

-- =========================================
-- ORDER & DELIVERY PERFORMANCE
-- CHECK DELAY DAYS
-- =========================================

SELECT
    Delay_Days,
    COUNT(*) AS Order_Count
FROM fact_orders
GROUP BY Delay_Days
ORDER BY Delay_Days;


-- =========================================
-- ORDER & DELIVERY PERFORMANCE
-- DELIVERY DELAY DISTRIBUTION
-- =========================================

SELECT
    DATEDIFF(
        STR_TO_DATE(Actual_Delivery_Date, '%Y-%m-%d'),
        STR_TO_DATE(Promised_Delivery_Date, '%Y-%m-%d')
    ) AS Delivery_Delay_Days
FROM fact_orders
WHERE Actual_Delivery_Date IS NOT NULL
  AND Promised_Delivery_Date IS NOT NULL
ORDER BY Delivery_Delay_Days;


-- =========================================
-- ORDER & DELIVERY PERFORMANCE
-- LATE DELIVERY CHECK
-- =========================================

SELECT
    COUNT(*) AS Delayed_Orders,
    ROUND(
        AVG(
            DATEDIFF(
                STR_TO_DATE(Actual_Delivery_Date, '%Y-%m-%d'),
                STR_TO_DATE(Promised_Delivery_Date, '%Y-%m-%d')
            )
        ),
        2
    ) AS Average_Delay_Days
FROM fact_orders
WHERE DATEDIFF(
    STR_TO_DATE(Actual_Delivery_Date, '%Y-%m-%d'),
    STR_TO_DATE(Promised_Delivery_Date, '%Y-%m-%d')
) > 0;


-- =========================================
-- ORDER & DELIVERY PERFORMANCE
-- DELAY HISTOGRAM DATA
-- =========================================

SELECT
    DATEDIFF(
        STR_TO_DATE(Actual_Delivery_Date, '%Y-%m-%d'),
        STR_TO_DATE(Promised_Delivery_Date, '%Y-%m-%d')
    ) AS Delay_Days
FROM fact_orders
WHERE Actual_Delivery_Date IS NOT NULL
  AND Promised_Delivery_Date IS NOT NULL
  AND DATEDIFF(
        STR_TO_DATE(Actual_Delivery_Date, '%Y-%m-%d'),
        STR_TO_DATE(Promised_Delivery_Date, '%Y-%m-%d')
      ) > 0
ORDER BY Delay_Days;

-- =========================================
-- ORDER & DELIVERY PERFORMANCE
-- END OF SECTION
-- =========================================