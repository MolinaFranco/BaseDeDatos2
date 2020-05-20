--1--

SELECT c2.country_id, c2.country, COUNT(*) as 'Cantidad'
	FROM city c,country c2 
	WHERE c2.country_id = c.country_id 
	GROUP by c2.country, c2.country_id 
	ORDER by c2.country_id 
;

--2--

SELECT c2.country, COUNT(*) as 'Cantidad'
	FROM city c,country c2 
	WHERE c2.country_id = c.country_id
	GROUP by c2.country
	HAVING Cantidad > 10
	ORDER by Cantidad DESC
;

--3--

SELECT CONCAT(c.first_name, c.last_name) AS NAME, a.address, COUNT(r.rental_id ) as 'COUNT_RENTAL', SUM(p.amount) as 'TOTAL_AMOUNT'
	FROM customer c, address a, rental r, payment p
	WHERE a.address_id = c.address_id 
	AND r.customer_id  = c.customer_id 
	AND p.customer_id  = c.customer_id 
	GROUP by NAME, a.address 
	ORDER by TOTAL_AMOUNT DESC
	
--4--

SELECT c.name, MAX(f.`length` ) as 'larger', AVG(f.`length` ) as 'average' 
	FROM film f, film_category fc, category c 
	WHERE f.film_id = fc.film_id 
	AND fc.category_id = c.category_id 
	GROUP by c.name 
	HAVING average > (SELECT AVG(`length`) FROM film f2)
	Order by average DESC
;

--5--

SELECT f.rating, SUM(p.amount) as SALES
	FROM film f, inventory i, rental r, payment p
	WHERE f.film_id = i.film_id
	AND r.inventory_id = i.inventory_id 
	AND p.rental_id = r.rental_id 
	GROUP BY f.rating
;

--cordoba 5--

SELECT film.rating, SUM(payment.amount) AS sales FROM payment
    INNER JOIN rental ON payment.rental_id = rental.rental_id
    INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
    INNER JOIN film ON inventory.film_id = film.film_id
    GROUP BY film.rating

