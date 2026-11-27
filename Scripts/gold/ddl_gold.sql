
-- =============================================================================
-- Create Dimension: gold.dim_customers
-- =============================================================================
IF OBJECT_ID('gold.dim_customers', 'V') IS NOT NULL
    DROP VIEW gold.dim_customers;
GO
CREATE VIEW gold.dim_customers AS 
SELECT 
ROW_NUMBER() OVER(ORDER BY ci.cst_id) AS customer_key,
ci.cst_id AS customer_id,
ci.cst_key AS customer_number,
ci.cst_firstname AS first_name,
ci.cst_lastname AS last_name ,
la.cntry AS country,
ci.cst_marital_status AS marital_status,
CASE WHEN ci.cst_gndr!='n/a' THEN cst_gndr 
ELSE COALESCE(ca.gen,'n/a')
END gender,
ca.bdate AS birth_date,
ci.cst_create_date AS create_date
FROM 
silver.crm_cust_info ci
LEFT JOIN silver.erp_cust_az12 ca 
ON ca.cid=ci.cst_key 
LEFT JOIN silver.erp_loc_a101 la 
ON la.cid=ci.cst_key;
GO

-- =============================================================================
-- Create Dimension: gold.dim_products
-- =============================================================================

IF OBJECT_ID('gold.dim_products', 'V') IS NOT NULL
    DROP VIEW gold.dim_products;
GO
CREATE VIEW gold.dim_products AS 
SELECT 
ROW_NUMBER() OVER(ORDER BY pi.prd_start_dt,pi.prd_key) AS product_key,
pi.prd_id AS product_id,
pi.prd_key AS product_number,
pi.prd_nm AS product_name,
pi.cat_id AS category_id,
pc.cat AS category,
pc.subcat AS subcategory,
pc.maintenance AS maintenance,
pi.prd_cost AS cost,
pi.prd_line AS product_line,
pi.prd_start_dt AS start_date
FROM silver.crm_prd_info pi
LEFT JOIN silver.erp_px_cat_g1v2 pc
ON pi.cat_id=pc.id
WHERE pi.prd_end_dt IS NULL;
GO

-- =============================================================================
-- Create Fact Table: gold.fact_sales
-- =============================================================================
IF OBJECT_ID('gold.fact_sales', 'V') IS NOT NULL
    DROP VIEW gold.fact_sales;
GO
CREATE VIEW gold.fact_sales AS
SELECT 
so.sls_ord_num AS order_number,
dp.product_key AS product_key,
dc.customer_key AS customer_key,
so.sls_order_dt AS order_date,
so.sls_ship_dt  AS shipping_date,
so.sls_due_dt   AS due_date,
so.sls_sales AS sales_amount,
so.sls_quantity AS quantity,
so.sls_price AS price
FROM 
silver.crm_sales_details so
LEFT JOIN 
gold.dim_products dp  
ON so.sls_prd_key=dp.product_number
LEFT JOIN 
gold.dim_customers dc 
ON so.sls_cust_id=dc.customer_id;
GO;


