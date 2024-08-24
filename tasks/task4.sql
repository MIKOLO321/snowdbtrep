create or replace database mydatabase;

 use schema mydatabase.public;

--Note these commands below creates temporary table
CREATE OR REPLACE TEMPORARY TABLE home_sales (
  city STRING,
  zip STRING,
  state STRING,
  type STRING DEFAULT 'Residential',
  sale_date timestamp_ntz,
  price STRING
  );

create or replace warehouse mywarehouse with
  warehouse_size='X-SMALL'
  auto_suspend = 120
  auto_resume = true
  initially_suspended=true;

use warehouse mywarehouse;

--TYPE = 'JSON' below indicates the source file format type. CSV is the default file format type.
CREATE OR REPLACE FILE FORMAT sf_tut_json_format
  TYPE = JSON;

--Similar to temporary tables, temporary stages below are automatically dropped at the end of the session
  CREATE OR REPLACE TEMPORARY STAGE sf_tut_stage
 FILE_FORMAT = sf_tut_json_format;


--Execute the PUT command to upload the JSON file from your local file system to the named stage.
 PUT file:////workspaces/snowdbtrep/sales.json @sf_tut_stage AUTO_COMPRESS=TRUE;
 

 --Load the sales.json.gz staged data file into the home_sales table.
 COPY INTO home_sales(city, state, zip, sale_date, price)
   FROM (SELECT SUBSTR($1:location.state_city,4),
                SUBSTR($1:location.state_city,1,2),
                $1:location.zip,
                to_timestamp_ntz($1:sale_date),
                $1:price
         FROM @sf_tut_stage/sales.json.gz t)
   ON_ERROR = 'continue';

 
select * from   MYDATABASE.PUBLIC.HOME_SALES;








