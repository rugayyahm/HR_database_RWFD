-- ------------------------------------------------------------------------------------------------------------------------ --
-- Data cleaning & manipulating using Human Resource database from Real World Fake Data                                     --
-- Database source: https://data.world/markbradbourne/rwfd-real-world-fake-data/workspace/file?filename=Human+Resources.csv --
-- ------------------------------------------------------------------------------------------------------------------------ --

Create database Humanresource_RWFD;

Use Humanresource_RWFD;

-- create table for the imported csv file

Create table human_resource (
	employee_ID varchar(20),
    first_name varchar(20),
    last_name varchar(20),
    birthdate varchar(20),
    gender varchar(20),
    race varchar(45),
    department varchar(30),
    job_title varchar(40),
    location varchar (20),
    hire_date varchar(20),
    term_date varchar(25),
    city varchar(30),
    state varchar(30)
    );
   
-- check total rows imported

select count(*) as rows_num from human_resource;

-- delete empty rows

delete from human_resource where first_name = '';

-- check again

select * from human_resource limit 10;

-- remember to crosscheck with csv file to ensure no columns are missing
-- import csv data using table wizard
-- time to clean the data

-- change the date format

set sql_safe_updates = 0;
Update human_resource set birthdate = str_to_date(birthdate, '%m/%d/%Y');
Set sql_safe_updates = 1;

-- manipulating empty cells

set sql_safe_updates = 0;
update human_resource set term_date = 0 where term_date = '';
set sql_safe_updates = 1;

-- checking column birthdate data type after update above

show columns from human_resource where field = 'birthdate';

select * from human_resource limit 10;

-- -------------------------------------------------------- --
-- ----------------- EXPLORING OUR DATA ------------------- --
-- -------------------------------------------------------- --

-- check data shape

select count(*) as rows_num from human_resource;

select count(*) as cols_num from information_schema.columns where table_name = 'human_resource';

-- checking distinct values from each columns

select distinct gender from human_resource;

select distinct department from human_resource;

select distinct job_title from human_resource;

select distinct location from human_resource;

select distinct city from human_resource;

select distinct state from human_resource;

-- check the count and percentage from total of each of the distinct values

-- % by gender

select gender, count(*) as no_of_employee, round((count(*)/(select count(*) from human_resource)) *100,1) as pct from human_resource group by 1 order by 3 desc;

-- % by race

select race, count(*) as no_of_employee, round((count(*)/(select count(*) from human_resource)) *100,1) as pct from human_resource group by 1 order by 3;

-- % by location

select location, count(*) as no_of_employee, round((count(*)/(select count(*) from human_resource)) *100,1) as pct from human_resource group by 1 order by 3;
    
-- % by city

select city, count(*) as no_of_employee, round((count(*)/(select count(*) from human_resource)) *100,1) as pct from human_resource group by 1 order by 3 desc;

-- % by state

select state, count(*) as no_of_employee, round((count(*)/(select count(*) from human_resource)) *100,1) as pct from human_resource group by 1 order by 3 desc;

-- ------------------------------------------------------ --
-- ----------- DATA AGGREGATION ------------------------- --
-- ------------------------------------------------------ --

select * from human_resource;

-- city with most employee: Cleveland

select city, count(*) from human_resource group by 1 order by 2 desc;

-- state with most employee: Pennsylvania

select state, count(*) from human_resource group by 1 order by 2 desc;alter

-- youngest/oldest employee

select min(birthdate) as youngest_employee, max(birthdate) as oldest_employee from human_resource;

-- junior/senior employee according to service length

select min(hire_date) as senior_employee, max(hire_date) as junior_employee from human_resource;



