### Data Types
___
This section explores the different data types that may be used to store data in
Snowflake.

• char, character, char varying
• nchar, nchar varying
• nvarchar, nvarchar2
• string, text

When providing values for character columns, you will need to use single quotes as
delimiters:

```select 'here is a string' as output_string```
 

If your string contains a single quote (usually as an apostrophe), you can use two sin‐
gle quotes together to tell Snowflake that it hasn’t reached the end of the string, as in:


```select 'you haven''t reached the end yet' as output_string;```


### Numeric Data
Similar to character data, Snowflake has a single data type called number that will han‐
dle just about any type of numeric data.

• decimal, numeric, real
• tinyint, smallint, int, integer, bigint
• double, float, float4, float8


### Temporal Data
**Temporal data mostly holds information about dates and/or times.**
 1. timestamp_ntz
    No specific time zone
 2. timestamp_ltz
    Uses current session’s time zone
 3. timestamp_tz
    Allows time zone to be specified

**Timestamps** are a combination of date and time and come in three flavors:

```select current_date, current_time, current_timestamp```

To know default time zone:
```show parameters like 'timez%';```

The default format for date:
```show parameters like 'date_output%'; ```

To change your date format:
***alter session set date_output_format='MM/DD/YYYY'
select current_date;***


### Variant
Variant can hold any type of data. Example
```select 1::variant, 'abc'::variant, current_date::variant;```



If you are inserting values into a variant column, you can use the :: operator to cast a
string, number, date, etc., to a variant type, as in:
```select 1::variant, 'abc'::variant, current_date::variant;```

Snowflake provides the built-in function typeof() to tell you what type of data is
being stored:
```select typeof('this is a character string'::variant)```

```select typeof(false::variant);```

```select typeof(current_timestamp::variant);```


### Array
  It contains a list of elements that returns a single row in a column. Example

  ```select [123, 'ABC', current_time] as my_array;```

**Arrays** can be
flattened into X rows (X = 3 in this case) by using a combination of the table() and
flatten() functions:

 **select value
 from table(flatten(input=>[123, 'ABC', current_time])**

 ### Object
Snowflake’s object type stores an array of key-value pairs. Objected are created using curly braces ({and})  and keys are separated from values using colons. Example

***select {'new_years' : '01/01', 
 'independence_day' : '07/04',
 'christmas' : '12/25'} as my_object***

 But you can use the flatten() and table() functions to transform this result set into three
rows, each having a key and value column:

***select key, value
 from table(flatten(
 {'new_years' : '01/01', 
 'independence_day' : '07/04',
 'christmas' : '12/25'}));***

### Creating Tables

***create table person1
 (first_name varchar(50),
 last_name varchar(50),
 birth_date date,
 eye_color varchar(10),
 occupation varchar(50),
 children array,
 years_of_education number(2,0)
 );***


***insert into person 
 (first_name, last_name, birth_date,
 eye_color, occupation, years_of_education)
 values
 ('Bob','Smith','22-JAN-2000','brown','teacher', 18),
 ('Gina','Peters','03-MAR-2001','green','student', 12),
 ('Tim','Carpenter','09-JUL-2002','blue','salesman', 16),
 ('Kathy','Little','29-AUG-2001','brown','professor', 20),
 ('Sam','Jacobs','13-FEB-2003','blue','lawyer', 18);***

   ### Deleting Data

 ***delete from person
 where first_name = 'Sam' and last_name = 'Jacobs';***


 ### Modifying Data

***update person
 set occupation = 'musician', eye_color = 'grey'
 where first_name = 'Kathy' and last_name = 'Little'***


 **Insert** into person (first_name, last_name, birth_date,
 eye_color, occupation, years_of_education)
 values ('Bob','Smith','22-JAN-2000','blue','teacher', 18);


 ### Merging Data
Now that you understand how to use the insert, delete, and update statements, let’s
look at how you can do all three operations in a single statement.

***create table person_refresh as
 select *
 from (values 
 ('Bob','Smith','no','22-JAN-2000','blue','manager'),
 ('Gina','Peters','no','03-MAR-2001','brown','student'),
 ('Tim','Carpenter','no','09-JUL-2002','green','salesman'),
 ('Carl','Langford','no','16-JUN-2001','blue','tailor'),
 ('Sharon','Carpenter','yes',null,null,null),
 ('Kathy','Little','yes',null,null,null))
 as hr_list (fname, lname, remove, dob, eyes, profession);***









 




















