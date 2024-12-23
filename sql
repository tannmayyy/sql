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
        CASE WHEN EXISTS (
            SELECT 1 
            FROM INFORMATION_SCHEMA.COLUMNS 
            WHERE TABLE_NAME = 'table3' AND COLUMN_NAME = s.Column1
        ) THEN s.Column1 ELSE NULL END AS ValidColumn1,
        CASE WHEN EXISTS (
            SELECT 1 
            FROM INFORMATION_SCHEMA.COLUMNS 
            WHERE TABLE_NAME = 'table3' AND COLUMN_NAME = s.Column2
        ) THEN s.Column2 ELSE NULL END AS ValidColumn2
    FROM
        SplitColumns s
),
FinalOutput AS (
    SELECT
        vc.USI_ID,
        vc.Insight_Numbers,
        t3.* -- Include all columns from table3
    FROM
        ValidatedColumns vc
    LEFT JOIN
        table3 t3
    ON
        1=1 -- No direct column matching is required here
)
SELECT
    USI_ID,
    Insight_Numbers,
    ValidColumn1,
    ValidColumn2,
    t3.*
FROM
    FinalOutput;
