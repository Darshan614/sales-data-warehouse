USE DataWarehouse;
GO

IF EXISTS (SELECT 1 from sys.tables where name='crm_sales_details' and schema_id=(select schema_id from sys.schemas where name='silver'))
BEGIN
	DROP TABLE silver.crm_sales_details;
END;
GO

CREATE TABLE silver.crm_sales_details(
	sls_ord_num NVARCHAR(50),
	sls_prd_key NVARCHAR(50),
	sls_cust_id INT,
	sls_order_dt DATE,
	sls_ship_dt DATE,
	sls_due_dt DATE,
	sls_sales INT,
	sls_quantity INT,
	sls_price INT,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
)
