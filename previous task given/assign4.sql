--The role you use determines the privileges you have.
USE ROLE accountadmin;

--A warehouse provides the required resources to create and manage objects and run SQL commands
USE WAREHOUSE compute_wh;

CREATE OR REPLACE DATABASE tasty_bytes_sample_data;
CREATE OR REPLACE SCHEMA tasty_bytes_sample_data.raw_pos;
CREATE OR REPLACE TABLE tasty_bytes_sample_data.raw_pos.menu
(
    menu_id NUMBER(19,0),
    menu_type_id NUMBER(38,0),
    menu_type VARCHAR(16777216),
    truck_brand_name VARCHAR(16777216),
    menu_item_id NUMBER(38,0),
    menu_item_name VARCHAR(16777216),
    item_category VARCHAR(16777216),
    item_subcategory VARCHAR(16777216),
    cost_of_goods_usd NUMBER(38,4),
    sale_price_usd NUMBER(38,4),
    menu_item_health_metrics_obj VARIANT
);
--To confirm that the table was created successfully, seelct the table 'tasty_bytes_sample_data.raw_pos.menu'
SELECT * FROM tasty_bytes_sample_data.raw_pos.menu;

CREATE OR REPLACE STAGE tasty_bytes_sample_data.public.blob_stage
url = 's3://sfquickstarts/tastybytes/'
file_format = (type = csv);

--to show my stage has been created 
LIST @tasty_bytes_sample_data.public.blob_stage/raw_pos/menu/;

--load data into the table, use the 'copy' format
COPY INTO tasty_bytes_sample_data.raw_pos.menu
FROM @tasty_bytes_sample_data.public.blob_stage/raw_pos/menu/;

--start to query the data
SELECT COUNT(*) AS row_count FROM tasty_bytes_sample_data.raw_pos.menu;

SELECT * FROM tasty_bytes_sample_data.raw_pos.menu;
SELECT * FROM tasty_bytes_sample_data.raw_pos.menu
where MENU_ITEM_NAME like '%e';

SELECT ITEM_CATEGORY, COUNT(*) AS NUMBER_OF_ITEMS FROM tasty_bytes_sample_data.raw_pos.menu
GROUP BY ITEM_CATEGORY;

SELECT * FROM tasty_bytes_sample_data.raw_pos.menu
WHERE MENU_ID = 10004;


SELECT * FROM tasty_bytes_sample_data.raw_pos.menu
WHERE MENU_ID <> 10004;

SELECT SUM(COST_OF_GOODS_USD) AS TOTAL_COST_OF_GOODS FROM tasty_bytes_sample_data.raw_pos.menu;


SELECT * FROM tasty_bytes_sample_data.raw_pos.menu;



























