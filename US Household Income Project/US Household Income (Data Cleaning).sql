# US HOUSEHOLD INCOME DATA CLEANING

SELECT * 
FROM us_household_income; 


SELECT * 
FROM us_household_income_statistics; 



-- RENAME COLUMN NAME
ALTER TABLE us_household_income_statistics RENAME column `ï»¿id` TO `id`;


-- WE DID COUNT TO CHECK HOW MUCH DATA LOST WHILE IMPORTING TO SQL.

SELECT COUNT(ID)
FROM us_household_income; 


SELECT COUNT(ID)
FROM us_household_income_statistics;



-- FINDIING DUPLICATE

SELECT ID, COUNT(ID)
FROM us_household_income
GROUP BY ID
HAVING COUNT(ID) > 1;


-- WE GONNA USE ROW NUMBER AND PARTITION BY UNDER SUBQUERY TO FILTER OUT THE DUPLICATES

SELECT *
FROM (
SELECT ROW_ID,
ID,
ROW_NUMBER() OVER(PARTITION BY ID ORDER BY ID) row_num
FROM us_household_income
) AS  duplicates
WHERE row_num > 1;


-- DELETE DATA

DELETE FROM us_household_income
WHERE row_id IN (           
	SELECT row_id
	FROM (
		SELECT ROW_ID,
		ID,
		ROW_NUMBER() OVER(PARTITION BY ID ORDER BY ID) row_num
		FROM us_household_income
		) AS  duplicates
WHERE row_num > 1)
;



-- SAME WITH OTHER TABLE

SELECT ID, COUNT(ID)
FROM us_household_income_statistics
GROUP BY ID
HAVING COUNT(ID) > 1;


-- spelling correction in state name column  

SELECT State_Name, count(State_Name)
FROM us_household_income
group by State_Name;


UPDATE us_household_income
set State_Name = 'Georgia'
WHERE State_Name = 'georia';


UPDATE us_household_income
set State_Name = 'Alabama'
WHERE State_Name = 'alabama';   -- or we can use uppercase function


select DISTINCT State_ab
from us_household_income;


-- LET'S CHECK PLACE

select *
from us_household_income
WHERE PLACE  = '';

UPDATE us_household_income
SET Place = 'Autaugaville'
WHERE COUNTY = 'Autauga County'
AND CITY = 'Vinemont';


-- UPDATE TYPE

SELECT TYPE, COUNT(TYPE)
FROM us_household_income
GROUP BY TYPE;


UPDATE us_household_income
SET Type = 'Borough'
WHERE Type = 'Boroughs';


-- update AWater

SELECT ALand, AWater          -- DISTINCT AWater
FROM us_household_income
WHERE AWater = 0 OR AWater = '' OR AWater IS NULL
AND ALand = 0 OR ALand = '' OR ALand IS NULL;

