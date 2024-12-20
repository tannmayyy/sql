CREATE OR REPLACE PROCEDURE check_uni_combination_for_usi_id(usi_id_input STRING)
    RETURNS STRING
    LANGUAGE JAVASCRIPT
    EXECUTE AS CALLER
AS
$$
try {
    // Declare variables
    var sql_command;
    var result_InsightNumbers;
    var result_UniCombination;

    // Query to get Insight_Numbers for the given USI_ID
    sql_command = `SELECT Insight_Numbers 
                   FROM table2 
                   WHERE USI_ID = :1`;
    
    // Execute the query for Insight_Numbers
    var stmt = snowflake.createStatement({sqlText: sql_command, binds: [usi_id_input]});
    result_InsightNumbers = stmt.execute();

    // Check if any records are returned for the given USI_ID
    if (result_InsightNumbers.next()) {
        var insight_number = result_InsightNumbers.getColumnValue(1);

        // Now, fetch Uni_Combination for the same Insight_Numbers from table1
        sql_command = `SELECT Uni_Combination 
                       FROM table1 
                       WHERE Insight_Numbers = :1`;

        stmt = snowflake.createStatement({sqlText: sql_command, binds: [insight_number]});
        result_UniCombination = stmt.execute();

        // Fetch and display the Uni_Combination
        if (result_UniCombination.next()) {
            var uni_combination = result_UniCombination.getColumnValue(1);
            return "Uni_Combination for Insight_Numbers '" + insight_number + "' is: " + uni_combination;
        } else {
            return "No Uni_Combination found for Insight_Numbers '" + insight_number + "'";
        }
    } else {
        return "No Insight_Numbers found for USI_ID: " + usi_id_input;
    }

} catch(err) {
    return "Error: " + err;
}
$$;
