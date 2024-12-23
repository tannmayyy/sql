SELECT 
    t2.USI_ID,
    t2.Insight_Numbers,
    t1.Uni_Combination,
    t3.*
FROM 
    table2 t2
JOIN 
    table1 t1 
    ON t2.Insight_Numbers = t1.Insight_Numbers
JOIN 
    table3 t3 
    ON SPLIT_PART(t1.Uni_Combination, '+', 1) = t3.Product_Taxonomy
WHERE 
    t2.USI_ID = 'aditya';
