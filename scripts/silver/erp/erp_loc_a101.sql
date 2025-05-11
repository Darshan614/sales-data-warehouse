USE DataWarehouse;
GO
 
IF EXISTS (SELECT 1 from sys.tables where name='erp_loc_a101' and schema_id=(select schema_id from sys.schemas where name='silver'))
BEGIN
	DROP TABLE silver.erp_loc_a101;
END;
GO


CREATE TABLE silver.erp_loc_a101(
	cid NVARCHAR(50),
	cntry NVARCHAR(50),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
)