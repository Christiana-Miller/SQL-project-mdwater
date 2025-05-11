-- top 3 employee_ids with the highest number of locations visited
SELECT * FROM md_water_services.employee;
SELECT assigned_employee_id, COUNT(*) AS total_visits
FROM md_water_services.visits
GROUP BY assigned_employee_id
ORDER BY total_visits DESC
LIMIT 3;

-- employee info for the 3 assigned_employee_ids
SELECT assigned_employee_id, COUNT(*) AS total_visits
FROM md_water_services.visits
GROUP BY assigned_employee_id
ORDER BY total_visits DESC
LIMIT 3;

-- usine the ids to find the names emails and phone numbers
SELECT assigned_employee_id, employee_name, email, phone_number
FROM md_water_services.employee
WHERE assigned_employee_id IN (105, 112, 108);

-- counting number of water sources
SELECT town_name, COUNT(*) AS total_water_sources
FROM md_water_services.location
GROUP BY town_name
ORDER BY total_water_sources DESC;

-- counting records per province
SELECT province_name, COUNT(*) AS total_water_sources
FROM md_water_services.location
GROUP BY province_name
ORDER BY total_water_sources DESC;

-- provinvce name town name, ...
SELECT province_name, town_name, COUNT(*) AS records_per_town
FROM md_water_services.location
GROUP BY province_name, town_name
ORDER BY province_name ASC, records_per_town DESC;

-- looking at records per locatiob type
SELECT location_type, COUNT(*) AS records_per_location_type
FROM md_water_services.location
GROUP BY location_type
ORDER BY records_per_location_type DESC;

-- people surveyed in total
SELECT SUM(number_of_people_served) AS total_people_surveyed
FROM md_water_services.water_source;
