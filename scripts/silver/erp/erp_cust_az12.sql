USE DataWarehouse;
GO

IF EXISTS (select 1 from sys.tables where name='erp_cust_az12' and schema_id=(select schema_id from sys.schemas where name='silver'))
BEGIN
	DROP TABLE silver.erp_cust_az12;
END;
GO

CREATE TABLE silver.erp_cust_az12(
	erp_cid NVARCHAR(50),
	erp_bdate DATE,
	erp_gen NVARCHAR(50),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
)