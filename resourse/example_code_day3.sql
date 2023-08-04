WITH short_film AS (
	SELECT*FROM film
	LIMIT 20	   	   )
select rating, STRING_AGG(description, '54639 ')
FROM short_film
GROUP BY rating;


WITH short_film AS (
	SELECT*FROM film
	LIMIT 20	   	   )
select rating, string_to_array(STRING_AGG(description, '54639 '),'54639')
FROM short_film
GROUP BY rating;


WITH short_film AS (
	SELECT*FROM film
	LIMIT 20	   	   )
select rating, split_part(STRING_AGG(description, '54639 '),'54639', 2)
FROM short_film
GROUP BY rating;


---crate function
create function get_film_count(len_from int, len_to int)
returns int
language plpgsql
as
$$
declare
   film_count integer;
begin
   select count(*) 
   into film_count
   from film
   where length between len_from and len_to;
   
   return film_count;
end;
$$;

--using function
SELECT
get_film_count(70, 100)

