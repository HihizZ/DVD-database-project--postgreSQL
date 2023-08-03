--SELECT Syntax Join, order by 
SELECT film_id, lg.name, title
FROM film f
JOIN language lg 
ON f.language_id = lg.language_id
order by film_id;
