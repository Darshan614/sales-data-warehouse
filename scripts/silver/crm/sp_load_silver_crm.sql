CREATE OR ALTER PROCEDURE silver.sp_load_silver_crm AS
BEGIN
	BEGIN TRY
		PRINT '=========================================';
		PRINT 'TRUNCATING TABLE '+'silver.erp_cust_az12';
		TRUNCATE TABLE silver.crm_cust_info;
		PRINT 'INSERTING INTO TABLE '+'silver.erp_cust_az12';
		INSERT INTO silver.crm_cust_info
		(cst_id,
		cst_firstname,
		cst_lastname,
		cst_key,
		cst_marital_status,
		cst_gndr,
		cst_create_date)
		select 
		cst_id,
		TRIM(cst_firstname) as cst_firstname,
		TRIM(cst_lastname) as cst_lastname,
		cst_key,
		case
			when UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Married'
			when UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single'
			else 'n/a'
		end
		as cst_marital_status,
		case
			when UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
			when UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
			else 'n/a'
		end
		as cst_gndr,
		cst_create_date
		from bronze.crm_cust_info 
		where cst_id is not NULL and cst_firstname is not NULL and cst_lastname is not null and cst_create_date is not null;
		PRINT '=========================================';
	END TRY
	BEGIN CATCH
		PRINT '------------------------------------------';
		PRINT 'Error >> '+ERROR_MESSAGE();
		PRINT '------------------------------------------';
	END CATCH

	BEGIN TRY
		PRINT '=========================================';
		PRINT 'TRUNCATING TABLE '+'silver.erp_cust_az12';
		TRUNCATE TABLE silver.crm_prd_info;
		PRINT 'INSERTING INTO TABLE '+'silver.erp_cust_az12';
		INSERT INTO silver.crm_prd_info (
		prd_id,
		cat_id,
		prd_key,
		prd_nm,
		prd_cost,
		prd_line,
		prd_start_dt,
		prd_end_dt
		)
		select prd_id, 
		REPLACE(SUBSTRING(prd_key,1,5),'-','_') as cat_id,
		SUBSTRING(prd_key,7,LEN(prd_key)) as prd_key,
		prd_nm,
		ISNULL(prd_cost,0) as prd_cost,
		case 
			when TRIM(prd_line) = 'R' then 'Road'
			when prd_line = 'S' then 'Other Sales'
			when prd_line = 'M' then 'Mountain'
			when prd_line = 'T' then 'Touring'
			else 'n/a'
		end 
		as prd_line,
		CAST(prd_start_dt AS DATE) as prd_start_dt,
		CAST(LEAD(prd_start_dt) OVER (partition by prd_key order by prd_start_dt) -1 as date) as prd_end_dt 
		from bronze.crm_prd_info 
		where prd_cost is not null;
		PRINT '=========================================';
	END TRY
	BEGIN CATCH
		PRINT '------------------------------------------';
		PRINT 'Error >> '+ERROR_MESSAGE();
		PRINT '------------------------------------------';
	END CATCH


	BEGIN TRY
		PRINT '=========================================';
		PRINT 'TRUNCATING TABLE '+'silver.erp_cust_az12';
		TRUNCATE TABLE silver.crm_sales_details;
		PRINT 'INSERTING INTO TABLE '+'silver.erp_cust_az12';
		INSERT INTO silver.crm_sales_details (
		sls_ord_num,
		sls_prd_key,
		sls_cust_id,
		sls_order_dt,
		sls_ship_dt,
		sls_due_dt,
		sls_sales,
		sls_quantity,
		sls_price)
		select 
		sls_ord_num,
		sls_prd_key,
		sls_cust_id,
		case when sls_order_dt=0 or LEN(sls_order_dt) != 8 then NULL
		else CAST(CAST(sls_order_dt as NVARCHAR) as DATE)
		end as sls_order_dt,
		case when sls_ship_dt=0 or LEN(sls_ship_dt) != 8 then NULL
		else CAST(CAST(sls_ship_dt as NVARCHAR) as DATE)
		end as sls_ship_dt,
		case when sls_due_dt=0 or LEN(sls_due_dt) != 8 then NULL
		else CAST(CAST(sls_due_dt as NVARCHAR) as DATE)
		end as sls_due_dt,
		case when sls_sales is null or sls_sales <= 0 or sls_sales != ABS(sls_price)*sls_quantity then ABS(sls_price)*sls_quantity
		else sls_sales
		end as sls_sales,
		sls_quantity,
		case when sls_price is null or sls_price <= 0 then sls_sales/NULLIF(sls_quantity,0)
		else sls_price
		end as sls_price
		from bronze.crm_sales_details;
		PRINT '=========================================';
	END TRY
	BEGIN CATCH
		PRINT '------------------------------------------';
		PRINT 'Error >> '+ERROR_MESSAGE();
		PRINT '------------------------------------------';
	END CATCH
END