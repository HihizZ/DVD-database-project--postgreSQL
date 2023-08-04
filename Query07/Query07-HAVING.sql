-- HAVING
SELECT staff.Last_Name, COUNT(rental.rental_ID) AS Number_Of_rental
FROM rental
INNER JOIN staff ON rental.staff_ID = staff.staff_ID
WHERE Last_Name LIKE 'H%' OR Last_Name LIKE '%r'
GROUP BY Last_Name
HAVING COUNT(rental.rental_ID) > 25;

