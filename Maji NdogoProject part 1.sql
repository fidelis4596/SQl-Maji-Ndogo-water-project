SET SQL_SAFE_UPDATES = 0;
/* Task 1. Get to Know the Data
Identify how many tables are in the database. 
List all table names using SHOW TABLES. 
View the first five records from each table using SELECT * FROM table LIMIT 5. 
Look at column names and data types in each table
Retriving the first five records from each table */
-- Employee Table
SELECT *
FROM md_water_services.employee
LIMIT 5
;


-- Global water access Table
SELECT *
FROM md_water_services.global_water_access
LIMIT 5
;
-- Location Table
SELECT *
FROM md_water_services.location
LIMIT 5
;
-- Visits Table 
SELECT *
FROM md_water_services.visits
LIMIT 5
;
-- Water Quality Table
SELECT *
FROM md_water_services.water_quality 
LIMIT 5
;
-- Water Source Table
SELECT *
FROM md_water_services.water_source
LIMIT 5
;
-- Well Pollution Table
SELECT *
FROM md_water_services.well_pollution
LIMIT 5
;

/* 2. Explore Water Sources
Identify the table that stores water sources (water_source). 
Retrieve all unique water source types. */

SELECT distinct 
     type_of_water_source
FROM md_water_services.water_source
;

/*3. Unpack the Visits Table
		Identify the visits table
		Retrieve the first few records from the visits table. 
		Write an SQL query to find visits where time_in_queue > 500 minutes. */

SELECT *
FROM md_water_services.visits
WHERE time_in_queue >500
;
--  Get the names of water sources with long queueing time using the water source id we got from the previous
SELECT *
FROM md_water_services.water_source
WHERE source_id IN ('AkKi00881224',
'AkKi00881224','AkKi00881224','AkKi00881224');

/* 4. Assess Water Quality
Identify the water_quality table.
Retrieve records where subjective_quality_score 10 and  visit_count is 2
Identify heavily visited sources with poor or good quality.
*/
SELECT *
FROM md_water_services.water_quality
WHERE subjective_quality_score = 10
AND visit_count = 2
;
/* 5. Investigate pollution issues
Identify the well_pollution table
Identify polluted wells (Biological contamination or Chemical contamination). 
Verify data integrity:
Write a query to find entries where result = 'Clean' but biological > 0.01. */

SELECT *
FROM md_water_services.well_pollution
WHERE results = "clean"
AND biological >0.01
;
/* To find these descriptions, search for the word Clean with additional characters after it. As this is what separates incorrect de-
scriptions from the records that should have "Clean". */

SELECT *
FROM md_water_services.well_pollution
WHERE description LIKE "Clean_%"
;
/*  Looking at the results we can see two different descriptions that we need to fix:
1. All records that mistakenly have Clean Bacteria: E. coli should updated to Bacteria: E. coli
2. All records that mistakenly have Clean Bacteria: Giardia Lamblia should updated to Bacteria: Giardia Lamblia */
UPDATE md_water_services.well_pollution
SET description = 'Bacteria: E. coli'
WHERE description = 'Clean Bacteria: E. coli'
;

UPDATE md_water_services.well_pollution
SET description = 'Bacteria: Giardia Lamblia'
WHERE description = 'Clean Bacteria: Giardia Lamblia'
;
/* The second issue we need to fix is in our results column. We need to update the results column from Clean to
 Contaminated: Biological where the biological column has a value greater than 0.01.*/
 
UPDATE md_water_services.well_pollution
SET results = 'Contaminated: Biological'
WHERE biological >0.01
AND results ='Clean'
;
-- then check if our errors are fixed
SELECT
*
FROM
md_water_services.well_pollution
WHERE
description LIKE "Clean_%"
OR (results = "Clean"
 AND biological > 0.01)
;




