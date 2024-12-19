SELECT t2.USI_ID, 
       t2.Insight_Numbers,
       t3.Product_Taxonomy,
       CASE 
           WHEN t1.Uni_Combination = 'Product Taxonomy+FO Source System' THEN t3.FO_Source_System
           ELSE NULL 
       END AS FO_Source_System,
       t3.Column1,
       t3.Column2
FROM table2 t2
JOIN table1 t1 ON t2.Insight_Numbers = t1.Insight_Numbers
JOIN table3 t3 ON (t2.USI_ID = 'aditya123' AND t2.Insight_Numbers = 'Insight 401 Impacted' AND t3.Product_Taxonomy = 'aditya' 
                   OR t2.USI_ID = 'tanmay345' AND t2.Insight_Numbers = 'Insight 1609A Impacted' AND t3.Product_Taxonomy = 'tanmay')
