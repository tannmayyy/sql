-- Step 1: Split Uni_Combination into dynamic columns
WITH SplitColumns AS (
    SELECT 
        t2.USI_ID,
        t2.Insight_Numbers,
        SPLIT_PART(t1.Uni_Combination, '+', 1) AS Column1,
        SPLIT_PART(t1.Uni_Combination, '+', 2) AS Column2
    FROM 
        table2 t2
    JOIN 
        table1 t1 
        ON t2.Insight_Numbers = t1.Insight_Numbers
    WHERE 
        t2.USI_ID = 'aditya'
),

-- Step 2: Check and fetch dynamic columns from table3
ColumnData AS (
    SELECT 
        sc.USI_ID,
        sc.Insight_Numbers,
        sc.Column1,
        sc.Column2,
        MAX(CASE WHEN t3.COLUMN_NAME = sc.Column1 THEN t3.COLUMN_VALUE END) AS Column1_Value,
        MAX(CASE WHEN t3.COLUMN_NAME = sc.Column2 THEN t3.COLUMN_VALUE END) AS Column2_Value
    FROM 
        SplitColumns sc
    JOIN 
        table3 t3 
        ON t3.COLUMN_NAME IN (sc.Column1, sc.Column2)
    GROUP BY 
        sc.USI_ID, sc.Insight_Numbers, sc.Column1, sc.Column2
)

-- Step 3: Generate final output
SELECT 
    USI_ID,
    Insight_Numbers,
    Column1,
    Column1_Value,
    Column2,
    Column2_Value
FROM 
    ColumnData;
