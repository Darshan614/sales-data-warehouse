CREATE VIEW gold.dim_customers AS
select 
ROW_NUMBER() OVER (ORDER BY cst_id) as customer_key,
ci.cst_id as customer_id,
ci.cst_key as customer_number,
ci.cst_firstname as first_name,
ci.cst_lastname as last_name,
la.cntry as country,
ca.erp_bdate as birthdate,
ci.cst_marital_status as marital_status,
case when ci.cst_gndr != 'n/a' then ci.cst_gndr
else coalesce(ca.erp_gen,'n/a')
end as gender,
ci.cst_create_date as create_date
from silver.crm_cust_info ci left join silver.erp_cust_az12 ca on ci.cst_key = ca.erp_cid 
left join silver.erp_loc_a101 la on ci.cst_key = la.cid;

select * from gold.dim_customers;