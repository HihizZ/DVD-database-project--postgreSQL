--find out the customer amount on rental
--SELECT Syntax Join, GROUP BY, Order by, SUM, AS
SELECT c.first_name, c.last_name, SUM(p.amount) AS total_amount
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.first_name, c.last_name
ORDER BY total_amount DESC;
