USE ROLE USERADMIN;

--When a user is granted a role, the user can perform all the operations that the role allows, 
--via the privileges that were granted to the role
CREATE OR REPLACE USER snowman
PASSWORD = 'Westamn12.'
LOGIN_NAME = 'snowstorm'
FIRST_NAME = 'Snow'
LAST_NAME = 'Storm'
EMAIL = 'snow.storm@snowflake.com'
MUST_CHANGE_PASSWORD = true
DEFAULT_WAREHOUSE = COMPUTE_WH;

--Granting a role to another role creates a parent-child relationship between the roles 
--(also referred to as a role hierarchy). Granting a role to a user enables the user to perform all operations
--allowed by the role (through the access privileges granted to the role).
USE ROLE SECURITYADMIN;

GRANT ROLE SYSADMIN TO USER snowman;

GRANT USAGE ON WAREHOUSE COMPUTE_WH TO ROLE SYSADMIN;

USE ROLE ACCOUNTADMIN;

SHOW USERS;

SHOW ROLES;