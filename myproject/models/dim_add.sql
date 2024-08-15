
      {{ 
        config(materialized='view')
     }}
 
  
SELECT
{{ dbt_utils.generate_surrogate_key(['a.ADDRESSID']) }} as address_key,

a.city as city, b.name as state_name, c.name as country_name, d.FIRSTNAME
FROM {{ ref("address") }} as a
LEFT JOIN {{ ref("stateprovince") }} as b
ON a.STATEPROVINCEID=b.STATEPROVINCEID
LEFT JOIN {{ ref("countryregion") }} as c
ON b.COUNTRYREGIONCODE=c.COUNTRYREGIONCODE
LEFT JOIN {{ ref("person") }} as d
ON b.STATEPROVINCEID=d.BUSINESSENTITYID 