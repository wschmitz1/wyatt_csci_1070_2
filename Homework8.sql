SELECT *
FROM rental


-- 1 
ALTER TABLE rental
ADD COLUMN status VARCHAR(10);
UPDATE rental
SET status = CASE
                WHEN return_date > rental_date THEN 'late'
                WHEN return_date < rental_date THEN 'early'
                ELSE 'on time'
             END;
SELECT *
FROM rental

--2
SELECT SUM(p.amount) AS total_payment_amount
FROM payment p
JOIN customer cu ON p.customer_id = cu.customer_id
JOIN address a ON cu.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
WHERE ci.city IN ('Kansas City', 'Saint Louis');


--3
SELECT c.name AS category, COUNT(fc.film_id) AS film_count
FROM category c
LEFT JOIN film_category fc ON c.category_id = fc.category_id
GROUP BY c.name;


--4
-- Having separate tables allows for better organization
-- when normalizing or cleaning the data. 


--5
SELECT f.film_id, f.title, f.length
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.return_date BETWEEN '2005-05-15' AND '2005-05-31';


--6
SELECT f.film_id, f.title, f.rental_rate
FROM film f
WHERE f.rental_rate < (SELECT AVG(rental_rate) FROM film);


--7
SELECT status, COUNT(*) AS count
FROM rental
GROUP BY status;

--8
SELECT title, length,
       NTILE(100) OVER (ORDER BY length) AS percentile
FROM film;

--9
EXPLAIN SELECT SUM(p.amount) AS total_payment_amount
FROM payment p
JOIN customer cu ON p.customer_id = cu.customer_id
JOIN address a ON cu.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
WHERE ci.city IN ('Kansas City', 'Saint Louis');
-- The above query is utilizing the join function to locate 
-- payment occurences for customers out of STL or KC.
-- Data is being merged from different tables. 


EXPLAIN SELECT status, COUNT(*) AS count
FROM rental
GROUP BY status;
-- The above query is HashAggregating to aid in counting the 
-- number of rentals by status. 

-- The first query utilizes joins to locate requested data 
-- where the second query simply uses aggregation/grouping 
