use database sf_tuts; 
CREATE OR REPLACE DATABASE sf_tuts;
SELECT CURRENT_DATABASE(), CURRENT_SCHEMA();
CREATE OR REPLACE TABLE emp_basic (
   first_name STRING ,
   last_name STRING ,
   email STRING ,
   streetaddress STRING ,
   city STRING ,
   start_date DATE
   );
   CREATE OR REPLACE WAREHOUSE sf_tuts_wh WITH
   WAREHOUSE_SIZE='X-SMALL'
   AUTO_SUSPEND = 180
   AUTO_RESUME = TRUE
   INITIALLY_SUSPENDED=TRUE;
   create stage sf_tuts.public.%emp_basic ;
   SELECT CURRENT_WAREHOUSE();
   PUT file://C:\temp\employees0*.csv @sf_tuts.public.%emp_basic;