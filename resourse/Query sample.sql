SELECT*FROM actor;

SELECT first_name FROM actor
WHERE first_name = 'Penelope';

SELECT * FROM actor
WHERE actor_id = 23;

SELECT * FROM payment
WHERE amount = 11;

SELECT * FROM payment
WHERE amount > 11;

SELECT * FROM payment
WHERE amount < 11;

SELECT * FROM payment
WHERE amount >= 11;

SELECT * FROM payment
WHERE amount <= 7.99;

SELECT * FROM payment
WHERE amount <> 7.99;

SELECT * FROM payment
WHERE (customer_id =341) AND amount > 4.99;

SELECT * FROM payment
WHERE (customer_id =341) OR (customer_id =342);


SELECT * FROM payment
WHERE (customer_id =341) OR (customer_id =342) OR (customer_id =347);

SELECT * FROM payment
WHERE amount BETWEEN.99 and 2;

SELECT * FROM payment
WHERE customer_id IN (343,346,349,402);

SELECT * FROM payment
WHERE customer_id IN (SELECT customer_id FROM rental WHERE staff_id =2);

SELECT * FROM payment
WHERE ALL (customer_id > 400, rental_id = 1840, amount > 8.99);

SELECT * FROM actor
WHERE LENGTH(first_name) > ALL(select LENGTH(first_name) from actor);

SELECT first_name FROM actor
ORDER BY LENGTH(first_name) desc;

SELECT * FROM customer c
WHERE LENGTH(c.first_name) > ALL(SELECT LENGTH(first_name) from actor);

SELECT MAX(LENGTH(first_name))FROM customer

SELECT * FROM actor
WHERE NOT first_name LIKE 'P%';

SELECT * FROM actor
WHERE first_name LIKE '__';

SELECT * FROM actor
WHERE first_name LIKE 'E%';

--ascending =ASC
SELECT * FROM actor
WHERE LENGTH(first_name) > ANY(select LENGTH(first_name) from actor)
ORDER BY LENGTH(first_name) asc;

SELECT customer_id, first_name, last_name
FROM customer c
WHERE EXISTS (
    SELECT 1
    FROM rental r, customer
    WHERE r.customer_id = c.customer_id
    AND r.return_date IS NULL
);

SELECT * FROM film
WHERE description LIKE '%Cat%' OR description LIKE '%cat%';

SELECT * FROM film
WHERE description LIKE '%Epic%';

SELECT * FROM film
WHERE description LIKE '%Epic%' or description LIKE '%Fateful%'
LIMIT 10

SELECT DISTINCT customer_id FROM rental
ORDER by customer_id;


--
SELECT c.customer_id, c.first_name, c.last_name, p.amount
FROM customer c
INNER JOIN payment p ON c.customer_id = p.customer_id;

SELECT c.customer_id, c.first_name, c.last_name, p.amount
FROM customer c
LEFT JOIN payment p ON c.customer_id = p.customer_id;

SELECT c.customer_id, c.first_name, c.last_name, p.amount
FROM customer c
RIGHT JOIN payment p ON c.customer_id = p.customer_id;

SELECT c.customer_id, c.first_name, c.last_name, p.amount
FROM customer c
FULL OUTER JOIN payment p ON c.customer_id = p.customer_id;

--(For completeness)
--You could also query the (SQL-standard) information schema:
--http://www.postgresql.org/docs/current/static/information-schema.html
SELECT
    table_schema || '.' || table_name
FROM
    information_schema.tables
WHERE
    table_type = 'BASE TABLE'
AND
    table_schema NOT IN ('pg_catalog', 'information_schema');
	
--show all database table schema
select * from information_schema.tables where table_schema='public';

--The system tables live in the pg_catalog database.
SELECT * FROM pg_catalog.pg_tables;