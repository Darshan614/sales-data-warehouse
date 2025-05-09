USE DataWarehouse;
GO
 
IF EXISTS (SELECT 1 from sys.tables where name='erp_loc_a101' and schema_id=(select schema_id from sys.schemas where name='bronze'))
BEGIN
	DROP TABLE bronze.erp_loc_a101;
END;
GO


CREATE TABLE bronze.erp_loc_a101(
	CID NVARCHAR(50),
	CNTRY NVARCHAR(50)
)