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