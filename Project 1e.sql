SELECT * FROM md_water_services.visits;
-- checking how long the entire survey took
SELECT 
  MIN(time_of_record) AS survey_start,
  MAX(time_of_record) AS survey_end,
  MAX(time_of_record) - MIN(time_of_record) AS duration
FROM 
  visits;
  
  -- how long the survey took in days
  SELECT 
  MIN(time_of_record) AS start_date,
  MAX(time_of_record) AS end_date,
  DATEDIFF(MAX(time_of_record), MIN(time_of_record)) AS survey_duration_days
FROM 
  visits;
  
  -- average total queue time for water
  SELECT 
  ROUND(AVG(time_in_queue), 2) AS average_queue_time_minutes
FROM 
  visits;
  
  -- average queue time on different days
  SELECT 
  DAYNAME(time_of_record) AS day_of_week,
  ROUND(AVG(time_in_queue), 2) AS average_queue_time_minutes
FROM 
  visits
GROUP BY 
  DAYNAME(time_of_record)
ORDER BY 
  average_queue_time_minutes DESC;
  
  -- checking how long people have to queue on average
  SELECT 
  ROUND(AVG(NULLIF(time_in_queue, 0)), 2) AS average_queue_time_minutes
FROM 
  visits;
  
  -- average queue time in minutes grouped by days of the week
  SELECT 
  DAYNAME(time_of_record) AS day_of_week,
  ROUND(AVG(NULLIF(time_in_queue, 0)), 0) AS average_queue_time_minutes
FROM 
  visits
GROUP BY 
  DAYNAME(time_of_record)
ORDER BY 
  average_queue_time_minutes DESC;
  
  -- time during the day that people queue longest for water
    SELECT 
  HOUR(time_of_record) AS hour_of_day,
  ROUND(AVG(NULLIF(time_in_queue, 0)), 0) AS average_queue_time_minutes
FROM 
  visits
GROUP BY 
  HOUR(time_of_record)
ORDER BY 
  hour_of_day;
  
  -- formatting time format for easy interpretation
  SELECT 
  TIME_FORMAT(TIME(time_of_record), '%H:00') AS hour_of_day,
  ROUND(AVG(NULLIF(time_in_queue, 0)), 0) AS average_queue_time_minutes
FROM 
  visits
GROUP BY 
  TIME_FORMAT(TIME(time_of_record), '%H:00')
ORDER BY 
  hour_of_day;
  
  -- average queue time per hour for each day
  SELECT
  TIME_FORMAT(TIME(time_of_record), '%H:00') AS hour_of_day,
  ROUND(AVG(CASE WHEN DAYNAME(time_of_record) = 'Sunday' THEN NULLIF(time_in_queue, 0) END)) AS Sunday,
  ROUND(AVG(CASE WHEN DAYNAME(time_of_record) = 'Monday' THEN NULLIF(time_in_queue, 0) END)) AS Monday,
  ROUND(AVG(CASE WHEN DAYNAME(time_of_record) = 'Tuesday' THEN NULLIF(time_in_queue, 0) END)) AS Tuesday,
  ROUND(AVG(CASE WHEN DAYNAME(time_of_record) = 'Wednesday' THEN NULLIF(time_in_queue, 0) END)) AS Wednesday,
  ROUND(AVG(CASE WHEN DAYNAME(time_of_record) = 'Thursday' THEN NULLIF(time_in_queue, 0) END)) AS Thursday,
  ROUND(AVG(CASE WHEN DAYNAME(time_of_record) = 'Friday' THEN NULLIF(time_in_queue, 0) END)) AS Friday,
  ROUND(AVG(CASE WHEN DAYNAME(time_of_record) = 'Saturday' THEN NULLIF(time_in_queue, 0) END)) AS Saturday
FROM
  visits
WHERE
  time_in_queue != 0
GROUP BY
  hour_of_day
ORDER BY
  hour_of_day;
  
  -- hour of day as rows and each weekday as a column showing average queue time
  SELECT
  TIME_FORMAT(TIME(time_of_record), '%H:00') AS hour_of_day,
  -- Sunday
  ROUND(AVG(CASE WHEN DAYNAME(time_of_record) = 'Sunday' THEN time_in_queue ELSE NULL END), 0) AS Sunday,
  -- Monday
  ROUND(AVG(CASE WHEN DAYNAME(time_of_record) = 'Monday' THEN time_in_queue ELSE NULL END), 0) AS Monday,
  -- Tuesday
  ROUND(AVG(CASE WHEN DAYNAME(time_of_record) = 'Tuesday' THEN time_in_queue ELSE NULL END), 0) AS Tuesday,
  -- Wednesday
  ROUND(AVG(CASE WHEN DAYNAME(time_of_record) = 'Wednesday' THEN time_in_queue ELSE NULL END), 0) AS Wednesday,
  -- Thursday
  ROUND(AVG(CASE WHEN DAYNAME(time_of_record) = 'Thursday' THEN time_in_queue ELSE NULL END), 0) AS Thursday,
  -- Friday
  ROUND(AVG(CASE WHEN DAYNAME(time_of_record) = 'Friday' THEN time_in_queue ELSE NULL END), 0) AS Friday,
  -- Saturday
  ROUND(AVG(CASE WHEN DAYNAME(time_of_record) = 'Saturday' THEN time_in_queue ELSE NULL END), 0) AS Saturday
FROM
  visits
WHERE
  time_in_queue != 0
GROUP BY
  hour_of_day
ORDER BY
  hour_of_day;