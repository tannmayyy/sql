-- Step 1: Get the column names from table3
WITH Table3Columns AS (
    SELECT COLUMN_NAME
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'table3'
),
-- Step 2: Split Uni_Combination values into individual components
UniCombinations AS (
    SELECT 
        Insight_Numbers,
        TRIM(value) AS Condition
    FROM 
        table1,
        (SELECT SPLIT(Uni_Combination, '+') AS value FROM table1) AS split_values
)
-- Step 3: Check if Uni_Combination values are present in table3 columns
SELECT 
    uc.Insight_Numbers,
    uc.Condition AS Uni_Combination_Column,
    CASE 
        WHEN EXISTS (
            SELECT 1 
            FROM Table3Columns tc 
            WHERE REPLACE(uc.Condition, ' ', '_') = tc.COLUMN_NAME
        ) THEN 'Exists in table3'
        ELSE 'Does not exist in table3'
    END AS Existence_Status
FROM 
    UniCombinations uc;