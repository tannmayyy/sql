CREATE OR REPLACE PROCEDURE dynamic_uni_combination_columns (USI_ID_VALUE STRING)
  RETURNS STRING
  LANGUAGE JAVASCRIPT
  EXECUTE AS CALLER
AS
$$
  // Step 1: Query to get the distinct Uni_Combination for the provided USI_ID
  var sql_command = `
    SELECT DISTINCT Uni_Combination 
    FROM table1 
    WHERE Insight_Numbers IN (SELECT Insight_Numbers FROM table2 WHERE USI_ID = :USI_ID_VALUE)
  `;
  var statement1 = snowflake.createStatement({sqlText: sql_command, binds: [{name: "USI_ID_VALUE", value: USI_ID_VALUE}]});
  var result1 = statement1.execute();
  
  // Step 2: Split the Uni_Combination and dynamically create columns based on the number of values
  var columns = [];
  while (result1.next()) {
    var combinations = result1.getColumnValue(1);
    var split_combinations = combinations.split('+');
    
    // Generate the column names dynamically
    for (var i = 0; i < split_combinations.length; i++) {
      columns.push("CASE WHEN instr(Uni_Combination, '" + split_combinations[i] + "') > 0 THEN '" + split_combinations[i] + "' ELSE NULL END AS Column" + (i + 1));
    }
  }

  // Step 3: Construct the final dynamic SQL
  var dynamic_sql = `
    SELECT t2.USI_ID, t2.Insight_Numbers, ` + columns.join(", ") + `
    FROM table2 t2
    JOIN table1 t1 ON t2.Insight_Numbers = t1.Insight_Numbers
    WHERE t2.USI_ID = :USI_ID_VALUE
  `;

  // Step 4: Execute the dynamic SQL and return the results
  var statement2 = snowflake.createStatement({sqlText: dynamic_sql, binds: [{name: "USI_ID_VALUE", value: USI_ID_VALUE}]});
  var result2 = statement2.execute();
  return result2;
$$;
