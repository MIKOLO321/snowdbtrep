
  create or replace   view DBT_BASE.DBT_SCHEMA.dim_add
  
   as (
    
 
  
SELECT
md5(cast(coalesce(cast(a.ADDRESSID as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as address_key,

a.city as city, b.name as state_name, c.name as country_name, d.FIRSTNAME
FROM DBT_BASE.DBT_SCHEMA.address as a
LEFT JOIN DBT_BASE.DBT_SCHEMA.stateprovince as b
ON a.STATEPROVINCEID=b.STATEPROVINCEID
LEFT JOIN DBT_BASE.DBT_SCHEMA.countryregion as c
ON b.COUNTRYREGIONCODE=c.COUNTRYREGIONCODE
LEFT JOIN DBT_BASE.DBT_SCHEMA.person as d
ON b.STATEPROVINCEID=d.BUSINESSENTITYID
  );

