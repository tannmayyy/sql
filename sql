SELECT 
    t2.USI_ID, 
    t2.Insight_Numbers,
    t3.Product_Taxonomy,
    -- Dynamically select columns based on Uni_Combination
    CASE 
        WHEN t1.Uni_Combination LIKE '%FO Source System%' THEN t3.FO_Source_System
        ELSE NULL 
    END AS FO_Source_System,
    t3.Column1,
    t3.Column2
FROM table2 t2
JOIN table1 t1 
    ON t2.Insight_Numbers = t1.Insight_Numbers
JOIN table3 t3 
    ON t3.Product_Taxonomy = CASE 
                                 WHEN t2.USI_ID = 'aditya123' THEN 'aditya'
                                 WHEN t2.USI_ID = 'tanmay' THEN 'tanmay'
                                 ELSE NULL
                               END
