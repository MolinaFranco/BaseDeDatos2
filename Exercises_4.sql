USE sakila;

SELECT title, special_features 
	FROM film f
	WHERE rating = "PG-13"
;
	
SELECT DISTINCT `length` 
	FROM film f 
	ORDER BY `length` 
;

SELECT title, rental_rate, replacement_cost 
	FROM film f 
	WHERE replacement_cost BETWEEN 20.00 AND 24.00
;	

SELECT f.title, f.rental_rate, c.name
 	FROM film f, film_category fc,  category c 
	WHERE f.film_id = fc.film_id 
  	AND fc.category_id = c.category_id
  	AND f.special_features = "Behind the Scenes"
;

SELECT a.first_name, a.last_name 
	FROM actor a, film_actor fa, film f 
	WHERE fa.actor_id = a.actor_id 
	AND fa.film_id  = f.film_id 
	AND  f.title = "ZOOLANDER FICTION"	
;

SELECT a.address, c.city, co.country
	FROM store s, address a, city c, country co 
	WHERE s.address_id = a.address_id 
	AND a.address_id = 1
	AND a.city_id = c.city_id 
	AND c.country_id = co.country_id 
;	
 
#select 7

SELECT f.title, s.first_name, s.last_name 
	FROM inventory i, film f, staff s, store st
	WHERE st.manager_staff_id = s.staff_id 
	AND st .store_id = 2
	AND i.store_id = i.film_id 
;


	
;