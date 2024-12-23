SELECT 
    t2.USI_ID,
    t2.Insight_Numbers,
    t3.*
FROM 
    table2 t2
JOIN 
    table3 t3 
    ON t2.USI_ID = t3.USI_ID
WHERE 
    t2.USI_ID = 'aditya';
