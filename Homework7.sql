--1
Select * 
From customer
WHERE last_name LIKE 'T%'
ORDER BY first_name;

--2
Select *
From rental
WHERE return_date >= '2005-05-28' AND return_date <= '2005-06-01'
ORDER BY return_date;

--3
SELECT title, COUNT(rental_rate) AS rental_count
FROM film
GROUP BY title
ORDER BY rental_count DESC
LIMIT 10;

--4
SELECT n.customer_id, (n.last_name) AS customer_name,
	   SUM(p.amount) AS total_spent
FROM customer n
LEFT JOIN rental r ON n.customer_id = r.customer_id
LEFT JOIN payment p ON r.rental_id = p.rental_id
GROUP BY n.customer_id, customer_name
ORDER BY total_spent;

--5
SELECT a.actor_id, a.last_name AS actor_name, COUNT(f.film_id) AS movie_count
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
LEFT JOIN film f ON fa.film_id = f.film_id AND f.release_year = 2006
GROUP BY a.actor_id
ORDER BY movie_count DESC
LIMIT 1;

--6
EXPLAIN SELECT c.customer_id, (c.last_name) AS customer_name,
	   SUM(p.amount) AS total_spent
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
LEFT JOIN payment p ON r.rental_id = p.rental_id
GROUP BY c.customer_id, customer_name
ORDER BY total_spent;

EXPLAIN SELECT a.actor_id, a.last_name AS actor_name, COUNT(f.film_id) AS movie_count
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
LEFT JOIN film f ON fa.film_id = f.film_id AND f.release_year = 2006
GROUP BY a.actor_id
ORDER BY movie_count DESC
LIMIT 1;

--7
SELECT c.category_id, c.name AS genre_name,
       AVG(f.rental_rate) AS avg_rental_rate
FROM category c
LEFT JOIN film_category fc ON c.category_id = fc.category_id
LEFT JOIN film f ON fc.film_id = f.film_id
GROUP BY c.category_id, c.name
ORDER BY avg_rental_rate;

--8
SELECT n.category_id, n.name AS category_name,
       COUNT(*) AS rental_count, SUM(p.amount) AS total_sales
FROM category n
LEFT JOIN film_category fn ON n.category_id = fn.category_id
LEFT JOIN film f ON fn.film_id = f.film_id
LEFT JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
LEFT JOIN payment p ON r.rental_id = p.rental_id
GROUP BY n.category_id, n.name
ORDER BY rental_count DESC
LIMIT 5;


EC:
SELECT n.name AS category_name, 
       EXTRACT(MONTH FROM r.rental_date) AS rental_month,
       COUNT(*) AS total_rentals
FROM rental r
LEFT JOIN inventory i ON r.inventory_id = i.inventory_id
LEFT JOIN film f ON i.film_id = f.film_id
LEFT JOIN film_category fn ON f.film_id = fn.film_id
LEFT JOIN category n ON fn.category_id = n.category_id
GROUP BY n.name, rental_month
ORDER BY n.name, rental_month;