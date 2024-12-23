WITH SplitColumns AS (
    -- Step 1: Split the Uni_Combination into individual columns
    SELECT
        t2.USI_ID,
        t2.Insight_Numbers,
        SPLIT_PART(t1.Uni_Combination, '+', 1) AS Column1,
        SPLIT_PART(t1.Uni_Combination, '+', 2) AS Column2
    FROM
        table2 t2
    JOIN
        table1 t1 ON t2.Insight_Numbers = t1.Insight_Numbers
    WHERE
        t2.USI_ID = 'aditya'
),
DynamicData AS (
    -- Step 2: Use conditional logic to fetch values dynamically
    SELECT
        s.USI_ID,
        s.Insight_Numbers,
        CASE 
            WHEN COLUMN_NAME = s.Column1 THEN VALUE
            ELSE NULL 
        END AS Column1_Value,
        CASE 
            WHEN COLUMN_NAME = s.Column2 THEN VALUE
            ELSE NULL 
        END AS Column2_Value
    FROM
        SplitColumns s
    JOIN 
        table3 t3 ON t3.USI_ID = s.USI_ID
)
-- Step 3: Aggregate the results
SELECT
    USI_ID,
    Insight_Numbers,
    MAX(Column1_Value) AS Column1_Value,
    MAX(Column2_Value) AS Column2_Value
FROM
    DynamicData
GROUP BY
    USI_ID, Insight_Numbers;
