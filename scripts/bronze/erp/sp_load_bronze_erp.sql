USE DataWarehouse;
GO

CREATE OR ALTER PROCEDURE bronze.sp_load_bronze_erp AS
BEGIN
	BEGIN TRY
		PRINT '=========================================';
		PRINT 'TRUNCATING TABLE '+'bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;
		PRINT 'INSERTING INTO TABLE '+'bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\jaind\OneDrive\Documents\Data_Warehouse\sales-data-warehouse\datasets\source_erp\CUST_AZ12.csv'
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
		PRINT 'TRUNCATING TABLE '+'bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;
		PRINT 'INSERTING INTO TABLE '+'bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\jaind\OneDrive\Documents\Data_Warehouse\sales-data-warehouse\datasets\source_erp\LOC_A101.csv'
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
		PRINT 'TRUNCATING TABLE '+'bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		PRINT 'INSERTING INTO TABLE '+'bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\jaind\OneDrive\Documents\Data_Warehouse\sales-data-warehouse\datasets\source_erp\PX_CAT_G1V2.csv'
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

