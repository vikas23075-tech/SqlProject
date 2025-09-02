# World life expectancy project (Data Cleaning)

select *
from world_life_expectancy;


# Finding Duplicate

select country, year, concat(country, year), count(concat(country, year))
from world_life_expectancy
group by country, year, concat(country, year)
having count(concat(country, year)) > 1;


SELECT *
FROM(
select row_id,
concat(country, year),
ROW_NUMBER() OVER(PARTITION BY concat(country, year) ORDER BY concat(country, year)) AS Row_Num
FROM world_life_expectancy
) AS Row_Table 
WHERE Row_Num > 1
;

DELETE FROM  world_life_expectancy
WHERE 
	row_id IN (
		SELECT row_id
        FROM(
			SELECT row_id,
			concat(country, year),
			ROW_NUMBER() OVER(PARTITION BY concat(country, year) ORDER BY concat(country, year)) AS Row_Num
			FROM world_life_expectancy
        ) AS Row_Table
        WHERE Row_Num > 1
    );



# FILL MISSING DATA IN STATUS COLUMN

SELECT *
FROM world_life_expectancy
WHERE status = '';


SELECT DISTINCT(status)
FROM world_life_expectancy
WHERE status <> '' ;


SELECT DISTINCT(Country)
from world_life_expectancy
WHERE status = 'developing';	



UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.country = t2.country
SET t1.status = 'Developing'
WHERE t1.status = ''
AND t2.status <> ''
AND t2.status = 'Developing'
;


SELECT *
FROM world_life_expectancy
WHERE status = '' ;

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
ON t1.country = t2.country
SET t1.status = 'Developed'
WHERE t1.status = ''
AND t2.status <> ''
AND t2.status = 'Developed';


# fill life expantacny data using avarage of 2 years using self join

select COUNTRY, YEAR, `Life expectancy`
from world_life_expectancy
# WHERE `Life expectancy` = ''
;

select t1.COUNTRY, t1.YEAR, t1.`Life expectancy`, t2.COUNTRY, t2.YEAR, t2.`Life expectancy`,
t3.COUNTRY, t3.YEAR, t3.`Life expectancy`,
ROUND((t2.`Life expectancy` + t3.`Life expectancy`)/2, 1)  -- ADDED LATER FOR AVERAGE CALCULATION
FROM world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.country = t2.country
    AND t1.year = t2.year - 1
JOIN world_life_expectancy t3
	ON t1.country = t3.country
    AND t1.year = t3.year + 1
WHERE t1.`Life expectancy` = '';


-- TIME TO UPDATE

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.country = t2.country
    AND t1.year = t2.year - 1
JOIN world_life_expectancy t3
	ON t1.country = t3.country
    AND t1.year = t3.year + 1
SET t1.`Life expectancy` = ROUND((t2.`Life expectancy` + t3.`Life expectancy`)/2, 1)
WHERE t1.`Life expectancy` = ''
;



