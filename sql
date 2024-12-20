-- Replace 'aditya' with the desired USI_ID
SELECT 
    t2.USI_ID,
    t2.Insight_Numbers,
    -- Dynamically include columns based on Uni_Combination
    CASE 
        WHEN instr(t1.Uni_Combination, 'Product Taxonomy') > 0 THEN t3.Product_Taxonomy
        ELSE NULL
    END AS Product_Taxonomy,
    CASE 
        WHEN instr(t1.Uni_Combination, 'FO Source System') > 0 THEN t3.FO_Source_System
        ELSE NULL
    END AS FO_Source_System,
    t3.Column1,
    t3.Column2
FROM 
    table2 t2
JOIN 
    table1 t1 ON t2.Insight_Numbers = t1.Insight_Numbers
JOIN 
    table3 t3 ON t2.USI_ID = t3.Product_Taxonomy
WHERE 
    t2.USI_ID = 'aditya';  