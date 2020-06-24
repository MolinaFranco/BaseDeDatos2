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

SELECT s.store_id, SUM(p.amount) as Total, CONCAT(st.first_name , ' ' ,st.last_name) as Nombre, CONCAT(city, ' ' ,country) as Lugar
	FROM store s
	INNER JOIN customer c USING (store_id)
	INNER JOIN payment p ON p.customer_id = c.customer_id 
	INNER JOIN staff st ON(p.staff_id = st.staff_id )
	INNER JOIN address a ON(s.address_id = a.address_id)
	INNER JOIN city USING(city_id)
	INNER JOIN country USING(country_id)
	GROUP BY s.store_id, Nombre , Lugar 
;

--7 nica--

SELECT sum(amount) as Total , store_id, CONCAT(st.first_name , ' ' ,st.last_name, ' ' , city, ' ' ,country) as Nombre_ciudad
	FROM payment p
	inner join staff st on(p.staff_id = st.staff_id )
	inner join store s USING (store_id)
	inner join address a on( s.address_id = a.address_id)
	inner join city USING (city_id)
	inner join country USING(country_id)
	group by store_id, Nombre_ciudad;

--8--

SELECT a.actor_id, a.first_name, a.last_name, COUNT(actor_id) as film_count 
	FROM actor a JOIN film_actor as film_count
	group by actor_id 
	ORDER by film_count DESC 
	limit 1
;

SELECT actor.*, COUNT(*) AS `number of films` FROM film_actor
	INNER JOIN actor USING (actor_id)
	GROUP BY actor_id
	HAVING `number of films` = (SELECT MAX(`count`) FROM (SELECT COUNT(*) AS `count` 
														FROM film_actor 
														GROUP BY actor_id) `counted`);
	



