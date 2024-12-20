SELECT 
    t2.USI_ID,
    t2.Insight_Numbers,
    -- Split Uni_Combination by '+' into two columns
    SPLIT(t1.Uni_Combination, '+')[0] AS Column1,
    SPLIT(t1.Uni_Combination, '+')[1] AS Column2
FROM 
    table2 t2
JOIN 
    table1 t1 ON t2.Insight_Numbers = t1.Insight_Numbers
WHERE 
    t2.USI_ID = 'aditya';
