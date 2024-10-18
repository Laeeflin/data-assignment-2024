# The problem no1
# Query to identify the customers’ favourite partner segments (default offer types). Partners are the companies who sell surplus items on the marketplace.

SELECT 
    rp.segment AS partner_segment,                        # rp = resq_provider
    COUNT(DISTINCT ru.user_id) AS customer_count          # ru = resq_user
FROM 
    resq_user ru
JOIN 
    resq_order ro ON ru.user_id = ro.user_id              # ro = resq_order
JOIN 
    resq_provider rp ON ro.provider_id = rp.provider_id
GROUP BY 
    rp.segment
ORDER BY 
    customer_count DESC;
