-- CREATING EMPLOYEE EMAIL ADDRESSES
-- Checking the format of email addresses before updating it
SELECT employee_name, 
       CONCAT(LOWER(REPLACE(employee_name, ' ', '.')), '@ndogowater.gov') AS email
FROM md_water_services.employee;

-- updating employee table
SET SQL_SAFE_UPDATES = 0;

UPDATE md_water_services.employee
SET email = CONCAT(LOWER(REPLACE(employee_name, ' ', '.')), '@ndogowater.gov')
WHERE email IS NULL;

SET SQL_SAFE_UPDATES = 1;