USE DataWarehouse;
GO

IF EXISTS (select 1 from sys.tables where name='crm_cust_info' and schema_id=(select schema_id from sys.schemas where name='bronze'))
BEGIN
	DROP TABLE bronze.crm_cust_info;
END;
GO

CREATE TABLE bronze.crm_cust_info (
	cst_id INT,
	cst_key NVARCHAR(50),
	cst_firstname NVARCHAR(50),
	cst_lastname NVARCHAR(50),
	cst_marital_status NVARCHAR(50),
	cst_gndr NVARCHAR(50),
	cst_create_date DATE
);


