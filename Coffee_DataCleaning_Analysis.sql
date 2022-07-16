/* Cleaning data in sql and Analysis
ICO(international Coffee Org>) domestic consumption table contains coffee consumed in grower countries and 
Consumption data contains importing countries data  */


--------------------------------------------------------------------------------------------------------------------------
-- Dropping empty rows and rows that do not contain country data regarding coffee consumption
SET SQL_SAFE_UPDATES=0;

DELETE FROM Coffee.domestic_consumption a
WHERE
    a.Country IN ('','April group', 'July group', 'October group');
    
-- Checking Coloumn Types 

SELECT DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS
WHERE 
     TABLE_SCHEMA = 'Coffee' AND
     TABLE_NAME   = 'domestic_consumption' AND 
     COLUMN_NAME IN('Country','1990','1996');
-- coloumn Country is in Text, 1990-2019 is in text
----------------------------------------------------------------------------------------------
-- Changing data types Text to double 

ALTER TABLE Coffee.domestic_consumption
MODIFY COLUMN Country VARCHAR(150),
MODIFY COLUMN `1990` DOUBLE,
MODIFY COLUMN `1991` DOUBLE,
MODIFY COLUMN `1992` DOUBLE,
MODIFY COLUMN `1993` DOUBLE,
MODIFY COLUMN `1994` DOUBLE,
MODIFY COLUMN `1995` DOUBLE,
MODIFY COLUMN `1996` DOUBLE,
MODIFY COLUMN `1997` DOUBLE,
MODIFY COLUMN `1998` DOUBLE,
MODIFY COLUMN `1999` DOUBLE,
MODIFY COLUMN `2000` DOUBLE,
MODIFY COLUMN `2001` DOUBLE,
MODIFY COLUMN `2002` DOUBLE,
MODIFY COLUMN `2003` DOUBLE,
MODIFY COLUMN `2004` DOUBLE,
MODIFY COLUMN `2005` DOUBLE,
MODIFY COLUMN `2006` DOUBLE,
MODIFY COLUMN `2007` DOUBLE,
MODIFY COLUMN `2008` DOUBLE,
MODIFY COLUMN `2009` DOUBLE,
MODIFY COLUMN `2010` DOUBLE,
MODIFY COLUMN `2011` DOUBLE,
MODIFY COLUMN `2012` DOUBLE,
MODIFY COLUMN `2013` DOUBLE,
MODIFY COLUMN `2014` DOUBLE,
MODIFY COLUMN `2015` DOUBLE,
MODIFY COLUMN `2016` DOUBLE,
MODIFY COLUMN `2017` DOUBLE,
MODIFY COLUMN `2018` DOUBLE,
MODIFY COLUMN `2019` DOUBLE;
  


SELECT * FROM Coffee.consumption_data;

-- Drop European union and country 
DELETE FROM Coffee.consumption_data b
WHERE
    b.Country IN ('','Country', 'European Union');
    
-- Merge Belgium/luxemburg (a provinvce of Belgium) and Belgium Together.

SELECT * FROM Coffee.consumption_data b
WHERE b.Country LIKE 'Belgium%';
'Belgium/Luxembourg', '1124.11', '708.16', '696.37', '789.44', '958.21', '1073.01', '1038.64', '886.26', '1309.41', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''
'Belgium', '0', '0', '0', '0', '0', '0', '', '', '', '834.49', '1133.36', '884.23', '1484.30', '1579.42', '1396.24', '1158.04', '1537.41', '1103.12', '649.93', '934.29', '870.67', '934.47', '914.64', '1245.16', '1258.94', '1073.61', '1502.12', '1300.05', '1364.93', '1185.38'

DELETE FROM Coffee.consumption_data b
WHERE
    b.Country LIKE 'Belgium%';

INSERT INTO Coffee.consumption_data (Country, `1990`, `1991`, `1992`, `1993`, `1994`, `1995`, `1996`, `1997`, `1998`, `1999`, `2000`, `2001`, `2002`, `2003`, `2004`, `2005`, `2006`, `2007`, `2008`, `2009`, `2010`, `2011`, `2012`, `2013`, `2014`, `2015`, `2016`, `2017`, `2018`, `2019`)
VALUES ('Belgium', '1124.11', '708.16', '696.37', '789.44', '958.21', '1073.01', '1038.64', '886.26', '1309.41','834.49', '1133.36', '884.23', '1484.30', '1579.42', '1396.24', '1158.04', '1537.41', '1103.12', '649.93', '934.29', '870.67', '934.47', '914.64', '1245.16', '1258.94', '1073.61', '1502.12', '1300.05', '1364.93', '1185.38');


-- Setting 0 for the empty values
UPDATE Coffee.consumption_data
SET `1996`=0, `1997`=0, `1998`=0
WHERE Country='Luxembourg';

-- Change United States of America value to United States
UPDATE Coffee.Coffee_consumption_countries
SET Country='United States'
WHERE Country='United States of America';
-- Changing data types 
ALTER TABLE Coffee.consumption_data
MODIFY COLUMN Country VARCHAR(150),
MODIFY COLUMN `1990` DOUBLE,
MODIFY COLUMN `1991` DOUBLE,
MODIFY COLUMN `1992` DOUBLE,
MODIFY COLUMN `1993` DOUBLE,
MODIFY COLUMN `1994` DOUBLE,
MODIFY COLUMN `1995` DOUBLE,
MODIFY COLUMN `1996` DOUBLE,
MODIFY COLUMN `1997` DOUBLE,
MODIFY COLUMN `1998` DOUBLE,
MODIFY COLUMN `1999` DOUBLE,
MODIFY COLUMN `2000` DOUBLE,
MODIFY COLUMN `2001` DOUBLE,
MODIFY COLUMN `2002` DOUBLE,
MODIFY COLUMN `2003` DOUBLE,
MODIFY COLUMN `2004` DOUBLE,
MODIFY COLUMN `2005` DOUBLE,
MODIFY COLUMN `2006` DOUBLE,
MODIFY COLUMN `2007` DOUBLE,
MODIFY COLUMN `2008` DOUBLE,
MODIFY COLUMN `2009` DOUBLE,
MODIFY COLUMN `2010` DOUBLE,
MODIFY COLUMN `2011` DOUBLE,
MODIFY COLUMN `2012` DOUBLE,
MODIFY COLUMN `2013` DOUBLE,
MODIFY COLUMN `2014` DOUBLE,
MODIFY COLUMN `2015` DOUBLE,
MODIFY COLUMN `2016` DOUBLE,
MODIFY COLUMN `2017` DOUBLE,
MODIFY COLUMN `2018` DOUBLE,
MODIFY COLUMN `2019` DOUBLE;

-------------------------------------------------------------------------------------------------
-- Stacking the Domestic Consumption Table(exporting countries) and consumption_data(importing countries)

CREATE TABLE Coffee.consumption 
SELECT 
    *
FROM
    Coffee.consumption_data 
UNION ALL SELECT 
    *
FROM
    Coffee.domestic_consumption;
--------------------------------------------------------------------------------------------------------------------------------------------------

-- Unpivoting Yr and consumptions 
-- Unfortunately Mysql version don't have unpivot function, so I used union all to unpivot
----------------------------------------------------------------------------------------------------------------------------
CREATE TABLE Coffee.Coffee_consumption_countries
SELECT Country, '1990' Yr, `1990` Consumed_thousands_60Kg_bags
FROM Coffee.consumption 
union all
SELECT Country, '1991' Yr, `1991` Consumed_thousands_60Kg_bags
FROM Coffee.consumption
Union all
SELECT a.Country, '1992' Yr, `1992` Consumed_thousands_60Kg_bags
FROM Coffee.consumption a
UNION ALL
SELECT a.Country, '1993' Yr, `1993` Consumed_thousands_60Kg_bags
FROM Coffee.consumption a
UNION ALL
SELECT a.Country, '1994' Yr, `1994` Consumed_thousands_60Kg_bags
FROM Coffee.consumption a
UNION ALL 
SELECT a.Country, '1995' Yr, `1995` Consumed_thousands_60Kg_bags
FROM Coffee.consumption a
UNION ALL 
SELECT a.Country, '1996' Yr, `1996` Consumed_thousands_60Kg_bags
FROM Coffee.consumption a
UNION ALL
SELECT a.Country, '1997' Yr, `1997` Consumed_thousands_60Kg_bags
FROM Coffee.consumption a
UNION ALL
SELECT a.Country, '1998' Yr, `1998` Consumed_thousands_60Kg_bags
FROM Coffee.consumption a
UNION ALL
SELECT a.Country, '1999' Yr, `1999` Consumed_thousands_60Kg_bags
FROM Coffee.consumption a
UNION ALL
SELECT a.Country, '2000' Yr, `2000` Consumed_thousands_60Kg_bags
FROM Coffee.consumption a
UNION ALL
SELECT a.Country, '2001' Yr, `2001` Consumed_thousands_60Kg_bags
FROM Coffee.consumption a
UNION ALL
SELECT a.Country, '2002' Yr, `2002` Consumed_thousands_60Kg_bags
FROM Coffee.consumption a
UNION ALL
SELECT a.Country, '2003' Yr, `2003` Consumed_thousands_60Kg_bags
FROM Coffee.consumption a
UNION ALL
SELECT a.Country, '2004' Yr, `2004` Consumed_thousands_60Kg_bags
FROM Coffee.consumption a
UNION ALL
SELECT a.Country, '2005' Yr, `2005` Consumed_thousands_60Kg_bags
FROM Coffee.consumption a
UNION ALL
SELECT a.Country, '2006' Yr, `2006` Consumed_thousands_60Kg_bags
FROM Coffee.consumption a
UNION ALL
SELECT a.Country, '2007' Yr, `2007` Consumed_thousands_60Kg_bags
FROM Coffee.consumption a
UNION ALL
SELECT a.Country, '2008' Yr, `2008` Consumed_thousands_60Kg_bags
FROM Coffee.consumption a
UNION ALL
SELECT a.Country, '2009' Yr, `2009` Consumed_thousands_60Kg_bags
FROM Coffee.consumption a
UNION ALL
SELECT a.Country, '2010' Yr, `2010` Consumed_thousands_60Kg_bags
FROM Coffee.consumption a
UNION ALL
SELECT a.Country, '2011' Yr, `2011` Consumed_thousands_60Kg_bags
FROM Coffee.consumption a
UNION ALL
SELECT a.Country, '2012' Yr, `2012` Consumed_thousands_60Kg_bags
FROM Coffee.consumption a
UNION ALL
SELECT a.Country, '2013' Yr, `2013` Consumed_thousands_60Kg_bags
FROM Coffee.consumption a
UNION ALL
SELECT a.Country, '2014' Yr, `2014` Consumed_thousands_60Kg_bags
FROM Coffee.consumption a
UNION ALL
SELECT a.Country, '2015' Yr, `2015` Consumed_thousands_60Kg_bags
FROM Coffee.consumption a
UNION ALL
SELECT a.Country, '2016' Yr, `2016` Consumed_thousands_60Kg_bags
FROM Coffee.consumption a
UNION ALL
SELECT a.Country, '2017' Yr, `2017` Consumed_thousands_60Kg_bags
FROM Coffee.consumption a
UNION ALL
SELECT a.Country, '2018' Yr, `2018` Consumed_thousands_60Kg_bags
FROM Coffee.consumption a
UNION ALL
SELECT a.Country, '2019' Yr, `2019` Consumed_thousands_60Kg_bags
FROM Coffee.consumption a;

SELECT * FROM Coffee.Coffee_consumption_countries;


-----------------------------------------------------------------------------------------------------------------------------------
-- Polulation_cleaned contains population data 

SELECT * FROM Coffee.Population_cleaned
WHERE Year=2011;

/*  Joining Coffee consumption table with population table.

Conversion unit:

Consumed_thousands_60Kg_bags to cups_consumed with the following equation:
Cups_consumed= Consumed_thousands_60Kg_bags * 1000 * 60*1000) / 10 [ ~10 grams coffee needed to make a cup of coffee]
Cups_consumed_per_capita = Cups_consumed/ population

*/
CREATE TABLE coffee_clean
SELECT 
    b.Country,
    a.Yr as Year,
    b.Population,
    a.Consumed_thousands_60Kg_bags,
    (Consumed_thousands_60Kg_bags * 1000 * 60*1000) / 10 AS Cups_consumed,
    (Consumed_thousands_60Kg_bags * 1000 * 60*1000) / (10 * b.Population) AS Cups_consumed_per_capita,
    b.median_age AS Median_age, 
    b.fertility_rate AS Fertality_rate,
    b.urban_pop_percent As Urban_population_percent
FROM
    Coffee.Coffee_consumption_countries a
       LEFT JOIN
    Coffee.population_cleaned b 
    ON a.Yr = b.Year AND a.Country = b.Country
    UNION ALL
   SELECT 
    b.Country,
    a.Yr as Year,
    b.Population,
    a.Consumed_thousands_60Kg_bags,
    (Consumed_thousands_60Kg_bags * 1000 * 60*1000) / 10 AS Cups_consumed,
    (Consumed_thousands_60Kg_bags * 1000 * 60*1000) / (10 * b.Population) AS Cups_consumed_per_capita,
    b.median_age AS Median_age, 
    b.fertility_rate AS Fertality_rate,
    b.urban_pop_percent As Urban_population_percent
FROM
    Coffee.Coffee_consumption_countries a
       LEFT JOIN
    Coffee.population_cleaned b 
    ON a.Yr = b.Year AND a.Country = b.Country;


SELECT Country, Cups_consumed
FROM coffee_clean
ORDER BY 2 DESC;

--------------------------------------------------------------------------------------------------------------------------------------------
/* Analysis */

-- Which year total coffee consumption is highest?
SELECT DISTINCT(Year), sum(Consumed_thousands_60Kg_bags) over (Partition By Year) as total
FROM coffee_clean
Order By 2 DESC
LIMIT 5;


-- What are the most coffee consumed countries?
CREATE TEMPORARY TABLE top_consumed_countries
SELECT 
    Country, Cups_consumed as Yearly_total_Cups_Consumeed, Cups_consumed_per_capita/365 as Daily_cups_per_person
FROM
    coffee_clean
WHERE
    Year = 2019
ORDER BY Cups_consumed DESC
LIMIT 5;




-- What are the countries where people drink the most cups of coffee in the most recent year?
CREATE TEMPORARY TABLE top_consumed_countries_perCapita
SELECT Country, Cups_consumed_per_capita/365 as Daily_Cups_Consumed_Per_Capita
FROM coffee_clean
WHERE Year= 2019
ORDER BY Cups_consumed_per_capita DESC
LIMIT 5;



-- The average median age of people at the top consumption countries and top consumption per capita?

SELECT avg(Median_age)
FROM coffee_clean 
WHERE Country in (SELECT Country FROM top_consumed_countries_perCapita
) and Year=2019;

-- 40.78 

SELECT avg(Urban_population_percent)
FROM coffee_clean 
WHERE Country in (SELECT Country FROM top_consumed_countries_perCapita
) and Year=2019;

-- 86.6%

-- The average median age of people at the top consumption countries and top consumption countries?
SELECT avg(Median_age)
FROM coffee_clean 
WHERE Country in (SELECT Country FROM top_consumed_countries
) and Year=2019;

-- 40.72

SELECT avg(Urban_population_percent)
FROM coffee_clean 
WHERE Country in (SELECT Country FROM top_consumed_countries
) and Year=2019;

-- 83.8%

 
 -- which countries consumption has increased or on the rise?
 
 SELECT 
    curr.Country,
    ((curr.cups_consumed - pre.cups_consumed) / pre.cups_consumed) * 100 AS percent_increased
FROM
    coffee_clean curr
        JOIN
    coffee_clean pre ON curr.Year = 2019 AND pre.Year = 2015
        AND curr.Country = pre.Country
ORDER BY percent_increased DESC;


