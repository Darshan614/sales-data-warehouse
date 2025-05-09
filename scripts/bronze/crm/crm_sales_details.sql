USE DataWarehouse;
GO

IF EXISTS (SELECT 1 from sys.tables where name='crm_sales_details' and schema_id=(select schema_id from sys.schemas where name='bronze'))
BEGIN
	DROP TABLE bronze.crm_sales_details;
END;
GO

CREATE TABLE bronze.crm_sales_details(
	sls_ord_num NVARCHAR(50),
	sls_prd_key NVARCHAR(50),
	sls_cust_id INT,
	sls_order_dt INT,
	sls_ship_dt INT,
	sls_due_dt INT,
	sls_sales INT,
	sls_quantity INT,
	sls_price INT
)
