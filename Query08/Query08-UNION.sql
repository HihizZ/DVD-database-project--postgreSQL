--UNION
SELECT 'staff' AS TYPE,first_name, last_name, email
FROM staff
UNION ALL
SELECT 'customer',first_name, last_name, email
FROM customer
ORDER BY first_name, last_name;