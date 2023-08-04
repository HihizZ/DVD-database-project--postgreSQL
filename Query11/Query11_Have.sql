--To find the PG rating film revenue
SELECT f.rating, SUM(p.amount) AS total_revenue
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY f.rating
HAVING f.rating::text LIKE 'PG%'
ORDER BY total_revenue DESC;
