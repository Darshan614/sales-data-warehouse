USE DataWarehouse;
GO

IF EXISTS (SELECT 1 from sys.tables where name='erp_px_cat_g1v2' and schema_id=(select schema_id from sys.schemas where name='bronze'))
	BEGIN
		DROP TABLE bronze.erp_px_cat_g1v2;
	END;
GO

CREATE TABLE bronze.erp_px_cat_g1v2(
	id NVARCHAR(50),
	cat NVARCHAR(50),
	subcat NVARCHAR(50),
	maintenance NVARCHAR(50)
)