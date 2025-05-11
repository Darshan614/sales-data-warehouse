USE DataWarehouse;
GO

CREATE OR ALTER PROCEDURE silver.sp_load_silver_erp AS
BEGIN
	BEGIN TRY
		PRINT '=========================================';
		PRINT 'TRUNCATING TABLE '+'silver.erp_cust_az12';
		TRUNCATE TABLE silver.erp_cust_az12;
		PRINT 'INSERTING INTO TABLE '+'silver.erp_cust_az12';
		INSERT INTO silver.erp_cust_az12 (erp_cid,erp_bdate,erp_gen)
		select 
		case when erp_cid like 'NAS%' then SUBSTRING(erp_cid,4,LEN(erp_cid))
		else erp_cid
		end as erp_cid,
		case when erp_bdate > GETDATE() THEN NULL 
		else erp_bdate
		end as erp_bdate,
		case 
		when UPPER(TRIM(erp_gen)) IN ('M', 'MALE') THEN 'Male'
		when UPPER(TRIM(erp_gen)) IN ('F', 'FEMALE') THEN 'Female'
		else 'n/a'
		END AS erp_gen
		from bronze.erp_cust_az12;
		PRINT '=========================================';
	END TRY
	BEGIN CATCH
		PRINT '------------------------------------------';
		PRINT 'Error >> '+ERROR_MESSAGE();
		PRINT '------------------------------------------';
	END CATCH

	BEGIN TRY
		PRINT '=========================================';
		PRINT 'TRUNCATING TABLE '+'silver.erp_loc_a101';
		TRUNCATE TABLE silver.erp_loc_a101;
		PRINT 'INSERTING INTO TABLE '+'silver.erp_loc_a101';
		INSERT into silver.erp_loc_a101 (cid, cntry)
		select 
		REPLACE(cid,'-','') as cid,
		case 
		when TRIM(cntry) = 'DE' then 'Germany'
		when TRIM(cntry) in ('USA','US') THEN 'United States'
		when TRIM(cntry) = '' or TRIM(cntry) is null THEN 'n/a'
		else TRIM(cntry)
		end as cntry
		from bronze.erp_loc_a101;
		PRINT '=========================================';
	END TRY
	BEGIN CATCH
		PRINT '------------------------------------------';
		PRINT 'Error >> '+ERROR_MESSAGE();
		PRINT '------------------------------------------';
	END CATCH

	BEGIN TRY
		PRINT '=========================================';
		PRINT 'TRUNCATING TABLE '+'silver.erp_px_cat_g1v2';
		TRUNCATE TABLE silver.erp_px_cat_g1v2;
		PRINT 'INSERTING INTO TABLE '+'silver.erp_px_cat_g1v2';
		INSERT INTO silver.erp_px_cat_g1v2(id, cat,subcat, maintenance)
		select * from bronze.erp_px_cat_g1v2
		PRINT '=========================================';
	END TRY
	BEGIN CATCH
		PRINT '------------------------------------------';
		PRINT 'Error >> '+ERROR_MESSAGE();
		PRINT '------------------------------------------';
	END CATCH
END;

