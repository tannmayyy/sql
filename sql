WITH SplitColumns AS (
    SELECT
        t2.USI_ID,
        t2.Insight_Numbers,
        SPLIT(t1.Uni_Combination, '+')[0] AS Column1,
        SPLIT(t1.Uni_Combination, '+')[1] AS Column2
    FROM
        table2 t2
    JOIN
        table1 t1 ON t2.Insight_Numbers = t1.Insight_Numbers
    WHERE
        t2.USI_ID = 'aditya'
),
ValidatedColumns AS (
    SELECT 
        s.USI_ID,
        s.Insight_Numbers,
        s.Column1,
        s.Column2,
        CASE WHEN COLUMN_NAME = s.Column1 THEN s.Column1 ELSE NULL END AS ValidColumn1,
        CASE WHEN COLUMN_NAME = s.Column2 THEN s.Column2 ELSE NULL END AS ValidColumn2
    FROM 
        SplitColumns s
    JOIN 
        INFORMATION_SCHEMA.COLUMNS c
    ON 
        c.TABLE_NAME = 'table3'
),
FinalOutput AS (
    SELECT
        vc.USI_ID,
        vc.Insight_Numbers,
        vc.ValidColumn1,
        vc.ValidColumn2,
        t3.*
    FROM
        ValidatedColumns vc
    LEFT JOIN
        table3 t3
    ON 
        t3.COLUMN_NAME = vc.ValidColumn1 OR t3.COLUMN_NAME = vc.ValidColumn2
)
SELECT *
FROM FinalOutput;
