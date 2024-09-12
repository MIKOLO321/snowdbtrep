### Data Types
___
**This section explores the different data types that may be used to store data in
Snowflake.**

* char is used for storing a single character.
* nchar  is used to store a fixed-length of data in a column 
* nchar varying has a variable length.
* nvarchar and nvarchar2 are primarily used to represent strings
* string is a fixed-length character data type.


**When providing values for character columns, you will need to use single quotes as
delimiters:**

```sql
select 'here is a string' as output_string
| OUTPUT_STRING   |
|-----------------|  
| here is a string|
```
 

If your string contains a single quote (usually as an apostrophe), you can use two sin‐
gle quotes together to tell Snowflake that it hasn’t reached the end of the string, eaxample


```sql
select 'you haven''t reached the end yet' as output_string;
+---------------------------------+
| OUTPUT_STRING                   |
|---------------------------------|
| you haven't reached the end yet |
+---------------------------------+
```


### Numeric Data
Similar to character data, Snowflake has a single data type called number that will han‐
dle just about any type of numeric data.

1. decimal, numeric stores numbers with decimals
2.  * If your values are small: Use tinyint or smallint.
    * If your values are medium: Use int or integer.
    * If your values are large: Use bigint.

    Example:
    **-- Create a table with integer columns of different sizes**
    
```sql
CREATE TABLE numbers (
    tinyint_column TINYINT,
    smallint_column SMALLINT,
    int_column INT,
    bigint_column BIGINT
);
-- Insert values into the table
INSERT INTO numbers VALUES
(10, 100, 1000, 1000000);
````


3. double, float, float4, float8
**Double** is equivalent to **float8**. It is a 64-bit floating-point data type.

   **Float** is equivalent to **float4**. It is a 32-bit floating-point data type.
   Example:
   
   ** Create a table with floating-point columns**
```sql

-- Create a table with floating-point columns
CREATE TABLE numbers (
    double_column DOUBLE,
    float_column FLOAT
);
-- Insert values into the table
INSERT INTO numbers VALUES
(123.456789012345, 123.456789);

```
```
### Temporal Data
**Temporal data mostly holds information about dates and/or times.**
 1. timestamp_ntz
    No specific time zone
 2. timestamp_ltz
    Uses current session’s time zone
 3. timestamp_tz
    Allows time zone to be specified

**Timestamps** are a combination of date and time and come in three flavors:

To know default time zone:
```sql
show parameters like 'timez%';
PUBLIC>show parameters like 'timez%';

| key         | value               | default             |
|----------+---------------------+-------------------------
| TIMEZONE    | America/Los_Angeles | America/Los_Angeles |
```

**To know the default format for date:**

```sql
show parameters like 'date_output%';
PUBLIC>show parameters like 'date_output%';
+--------------------+------------+------------+-------+...
| key                | value      | default    | level |
|--------------------+------------+------------+-------+...
| DATE_OUTPUT_FORMAT | YYYY-MM-DD | YYYY-MM-DD |       |
+--------------------+------------+------------+-------+...
 ```

 **If you’d prefer a different format, you can change the value of date_output_format in your session:**
```sql
PUBLIC>alter session set date_output_format='MM/DD/YYYY';
+----------------------------------+
| status                           |
|----------------------------------|
| Statement executed successfully. |
+----------------------------------+
PUBLIC>select current_date;
+--------------+
| CURRENT_DATE |
|--------------|
| 10/24/2022   |
+--------------```
```

 **Here’s a query that returns the current date, time, and timestamp using some of
Snowflake’s built-in functions:**
```sql
PUBLIC>select current_date, current_time, current_timestamp;
+--------------+--------------+-------------------------------+
| CURRENT_DATE | CURRENT_TIME | CURRENT_TIMESTAMP             |
|--------------+--------------+-------------------------------|
| 2022-10-12   | 12:59:41     | 2022-10-12 12:59:41.598 -0400 |
+--------------+--------------+-------------------------------```
```

### Variant
Variant can hold any type of data. Example:
```sql
select 1::variant, 'abc'::variant, current_date::variant;
+------------+----------------+-----------------------+
| 1::VARIANT | 'ABC'::VARIANT | CURRENT_DATE::VARIANT |
|------------+----------------+-----------------------|
| 1          | "abc"          | "2022-10-13"          |
+------------+----------------+-----------------------+
```

**Snowflake provides the built-in function typeof() to tell you what type of data is
being stored:**
```sql
PUBLIC>select typeof('this is a character string'::variant);
+-----------------------------------------------+ 
| TYPEOF('THIS IS A CHARACTER STRING'::VARIANT) |
|-----------------------------------------------|
| VARCHAR                                       |
+-----------------------------------------------+
PUBLIC>select typeof(false::variant);
+------------------------+ 
| TYPEOF(FALSE::VARIANT) |
|------------------------|
| BOOLEAN                |
+------------------------+
PUBLIC>select typeof(current_timestamp::variant);
+------------------------------------+ 
| TYPEOF(CURRENT_TIMESTAMP::VARIANT) |
|------------------------------------|
| TIMESTAMP_LTZ                      |
+------------------------------------+
```

### Array
  It contains a list of elements that returns a single row in a column. Example:

  ```sql
  PUBLIC>select [123, 'ABC', current_time] as my_array;
| MY_ARRAY                 |
|--------------------------|
| [123, "ABC", "10:27:33" ]|
```

 **Arrays** can be
flattened into X rows (X = 3 in this case) by using a combination of the table() and
flatten() functions:
```sql
PUBLIC>select value
 from table(flatten(input=>[123, 'ABC', current_time]));

| VALUE      |
|------------|
| 123        |
| "ABC"      |
| "10:29:25" |
```


 ### Object
Snowflake’s object type stores an array of key-value pairs. Objected are created using curly braces ({and})  and keys are separated from values using colons. Example

```sql
PUBLIC>select {'new_years' : '01/01', 
 'independence_day' : '07/04',
 'christmas' : '12/25'}
 as my_object;
+----------------------------------------------------------------+
| MY_OBJECT                                                      |
|----------------------------------------------------------------|
| {                                                              |
| "christmas": "12/25", "independence_day":"new_years": "01/01"  |
+----------------------------------------------------------------| 
```

 **But you can use the flatten() and table() functions to transform this result set into three
rows, each having a key and value column:**

```sql
public>select key, value
 from table(flatten(
 {'new_years' : '01/01', 
 'independence_day' : '07/04',
 'christmas' : '12/25'}));
| KEY              | VALUE   |              |
|------------------+---------|
| christmas        | "12/25" |
| independence_day | "07/04" |
| new_years        | "01/01" |
```

### Creating Tables

```sql
create table person
 (first_name varchar(50),
 last_name varchar(50),
 birth_date date,
 eye_color varchar(10),
 occupation varchar(50),
 children array,
 years_of_education number(2,0)
 );
insert into person 
 (first_name, last_name, birth_date,
 eye_color, occupation, years_of_education)
 values
 ('Bob','Smith','22-JAN-2000','brown','teacher', 18),
 ('Gina','Peters','03-MAR-2001','green','student', 12),
 ('Tim','Carpenter','09-JUL-2002','blue','salesman', 16),
 ('Kathy','Little','29-AUG-2001','brown','professor', 20),
 ('Sam','Jacobs','13-FEB-2003','blue','lawyer', 18);
 ```

   ### Deleting Data

 Deleting Data
There are now six rows in the Person table:
```sql
PUBLIC>select first_name, last_name
 from person;
+------------+-----------+
| FIRST_NAME | LAST_NAME |
|------------+-----------|
| Bob        | Smith     |
| Gina       | Peters    |
| Tim        | Carpenter |
| Kathy      | Little    |
| Sam        | Jacobs    |
| Sharon     | Carpenter |
+------------+-----------+
```
**Delete function:**

If you’d like to remove Sam Jacobs from the table, you can execute a delete statement
using a where clause to specify the row(s) to be removed:
```sql
PUBLIC>delete from person
 where first_name = 'Sam' and last_name = 'Jacobs';
+------------------------+ 
| number of rows deleted |
|------------------------|
| 1                      |
+------------------------
```


 ### Modifying Data
 **Update function:**
```sql
PUBLIC>update person
set occupation = 'musician', eye_color = 'grey'
 where first_name = 'Kathy' and last_name = 'Little';
+------------------------+-------------------------------------+
| number of rows updated | number of multi-joined rows updated |
|------------------------+-------------------------------------|
| 1                      | 0           
+------------------------+-------------------------------------
```
**Insert function:** 
We can insert  another row into the table. Example
```sql
 insert into person (first_name, last_name, birth_date,
 eye_color, occupation, years_of_education)
 values ('Bob','Smith','22-JAN-2000','blue','teacher', 18);
 +-------------------------+
| number of rows inserted |
|-------------------------|
| 1                       |
+-------------------------+
```


 ### Merging Data
Now that you understand how to use the insert, delete, and update functions, let’s
look at how you can do all three operations in a single statement.

```sql
PUBLIC>create table person_refresh as
 select *
 from (values 
 ('Bob','Smith','no','22-JAN-2000','blue','manager'),
 ('Gina','Peters','no','03-MAR-2001','brown','student'),
 ('Tim','Carpenter','no','09-JUL-2002','green','salesman'),
 ('Carl','Langford','no','16-JUN-2001','blue','tailor'),
 ('Sharon','Carpenter','yes',null,null,null),
 ('Kathy','Little','yes',null,null,null))
 as hr_list (fname, lname, remove, dob, eyes, profession);

 +--------------------------------------------+
| status                                     |
|--------------------------------------------|
| Table PERSON_REFRESH successfully created. |
+--------------------------------------------+

PUBLIC>select * from person_refresh;
+--------+-----------+--------+-------------+-------+------------+
| FNAME  | LNAME     | REMOVE     | DOB         | EYES  | PROFESSION |
|--------+-----------+--------+-------------+-------+----------------|
| Bob    | Smith     | no         | 22-JAN-2000 | blue  | manager    |
| Gina   | Peters    | no         | 03-MAR-2001 | brown | student    |
| Tim    | Carpenter | no         | 09-JUL-2002 | green | salesman   |
| Carl   | Langford  | no         | 16-JUN-2001 | blue  | tailor     |
| Sharon | Carpenter | yes        | NULL        | NULL  | NULL       |
| Kathy  | Little    | yes        | NULL        | NULL  | NULL       |
+--------+-----------+--------+-------------+-------+----------------+
 ```









 




















