import pyodbc

def get_connection():
    conn = pyodbc.connect(
        'DRIVER={ODBC Driver 17 for SQL Server};'
        'SERVER=host.docker.internal,1433;'  
        'DATABASE=DataWarehouse;'      
        'UID=airflow_user;'
        'PWD=Msdhoni@07;'
    )
    return conn

try:
    conn = get_connection()
    cursor = conn.cursor()
    rows = conn.execute('SELECT name from sys.tables;')
    for row in rows:
        print(row[0])
except Exception as e:
    print("Error Occured: ",e)
