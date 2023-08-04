SELECT fc.category_id, c.name,  COUNT(fc.category_id) AS category_count
FROM film_category fc
LEFT JOIN category c
    ON c.category_id = fc.category_id
GROUP BY c.name, fc.category_id
order by category_id,category_count;