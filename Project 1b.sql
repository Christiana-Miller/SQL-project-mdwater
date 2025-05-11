SELECT email, COUNT(*) AS count
FROM md_water_services.employee
WHERE email IS NOT NULL AND email != ''
GROUP BY email
HAVING COUNT(*) > 1;

-- PHONE NUMBER CLEANING
SELECT employee_name, email 
FROM md_water_services.employee;

-- checking length of phone number 
SELECT employee_name, phone_number, LENGTH(phone_number) AS phone_number_length
FROM md_water_services.employee;

-- trimming phone number lengths
SELECT 
    employee_name,
    phone_number,
    LENGTH(phone_number) AS original_length,
    LENGTH(TRIM(phone_number)) AS trimmed_length
FROM md_water_services.employee;

-- Disabling safe update mode
SET SQL_SAFE_UPDATES = 0;

-- removing leading or trailing spaces from phone number
UPDATE md_water_services.employee
SET phone_number = TRIM(phone_number)
WHERE phone_number IS NOT NULL;

SELECT assigned_employee_id, employee_name, phone_number, 
       TRIM(phone_number) AS trimmed_number,
       LENGTH(TRIM(phone_number)) AS trimmed_length
FROM md_water_services.employee
WHERE TRIM(phone_number) NOT LIKE '+99%' 
   OR LENGTH(TRIM(phone_number)) != 12;
 
-- Honouring workers
-- Checking number of employees per town
SELECT town_name, COUNT(*) AS no_of_employees_per_town
FROM md_water_services.employee
GROUP BY town_name

