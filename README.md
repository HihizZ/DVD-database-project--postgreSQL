#  DVD-database-project--postgreSQL

![background](https://github.com/HihizZ/DVD-database-project--postgreSQL/blob/main/resourse/Photo/BG.jpeg)

## System Enviement:
1. PostgreSQL:https://www.postgresql.org/download/
2. Git: https://git-scm.com/
3. Github desktop: https://desktop.github.com/

---

## There are 15 tables in the DVD Rental database:
Database download links :[Download](https://github.com/HihizZ/DVD-database-project--postgreSQL/blob/main/Database%20sourse/dvdrental.tar)

- **actor** – stores actors data including first name and last name.  
- **film** – stores film data such as title, release year, length, rating, etc.  
- **film_actor** – stores the relationships between films and actors.  
- **category** – stores film’s categories data.  
- **film_category** - stores the relationships between films and categories.  
- **store** – contains the store data including manager staff and address.  
- **inventory** – stores inventory data.  
- **rental** – stores rental data.  
- **payment** – stores customer’s payments.  
- **staff** – stores staff data.  
- **customer** – stores customer data.  
- **address** – stores address data for staff and customers.  
- **city** – stores city names.  
- **country** – stores country names.  

## DVD Rental Entity Relationship Diagram
![dvd rental database diagram](https://github.com/HihizZ/DVD-database-project--postgreSQL/blob/main/resourse/Photo/dvd-rental-sample-database-diagram.png)

## SQL Turoial:
W3schools: https://www.w3schools.com/sql/default.asp

Query01:
```
--show all database table schema
select * from information_schema.tables where table_schema='public';

```

Quey02:
```
--select the date from customer and find the last name 'L' as the first text.
SELECT *
FROM customer
WHERE last_name like 'L%';
```

Query03:
```
--find out film with the language.
--SELECT Syntax Join, order by
SELECT film_id, lg.name, title
FROM film f
JOIN language lg
ON f.language_id = lg.language_id
order by film_id;
```

Query04:
```
--find out how many film on each category.
--SELECT Syntax LEFT Join, GROUP BY, Order by, COUNT, AS
SELECT c.name, COUNT(f.film_id) AS Total_count
FROM category c
LEFT JOIN film_category fc ON fc.category_id = c.category_id
LEFT JOIN film f ON f.film_id = fc.film_id
GROUP BY c.name
ORDER BY c.name;
```

Query05:
```
--find out the customer amount on rental
--SELECT Syntax Join, GROUP BY, Order by, SUM, AS
SELECT c.first_name, c.last_name, SUM(p.amount) AS total_amount
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.first_name, c.last_name
ORDER BY total_amount DESC;
```
Query06:
```
--find out the total amount on film
-- COUNT, SUM, AS, JOIN, DESC, GROUP BY, ORDER BY
SELECT c.category_id, c.name AS category_name, COUNT(f.film_id) AS film_count, SUM(p.amount) AS total_amount
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY c.category_id
ORDER BY film_count desc;
```

Query07:
```
-- find out who last name "H" in first and "r" in last and count the number of rantal
-- HAVING
SELECT staff.Last_Name, COUNT(rental.rental_ID) AS Number_Of_rental
FROM rental
INNER JOIN staff ON rental.staff_ID = staff.staff_ID
WHERE Last_Name LIKE 'H%' OR Last_Name LIKE '%r'
GROUP BY Last_Name
HAVING COUNT(rental.rental_ID) > 25;
```

Query08:
```
--The email list on staff and customer
--UNION
SELECT 'staff' AS TYPE,first_name, last_name, email
FROM staff
UNION ALL
SELECT 'customer',first_name, last_name, email
FROM customer
ORDER BY first_name, last_name;
```
Query09:
```
SELECT fc.category_id, c.name,  COUNT(fc.category_id) AS category_count
FROM film_category fc
LEFT JOIN category c
    ON c.category_id = fc.category_id
GROUP BY c.name, fc.category_id
order by category_id,category_count;
```
Query10:
```
--create new function to find film rental rate
CREATE FUNCTION get_film_rental_rate(rate_from numeric, rate_to numeric)
RETURNS int
LANGUAGE plpgsql
AS $$
DECLARE
   film_rental_rate integer;
BEGIN
   SELECT count(*)
   INTO film_rental_rate
   FROM film
   WHERE rental_rate BETWEEN rate_from AND rate_to;

   RETURN film_rental_rate;
END;
$$;

--using function
SELECT get_film_rental_rate(2.99::numeric, 4.99::numeric);

--1
select get_film_rental_rate(
    rate_from => 2.99::numeric,
     rate_to => 4.99::numeric
);

--2
select get_film_rental_rate(2.99::numeric, rate_to => 4.99::numeric);
```
Query11:
```
--To find the PG rating film revenue
SELECT f.rating, SUM(p.amount) AS total_revenue
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY f.rating
HAVING f.rating::text LIKE 'PG%'
ORDER BY total_revenue DESC;
```
Query12:
```
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
```
