SELECT c.name, fc.film_id
FROM category c
JOIN film_category fc ON fc.category_id = c.category_id;

SELECT customer_id, first_name, last_name, count(a.address2) As address2  From customer c
JOIN address a ON a.address_id = c.address_id
GROUP BY c.customer_id;

SELECT category_id, COUNT(*) AS category_count
FROM film_category
GROUP BY category_id;


SELECT * FROM film_category;

--show likely phone book
SELECT c.customer_id, c.first_name,c.last_name,a.phone, a.address,a.address_id
FROM customer c
JOIN address a ON c.address_id = a.address_id
ORDER BY customer_id asc;

--2
SELECT * From category c
Join film_category fc On c.category_id = fc.category_id
Join film f on f.film_id = fc.film_id
Order BY length ASC;

--3 no work


SELECT c.name, count(category_id) 
FROM film_category fc
JOIN category c ON fc.category_id = c.category_id
GROUP by category_id;

SELECT category_id, name
FROM category;
ORDER BY category_id asc;

distinct

SELECT category_id, name
FROM category
GROUP BY category_id
ORDER BY category_id asc;

SELECT *FROM film_category;
--4 total row from table
SELECT COUNT(*) FROM film_category;

--5 
SELECT category_id, COUNT(*) AS category_count
FROM film_category fc
Join film f ON f.film_id = fc.film_id
GROUP BY category_id;

SELECT category_id from film_category;

--NATURAL JOIN
WITH film_actor_table as (SELECT film_id,actor_id FROM film_actor)

SELECT * FROM actor
NATURAL JOIN film_actor_table



--CROSS JOIN
SELECT * FROM actor
CROSS JOIN film_actor

WITH film_id_table as (SELECT film_id FROM film_actor)
SELECT * FROM actor
CROSS JOIN film_id_table


--Sub-Query in a SELECT CLAUSE
SELECT customer_id, first_name, last_name,
    (SELECT COUNT(*) FROM rental WHERE rental.customer_id = customer.customer_id) AS rental_count
FROM customer;

--Sub-Query in FROM CLAUSE
SELECT customer_id, rental_count
FROM (
    SELECT customer_id, COUNT(*) AS rental_count
    FROM rental
    GROUP BY customer_id
) AS rental_counts;

--Sub-Query in WHERE CLAUSE
SELECT customer_id, first_name, last_name
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM rental
    WHERE return_date IS NULL
);

--More advanced Group By (EXTRACT,HAVING)
SELECT ct.city, EXTRACT(MONTH FROM p.payment_date) AS month, SUM(p.amount) AS total_payment
FROM payment p
JOIN customer c ON p.customer_id = c.customer_id
JOIN address a ON c.address_id = a.address_id
JOIN city ct ON a.city_id = ct.city_id
GROUP BY ct.city, EXTRACT(MONTH FROM p.payment_date)
HAVING SUM(p.amount) > 31
ORDER BY total_payment DESC;

--Window Functions 
SELECT
  title,
  rental_duration,
  AVG(rental_duration) OVER () AS overall_average, stddev(rental_duration) OVER () AS standard_deviation
FROM film;

SELECT amount, customer_id, 
avg(amount) OVER (PARTITION BY EXTRACT(MONTH FROM payment_date)) as month_average, EXTRACT(month FROM payment_date) as month
FROM payment
ORDER BY month desc;


SELECT amount, customer_id, 
avg(amount) OVER (PARTITION BY EXTRACT(MONTH FROM payment_date)) as month_average, EXTRACT(month FROM payment_date) as month
FROM payment
WHERE EXTRACT(MONTH FROM payment_date) = 3
ORDER BY month desc;


--CTE and corr in month payment amount
WITH revenue_vs_month AS (

SELECT DISTINCT avg(amount) OVER (PARTITION BY EXTRACT(MONTH FROM payment_date)) as month_average, EXTRACT(month FROM payment_date) as month
FROM payment	
)

SELECT corr(month_average, month)
FROM revenue_vs_month;

/*
*/
--
WITH aveage_sd_table as (SELECT title,rental_duration)
AVG (renatl_duration) OVER () AS overall_average, stddev(rental_duration) OVER()AS standard_score 
FROM average_sd_tabble
 
 SELECT title,((rental_duration - overall_average)/standard_deviation)as standard_score
 FROM average_sd_table


--CASE WHEN
SELECT title, rental_duration, rental_rate,
	CASE WHEN rental_duration not in (SELECT rental_rate FROM film) THEN 'True'
		 ELSE 'False'
		 END
	FROM film;