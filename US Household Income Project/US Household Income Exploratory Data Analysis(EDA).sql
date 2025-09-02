-- US Household Income Exploratory Data Analysis(EDA)

SELECT state_name, SUM(ALand), SUM(AWater)
FROM us_household_income
GROUP BY State_Name
ORDER BY 3 DESC;


-- IDENTIFY TOP 10 LARGEST STATES BY LAND

SELECT state_name, SUM(ALand), SUM(AWater)
FROM us_household_income
GROUP BY State_Name
ORDER BY 2 DESC
LIMIT 10;



SELECT *
FROM us_household_income;

SELECT *
FROM us_household_income_statistics;


-- lets join the table

SELECT *
FROM us_household_income u
JOIN us_household_income_statistics us
ON u.id = us.id
WHERE Mean <> 0;


SELECT u.State_Name, County, Type, `Primary`, Mean, Median
FROM us_household_income u
JOIN us_household_income_statistics us
ON u.id = us.id
WHERE Mean <> 0;


-- let's look at the state lvl
-- WHICH SATE HAS THE HIGHER AVG AND LOWER AVG
-- BY STATE WHAT IS THEIR AVG INCOME AND MEDIAN INCOME

SELECT u.State_Name, ROUND(AVG(Mean), 1), ROUND(AVG(Median), 1)
FROM us_household_income u
JOIN us_household_income_statistics us
ON u.id = us.id
WHERE MEAN <> 0
GROUP BY u.State_Name
ORDER BY 2 DESC  -- ORDER BY 3 SHOW US HIGHEST MEDIAN INCOMES
LIMIT 10;


-- BREAKOUT BY TYPE

SELECT Type, COUNT(Type), ROUND(AVG(Mean), 1), ROUND(AVG(Median), 1)
FROM us_household_income u
JOIN us_household_income_statistics us
ON u.id = us.id
WHERE MEAN <> 0
GROUP BY 1
ORDER BY 4 DESC
LIMIT 20;

-- lets chk why avg of communities is low

SELECT *
FROM us_household_income
WHERE TYPE = 'Community';

-- let's filter out lower count type

SELECT Type, COUNT(Type), ROUND(AVG(Mean), 1), ROUND(AVG(Median), 1)
FROM us_household_income u
JOIN us_household_income_statistics us
ON u.id = us.id
WHERE MEAN <> 0
GROUP BY 1
HAVING COUNT(Type) > 100
ORDER BY 4 DESC
LIMIT 20;


-- here we look at state name and city and found some cities that were mqaking crazy amt of money

SELECT u.State_Name, City, ROUND(AVG(Mean) ,1)
FROM us_household_income u
JOIN us_household_income_statistics us
ON u.id = us.id
GROUP BY u.State_Name, City
ORDER BY ROUND(AVG(Mean) ,1) DESC;








