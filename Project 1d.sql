-- how many wells, taps and riveer are there
SELECT type_of_water_source, COUNT(*) AS number_of_sources
FROM md_water_services.water_source
GROUP BY type_of_water_source
ORDER BY number_of_sources DESC
LIMIT 0, 50000;

-- average people served
SELECT type_of_water_source, 
       ROUND(AVG(number_of_people_served)) AS average_people_per_source
FROM md_water_services.water_source
GROUP BY type_of_water_source
ORDER BY average_people_per_source DESC;

-- calculating the total number of people served by each type of water source
SELECT type_of_water_source, 
       SUM(number_of_people_served) AS total_people_served
FROM md_water_services.water_source
GROUP BY type_of_water_source
ORDER BY total_people_served DESC;

-- calculating %age for each type of water source
SELECT type_of_water_source,
       SUM(number_of_people_served) AS total_people_served,
       ROUND(SUM(number_of_people_served) / (SELECT SUM(number_of_people_served) FROM md_water_services.water_source) * 100, 2) AS percentage_served
FROM md_water_services.water_source
GROUP BY type_of_water_source
ORDER BY total_people_served DESC;

-- using 27 million adjusted population to calculate the total number of people surveyed
SELECT type_of_water_source,
       SUM(number_of_people_served) AS total_people_served,
       ROUND(SUM(number_of_people_served) / 27000000 * 100, 0) AS percentage_served
FROM md_water_services.water_source
GROUP BY type_of_water_source
ORDER BY total_people_served DESC;

--  Ranking based on number of people served by each water source
SELECT
  type_of_water_source,
  SUM(number_of_people_served) AS population_served,
  RANK() OVER (ORDER BY SUM(number_of_people_served) DESC) AS water_source_rank
FROM
  water_source
GROUP BY
  type_of_water_source;

-- Removing tap_in_home from the rank
SELECT
  type_of_water_source,
  SUM(number_of_people_served) AS population_served,
  RANK() OVER (ORDER BY SUM(number_of_people_served) DESC) AS source_rank
FROM
  water_source
WHERE
  type_of_water_source != 'tap_in_home'
GROUP BY
  type_of_water_source;
  
  -- water sources that need to be improved
  SELECT
  source_id,
  type_of_water_source,
  number_of_people_served,
  RANK() OVER (
    PARTITION BY type_of_water_source
    ORDER BY number_of_people_served DESC
  ) AS rank_within_type_of_water_source
FROM
  water_source
WHERE
  type_of_water_source != 'tap_in_home'
ORDER BY
  number_of_people_served DESC;
  
  -- ranking within type to kow most heavily used and mosst improvable source
  SELECT
  source_id,
  type_of_water_source,
  number_of_people_served,
  RANK() OVER (
    PARTITION BY type_of_water_source
    ORDER BY number_of_people_served DESC
  ) AS rank_within_type
FROM
  water_source
WHERE
  type_of_water_source != 'tap_in_home'
ORDER BY
  number_of_people_served DESC;
  
  