from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.sensors.filesystem import FileSensor
from datetime import datetime
import pyodbc
import os
import re

# Connection details for MSSQL
def get_connection():
    conn = pyodbc.connect(
        'DRIVER={ODBC Driver 17 for SQL Server};'
        'SERVER=host.docker.internal,1433;'  
        'DATABASE=DataWarehouse;'      
        'UID=airflow_user;'
        'PWD=Msdhoni@07;'
    )
    return conn

# Function to run a .sql script
def run_sql_script(script, **context):
    conn = get_connection()
    cursor = conn.cursor()

    # with open(script_path, 'r') as file:
    #     sql_script = file.read()
    
    # batches = re.split(r'^\s*GO\s*$', sql_script, flags=re.IGNORECASE | re.MULTILINE)

    # for batch in batches:
    #     cleaned = batch.strip()
    #     if cleaned:
    #         cursor.execute('EXEC bronze.sp_load_bronze_crm')
    #         conn.commit()

    cursor.execute(script)
    cursor.close()
    conn.close()
    print(f"Executed script: {script}")

# DAG Definition
with DAG(
    dag_id='bronze_to_silver_pipeline',
    start_date=datetime(2024, 1, 1),
    schedule_interval=None,
    catchup=False
) as dag:

    wait_for_file = FileSensor(
        task_id='wait_for_file',
        filepath='/opt/airflow/datasets/go-files/datalake.go',
        poke_interval=10,
        timeout=600
    )

    load_crm_bronze = PythonOperator(
        task_id='load_crm_bronze',
        python_callable=run_sql_script,
        op_args=['EXEC bronze.sp_load_bronze_crm;']
    )

    load_erp_bronze = PythonOperator(
        task_id='load_erp_bronze',
        python_callable=run_sql_script,
        op_args=['EXEC bronze.sp_load_bronze_erp;']
    )

    load_crm_silver = PythonOperator(
        task_id='load_crm_silver',
        python_callable = run_sql_script,
        op_args=['EXEC silver.sp_load_silver_crm;']
    )

    load_erp_silver = PythonOperator(
        task_id='load_erp_silver',
        python_callable=run_sql_script,
        op_args=['EXEC silver.sp_load_silver_erp;']
    )

    wait_for_file >> load_crm_bronze >> load_erp_bronze >> load_crm_silver >> load_erp_silver
