-- 1 --

DROP VIEW IF EXISTS list_of_customers;
CREATE VIEW list_of_customers as
	SELECT customer_id, 
	CONCAT(customer.first_name, " ", customer.last_name ) as 'full name',
	address, postal_code as 'zip code', phone, city, country, 
	CASE
		WHEN customer.active = 1 THEN "active"
		ELSE 'inactive' 
		END as 'status', 
	customer.store_id
	FROM customer  
	INNER JOIN address USING (address_id) 
	INNER JOIN city USING(city_id)
	INNER JOIN country USING(country_id)
;

-- 2 --
DROP VIEW IF EXISTS film_details;
CREATE VIEW film_details as
	SELECT film_id, title, description, 
	c.name, f.rental_rate as 'price', 'length', rating, 
	GROUP_CONCAT(CONCAT(a.first_name, " ", a.last_name ))
	FROM film f
	INNER JOIN film_category fc USING (film_id)
	INNER JOIN category c USING (category_id)
	INNER JOIN film_actor fa USING (film_id)
	INNER JOIN actor a USING (actor_id)
	GROUP BY film_id, c.name
;

SELECT * FROM film_details;

-- 3 --

DROP VIEW IF EXISTS sales_by_film_category;
CREATE VIEW sales_by_film_category as
	SELECT c.name, COUNT(r.rental_id) 
	FROM category c
	INNER JOIN film_category fc USING (category_id)
	INNER JOIN film f USING (film_id)
	INNER JOIN inventory i USING (film_id)
	INNER JOIN rental r USING (inventory_id)
	GROUP BY c.name
;

SELECT * FROM sales_by_film_category;

-- 4 --

DROP VIEW IF EXISTS actor_information;
CREATE VIEW actor_information as
	SELECT actor_id, first_name, last_name, COUNT(film_id) 
	FROM actor
	INNER JOIN film_actor fa USING (actor_id)
	GROUP BY actor_id 
;

SELECT * FROM actor_information;

-- 5 --

SELECT * FROM actor_info;

-- Es na view que trae el actor_id, firs_name y last_name de los actores y 
-- ademas genera una columna donde concatena todas las peliculas con su respectiva categoria

-- CREATE VIEW ... as
select
	actor_id, first_name, last_name,
	group_concat(concat(name, ": ", title)) as "film_info"
	FROM actor
	join film_actor	using(actor_id)
	join film using(film_id)
	join film_category using(film_id)
	join category using(category_id)
	group by actor_id

-- 6 --

-- views son tablas virtuales generada a partir de consultas SELECT a otras tablas
-- estas pueden utilizarse para tener informacion especifica que uno necesita directamente
-- en una sola tabla (informacion que bien estructurada tiene que estar cada una en su tabla
-- original) para evitar tener que realizar querys todo el tiempo.


	

	
	
	

