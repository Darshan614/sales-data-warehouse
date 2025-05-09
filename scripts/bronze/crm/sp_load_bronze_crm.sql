CREATE OR ALTER PROCEDURE bronze.sp_load_bronze_crm AS
BEGIN
	BEGIN TRY
		PRINT '=========================================';
		PRINT 'TRUNCATING TABLE '+'bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;
		PRINT 'INSERTING INTO TABLE '+'bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\jaind\OneDrive\Documents\Data_Warehouse\sales-data-warehouse\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		PRINT '=========================================';
	END TRY
	BEGIN CATCH
		PRINT '------------------------------------------';
		PRINT 'Error >> '+ERROR_MESSAGE();
		PRINT '------------------------------------------';
	END CATCH

	BEGIN TRY
		PRINT '=========================================';
		PRINT 'TRUNCATING TABLE '+'bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;
		PRINT 'INSERTING INTO TABLE '+'bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\jaind\OneDrive\Documents\Data_Warehouse\sales-data-warehouse\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		PRINT '=========================================';
	END TRY
	BEGIN CATCH
		PRINT '------------------------------------------';
		PRINT 'Error >> '+ERROR_MESSAGE();
		PRINT '------------------------------------------';
	END CATCH

	BEGIN TRY
		PRINT '=========================================';
		PRINT 'TRUNCATING TABLE '+'bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;
		PRINT 'INSERTING INTO TABLE '+'bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\jaind\OneDrive\Documents\Data_Warehouse\sales-data-warehouse\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		PRINT '=========================================';
	END TRY
	BEGIN CATCH
		PRINT '------------------------------------------';
		PRINT 'Error >> '+ERROR_MESSAGE();
		PRINT '------------------------------------------';
	END CATCH
END