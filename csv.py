import pandas as pd
from tabulate import tabulate

table1 = pd.read_csv('table1.csv')
table2 = pd.read_csv('table2.csv')
table3 = pd.read_csv('table3.csv')

result = []

for _, t2 in table2.iterrows():
    usi_id = t2['USI_ID']
    insight_number = t2['Insight_Numbers']
    
    t1_entry = table1[table1['Insight_Numbers'] == insight_number]
    
    if not t1_entry.empty:
        uni_combination = t1_entry['Uni_Combination'].values[0].split(',')
        columns_to_match = [col.strip() for col in uni_combination]
        
        result_row = {
            'USI_ID': usi_id,
            'Insight_Numbers': insight_number
        }
        
        for column in columns_to_match:
            column_key = column.replace(" ", "_")
            t3_entry = table3[table3[column_key] == usi_id]
            if not t3_entry.empty:
                for col in table3.columns:
                    if col.replace("_", " ") in columns_to_match:
                        result_row[col] = t3_entry[col].values[0]
        
        result.append(result_row)

result_df = pd.DataFrame(result)

print(tabulate(result_df, headers='keys', tablefmt='pretty', showindex=False))