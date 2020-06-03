--4--

SELECT film_id, title 
	FROM film f
	WHERE film_id NOT IN (SELECT film_id FROM inventory i)
;

--5--

SELECT f.title, i.inventory_id 
	FROM inventory i 
	INNER JOIN film f
	USING (film_id)
	WHERE inventory_id NOT IN (SELECT inventory_id FROM rental r)
;

--5 PeroNoMeGusta--

SELECT f.title, i.inventory_id, r.rental_id 
	FROM inventory i 
	INNER JOIN film f
	USING (film_id)
	LEFT OUTER JOIN rental r
	on i.inventory_id = r.inventory_id
	WHERE r.rental_id IS NULL
;

--6--

SELECT c.customer_id, c.first_name, c.last_name, s.store_id, f.title, r.rental_date , r.return_date 
	FROM customer c 
	INNER JOIN store s
	ON c.store_id = s.store_id 
	INNER JOIN inventory i 
	ON i.store_id = s.store_id 
	INNER JOIN film f
	ON f.film_id = i.film_id 
	INNER JOIN rental r 
	ON c.customer_id = r.customer_id 
	ORDER BY s.store_id, c.last_name
	LIMIT 100
;

--7--

SELECT s.address_id, SUM(p.amount)
	FROM store s
	INNER JOIN customer c
	USING (store_id)
	INNER JOIN payment p
	ON p.customer_id = c.customer_id 
	GROUP BY s.store_id 

;
	



