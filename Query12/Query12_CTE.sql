--find out the film_rentals
--CTE
WITH film_rentals AS (
  SELECT inventory.film_id, COUNT(*) AS rental_count
  FROM rental
  JOIN inventory ON rental.inventory_id = inventory.inventory_id
  GROUP BY inventory.film_id
)
SELECT f.title, fr.rental_count
FROM film f
JOIN film_rentals fr ON f.film_id = fr.film_id
WHERE fr.rental_count > 1;