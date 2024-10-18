# The problem no1
# Query to find out what is the M1 retention for any given customer cohort. A cohort consists of customers who made their first order within the same month (M0). M1 retention is the share of customers who have made at least one purchase one month after their first purchase month.

WITH first_order AS (
    SELECT 
        ru.user_id,                                                                                  # ru = resq_user
        MIN(DATE_TRUNC('month', ro.order_date)) AS first_order_month                                 # ro = resq_order
    FROM 
        resq_user ru
    JOIN 
        resq_order ro ON ru.user_id = ro.user_id
    GROUP BY 
        ru.user_id
),
m1_orders AS (
    SELECT 
        fo.user_id,
        DATE_TRUNC('month', ro.order_date) AS m1_order_month
    FROM 
        first_order fo
    JOIN 
        resq_order ro ON fo.user_id = ro.user_id
    WHERE 
        DATE_TRUNC('month', ro.order_date) = fo.first_order_month + INTERVAL '1 month'
)
SELECT 
    DATE_TRUNC('month', fo.first_order_month) AS cohort_month,
    COUNT(DISTINCT fo.user_id) AS cohort_size,
    COUNT(DISTINCT mo.user_id) AS retained_in_m1,
    (COUNT(DISTINCT mo.user_id)::decimal / COUNT(DISTINCT fo.user_id)) * 100 AS m1_retention_rate
FROM 
    first_order fo
LEFT JOIN 
    m1_orders mo ON fo.user_id = mo.user_id
GROUP BY 
    cohort_month
ORDER BY 
    cohort_month;
