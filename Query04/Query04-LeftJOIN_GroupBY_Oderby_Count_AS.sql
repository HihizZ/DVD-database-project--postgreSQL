--SELECT Syntax LEFT Join, GROUP BY, Order by, COUNT, AS 
SELECT c.name, COUNT(f.film_id) AS Total_count
FROM category c
LEFT JOIN film_category fc ON fc.category_id = c.category_id
LEFT JOIN film f ON f.film_id = fc.film_id
GROUP BY c.name
ORDER BY c.name;
