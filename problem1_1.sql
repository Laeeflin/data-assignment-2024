# The problem no1
# Query to find the top 10 partners by sales

SELECT 
    rp.provider_name AS partner_name,                        # rp = resq_provider
    SUM(ro.order_amount) AS total_sales                      # ro = resq_order
FROM 
    resq_order ro
JOIN 
    resq_provider rp ON ro.provider_id = rp.provider_id
GROUP BY 
    rp.provider_name
ORDER BY 
    total_sales DESC
LIMIT 10;
