def create_table(column_names, rows):
    return [dict(zip(column_names, row)) for row in rows]

table1_columns = ['Insight_Numbers', 'Uni_Combination']
table1_rows = [
    ['Insight 401 Impacted', 'Product Taxonomy,FO Source System'],
    ['Insight 1609A Impacted', 'Product Taxonomy']
]

table2_columns = ['USI_ID', 'Insight_Numbers']
table2_rows = [
    ['aditya', 'Insight 401 Impacted'],
    ['tanmay', 'Insight 1609A Impacted']
]

table3_columns = ['Product_Taxonomy', 'FO_Source_System', 'Column1', 'Column2']
table3_rows = [
    ['aditya', '123', 'XYZ', 'UVW'],
    ['tanmay', '456', '789', '123']
]

table1 = create_table(table1_columns, table1_rows)
table2 = create_table(table2_columns, table2_rows)
table3 = create_table(table3_columns, table3_rows)

result = []

for t2 in table2:
    usi_id = t2['USI_ID']
    insight_number = t2['Insight_Numbers']
    
    t1_entry = next((t1 for t1 in table1 if t1['Insight_Numbers'] == insight_number), None)
    
    if t1_entry:
        uni_combination = t1_entry['Uni_Combination'].split(',')
        columns_to_match = [col.strip() for col in uni_combination]
        
        result_row = {
            'USI_ID': usi_id,
            'Insight_Numbers': insight_number
        }
        
        for column in columns_to_match:
            t3_entry = next((t3 for t3 in table3 if t3[column.replace(" ", "_")] == usi_id), None)
            if t3_entry:
                for col in table3_columns:
                    if col.replace("_", " ") in columns_to_match:
                        result_row[col] = t3_entry[col]
        
        result.append(result_row)



for row in result:
    print(row)