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
   SELECT CURRENT_WAREHOUSE();
   PUT file:///workspaces/snowdbtrep/employees0*.csv @sf_tuts.public.%emp_basic;
    LIST @sf_tuts.public.%emp_basic;
    COPY INTO emp_basic
  FROM @%emp_basic
  FILE_FORMAT = (type = csv field_optionally_enclosed_by='"')
  PATTERN = '.*employees0[1-5].csv.gz'
  ON_ERROR = 'skip_file';

  SELECT * FROM emp_basic;
  INSERT INTO emp_basic VALUES
   ('Clementine','Adamou','cadamou@sf_tuts.com','10510 Sachs Road','Klenak','2017-9-22') ,
   ('Marlowe','De Anesy','madamouc@sf_tuts.co.uk','36768 Northfield Plaza','Fangshan','2017-1-26');

SELECT email FROM emp_basic WHERE email LIKE '%.uk';
SELECT LAST_NAME FROM emp_basic WHERE LAST_NAME like 'H%';
SELECT first_name, last_name, DATEADD('day',90,start_date) FROM emp_basic WHERE start_date <= '2017-01-01';