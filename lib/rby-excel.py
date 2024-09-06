import pandas as pd

def get_data_by_id_from_sheets(file_path, deskripsi, id_value, sheet_names=None):
    xls = pd.ExcelFile(file_path)
    
    sheet_names = sheet_names or xls.sheet_names

    if isinstance(sheet_names, str):
        sheet_names = [sheet_names]
    
    for sheet in sheet_names:
        df = pd.read_excel(file_path, sheet_name=sheet)
    
        filtered_data = df[(df['TEST ID'] == id_value) & (df['DESKRIPSI'] == deskripsi)]
        
        if not filtered_data.empty:
            return filtered_data.to_dict(orient='records')[0]
    
    print("DATA TIDAK DITEMUKAN")
    return None
    

# Example use
file_path = '/Users/robbydarmawan/Documents/Automation/Robot-Framework-Custom/data/Data_Test.xlsx'
id_value = 'TC001'
deskripsi = 'information contact'
sheet_names = ['Data_1','Data_2']  # Option

result = get_data_by_id_from_sheets(file_path, deskripsi, id_value, sheet_names)
print(result)