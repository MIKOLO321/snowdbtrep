### Data Types
___
This section explores the different data types that may be used to store data in
Snowflake.

• char, character, char varying
• nchar, nchar varying
• nvarchar, nvarchar2
• string, text

**When providing values for character columns, you will need to use single quotes as
delimiters:**

PUBLIC>select 'here is a string' as output_string
 

**If your string contains a single quote (usually as an apostrophe), you can use two sin‐
gle quotes together to tell Snowflake that it hasn’t reached the end of the string, as in:**

select 'you haven''t reached the end yet' as output_string;


### Numeric Data
Similar to character data, Snowflake has a single data type called number that will han‐
dle just about any type of numeric data.

• decimal, numeric, real
• tinyint, smallint, int, integer, bigint
• double, float, float4, float8


### Temporal Data
Temporal data mostly holds information about dates and/or times. 

**Timestamps** are a combination of date and time and come in three flavors:

select current_date, current_time, current_timestamp

To know default time zone:
```show parameters like 'timez%';```

The default format for date:
```show parameters like 'date_output%'; ```

**To change your date format:**
alter session set date_output_format='MM/DD/YYYY'
select current_date;


### Variant
Variant can hold any type of data. Example

```select 1::variant, 'abc'::variant, current_date::variant;```



If you are inserting values into a variant column, you can use the :: operator to cast a
string, number, date, etc., to a variant type, as in:

```PUBLIC>select 1::variant, 'abc'::variant, current_date::variant;```
















