USE DataWarehouse;
GO

IF EXISTS (select 1 from sys.tables where name='erp_cust_az12' and schema_id=(select schema_id from sys.schemas where name='bronze'))
BEGIN
	DROP TABLE bronze.erp_cust_az12;
END;
GO

CREATE TABLE bronze.erp_cust_az12(
	erp_cid NVARCHAR(50),
	erp_bdate DATE,
	erp_gen NVARCHAR(50)
)