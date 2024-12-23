SELECT 
    t2.USI_ID,
    t2.Insight_Numbers,
    t3.*
FROM 
    table2 t2
JOIN 
    table1 t1 
    ON t2.Insight_Numbers = t1.Insight_Numbers
JOIN 
    table3 t3 
    ON t3.COLUMN_NAME IN (SPLIT_PART(t1.Uni_Combination, '+', 1), SPLIT_PART(t1.Uni_Combination, '+', 2))
WHERE 
    t2.USI_ID = 'aditya';
