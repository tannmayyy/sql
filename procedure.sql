CREATE OR REPLACE PROCEDURE dynamic_column_split()
RETURNS TABLE (USI_ID STRING, Insight_Numbers STRING, Column1_Value STRING, Column2_Value STRING)
LANGUAGE JAVASCRIPT
AS
$$
    let result = [];
    let sqlText;

    // Query to fetch data from table2 and table1
    sqlText = `
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
    `;

    // Execute the first query
    let data = snowflake.execute({sqlText: sqlText});

    // Loop through each row and validate columns in table3
    while (data.next()) {
        let usiId = data.getColumnValue(1);
        let insightNumbers = data.getColumnValue(2);
        let column1 = data.getColumnValue(3);
        let column2 = data.getColumnValue(4);

        // Check if Column1 exists in table3
        let column1Value = '';
        let column2Value = '';

        let checkColumn1Query = `
            SELECT ${column1} 
            FROM table3
            WHERE USI_ID = '${usiId}'
            LIMIT 1
        `;
        try {
            let col1Data = snowflake.execute({sqlText: checkColumn1Query});
            if (col1Data.next()) {
                column1Value = col1Data.getColumnValue(1);
            }
        } catch (err) {
            column1Value = 'Column1 Not Found';
        }

        // Check if Column2 exists in table3
        let checkColumn2Query = `
            SELECT ${column2} 
            FROM table3
            WHERE USI_ID = '${usiId}'
            LIMIT 1
        `;
        try {
            let col2Data = snowflake.execute({sqlText: checkColumn2Query});
            if (col2Data.next()) {
                column2Value = col2Data.getColumnValue(1);
            }
        } catch (err) {
            column2Value = 'Column2 Not Found';
        }

        // Append results to final output
        result.push({
            USI_ID: usiId,
            Insight_Numbers: insightNumbers,
            Column1_Value: column1Value,
            Column2_Value: column2Value
        });
    }

    // Return the result as a table
    return result;
$$;
