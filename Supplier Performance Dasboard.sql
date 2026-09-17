-- =========================================
-- DASHBOARD 3
-- SUPPLIER PERFORMANCE
-- =========================================

-- =========================================
-- SUPPLIER PERFORMANCE
-- CHECK SUPPLIER DATA
-- =========================================

DESCRIBE dim_supplier;

-- =========================================
-- SUPPLIER PERFORMANCE
-- KPI 1: SUPPLIER RELIABILITY
-- =========================================

SELECT
    ROUND(AVG(Reliability_Score), 2) AS Supplier_Reliability
FROM dim_supplier;


-- =========================================
-- SUPPLIER PERFORMANCE
-- KPI 2: AVERAGE DELAY BY SUPPLIER TIER
-- =========================================

SELECT
    s.Supplier_Tier AS Supplier_Tier,
    ROUND(
        AVG(
            DATEDIFF(
                STR_TO_DATE(o.Actual_Delivery_Date, '%Y-%m-%d'),
                STR_TO_DATE(o.Promised_Delivery_Date, '%Y-%m-%d')
            )
        ),
        2
    ) AS Average_Delay_Days
FROM fact_orders o
JOIN dim_supplier s
    ON o.Supplier_ID = s.`ï»¿Supplier_ID`
GROUP BY s.Supplier_Tier
ORDER BY Average_Delay_Days DESC;


-- =========================================
-- SUPPLIER PERFORMANCE
-- AVG DELAY BY SUPPLIER TIER
-- DELAYED ORDERS ONLY
-- =========================================

SELECT
    s.Supplier_Tier AS Supplier_Tier,
    ROUND(
        AVG(
            DATEDIFF(
                STR_TO_DATE(o.Actual_Delivery_Date, '%Y-%m-%d'),
                STR_TO_DATE(o.Promised_Delivery_Date, '%Y-%m-%d')
            )
        ),
        2
    ) AS Average_Delay_Days
FROM fact_orders o
JOIN dim_supplier s
    ON o.Supplier_ID = s.`ï»¿Supplier_ID`
WHERE DATEDIFF(
    STR_TO_DATE(o.Actual_Delivery_Date, '%Y-%m-%d'),
    STR_TO_DATE(o.Promised_Delivery_Date, '%Y-%m-%d')
) > 0
GROUP BY s.Supplier_Tier
ORDER BY Average_Delay_Days DESC;



-- =========================================
-- SUPPLIER PERFORMANCE
-- TOP 5 SUPPLIERS
-- =========================================

SELECT
    s.Supplier_Name,
    s.Supplier_Tier,
    ROUND(s.Reliability_Score, 2) AS Reliability_Score,

    ROUND(
        AVG(
            CASE
                WHEN DATEDIFF(
                    STR_TO_DATE(o.Actual_Delivery_Date, '%Y-%m-%d'),
                    STR_TO_DATE(o.Promised_Delivery_Date, '%Y-%m-%d')
                ) > 0
                THEN DATEDIFF(
                    STR_TO_DATE(o.Actual_Delivery_Date, '%Y-%m-%d'),
                    STR_TO_DATE(o.Promised_Delivery_Date, '%Y-%m-%d')
                )
            END
        ),
        2
    ) AS Average_Delay_Days

FROM dim_supplier s

LEFT JOIN fact_orders o
    ON o.Supplier_ID = s.`ï»¿Supplier_ID`

GROUP BY
    s.`ï»¿Supplier_ID`,
    s.Supplier_Name,
    s.Supplier_Tier,
    s.Reliability_Score

ORDER BY s.Reliability_Score DESC

LIMIT 5;


-- =========================================
-- SUPPLIER PERFORMANCE
-- BOTTOM 5 SUPPLIERS
-- =========================================

SELECT
    s.Supplier_Name,
    s.Supplier_Tier,
    ROUND(s.Reliability_Score, 2) AS Reliability_Score,

    ROUND(
        AVG(
            CASE
                WHEN DATEDIFF(
                    STR_TO_DATE(o.Actual_Delivery_Date, '%Y-%m-%d'),
                    STR_TO_DATE(o.Promised_Delivery_Date, '%Y-%m-%d')
                ) > 0
                THEN DATEDIFF(
                    STR_TO_DATE(o.Actual_Delivery_Date, '%Y-%m-%d'),
                    STR_TO_DATE(o.Promised_Delivery_Date, '%Y-%m-%d')
                )
            END
        ),
        2
    ) AS Average_Delay_Days

FROM dim_supplier s

LEFT JOIN fact_orders o
    ON o.Supplier_ID = s.`ï»¿Supplier_ID`

GROUP BY
    s.`ï»¿Supplier_ID`,
    s.Supplier_Name,
    s.Supplier_Tier,
    s.Reliability_Score

ORDER BY s.Reliability_Score ASC

LIMIT 5;


-- =========================================
-- SUPPLIER PERFORMANCE
-- RELIABILITY VS AVERAGE DELAY
-- =========================================

SELECT
    s.Supplier_Name,
    s.Supplier_Tier,
    ROUND(s.Reliability_Score, 2) AS Reliability_Score,

    ROUND(
        AVG(
            CASE
                WHEN DATEDIFF(
                    STR_TO_DATE(o.Actual_Delivery_Date, '%Y-%m-%d'),
                    STR_TO_DATE(o.Promised_Delivery_Date, '%Y-%m-%d')
                ) > 0
                THEN DATEDIFF(
                    STR_TO_DATE(o.Actual_Delivery_Date, '%Y-%m-%d'),
                    STR_TO_DATE(o.Promised_Delivery_Date, '%Y-%m-%d')
                )
            END
        ),
        2
    ) AS Average_Delay_Days

FROM dim_supplier s

LEFT JOIN fact_orders o
    ON o.Supplier_ID = s.`ï»¿Supplier_ID`

GROUP BY
    s.`ï»¿Supplier_ID`,
    s.Supplier_Name,
    s.Supplier_Tier,
    s.Reliability_Score

ORDER BY Reliability_Score DESC;


-- =========================================
-- SUPPLIER PERFORMANCE
-- SUPPLIER TIER HEATMAP
-- =========================================

SELECT
    Supplier_Tier,
    COUNT(*) AS Supplier_Count,
    ROUND(AVG(Reliability_Score), 2) AS Average_Reliability,
    ROUND(AVG(
        CASE
            WHEN DATEDIFF(
                STR_TO_DATE(o.Actual_Delivery_Date, '%Y-%m-%d'),
                STR_TO_DATE(o.Promised_Delivery_Date, '%Y-%m-%d')
            ) > 0
            THEN DATEDIFF(
                STR_TO_DATE(o.Actual_Delivery_Date, '%Y-%m-%d'),
                STR_TO_DATE(o.Promised_Delivery_Date, '%Y-%m-%d')
            )
        END
    ), 2) AS Average_Delay_Days

FROM dim_supplier s

LEFT JOIN fact_orders o
    ON o.Supplier_ID = s.`ï»¿Supplier_ID`

GROUP BY Supplier_Tier

ORDER BY Supplier_Tier;

