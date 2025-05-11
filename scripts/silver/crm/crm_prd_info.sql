USE DataWarehouse;
GO

IF EXISTS (SELECT 1 from sys.tables where name='crm_prd_info' and schema_id=(select schema_id from sys.schemas where name='silver'))
BEGIN
	DROP TABLE silver.crm_prd_info;
END;
GO


CREATE TABLE silver.crm_prd_info(
	prd_id INT,
	prd_key NVARCHAR(50),
	cat_id NVARCHAR(50),
	prd_nm NVARCHAR(50),
	prd_cost INT,
	prd_line NVARCHAR(50),
	prd_start_dt DATE,
	prd_end_dt DATE,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
)