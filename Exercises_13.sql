--1--

INSERT INTO
	sakila.customer (store_id, first_name, last_name, email, address_id, active , last_update)
VALUES(1, 'Messi', 'Chiquito', 'MC@gmail.com',(
SELECT
	MAX(address_id)
from
	address
JOIN city
		USING(city_id)
JOIN country
		USING(country_id)
WHERE
	country = 'United States') , 1, CURRENT_TIMESTAMP);
	
--2--

INSERT INTO rental
(rental_date, inventory_id, customer_id, return_date, staff_id, last_update)
VALUES('12/12/12', (
SELECT
	MAX(inventory_id) 
from
	inventory 
JOIN film f
		USING(film_id)
WHERE
	f.title = 'ACADEMY DINOSAUR'), 1, '12/12/12',(
SELECT
	staff_id 
from
	staff s
JOIN store st
		USING(store_id)
WHERE
	store_id = 2) , CURRENT_TIMESTAMP);

--3--

UPDATE film set 
	release_year = 2001
where rating = "G";

UPDATE film set 
	release_year = 2002
where rating = "NC-17";

UPDATE film set 
	release_year = 2003
where rating = "PG-13";

UPDATE film set 
	release_year = 2004
where rating = "R";

--4--

SET @num_id = (select i.inventory_id
	from inventory i
	inner join film using(film_id)
	left join rental using (inventory_id)
	where return_date is null
	and rental_date in (select rental_date from rental where return_date is null order by rental_date desc)
	limit 1);

UPDATE rental
SET return_date=current_timestamp , last_update=CURRENT_TIMESTAMP
WHERE inventory_id = @num_id
; 

--5--

Try to delete a film
Check what happens, describe what to do.
Write all the necessary delete statements to entirely remove the film from the DB.

DELETE FROM sakila.film
WHERE film_id=5;

SQL Error [1451] [23000]: Cannot delete or update a parent row: a foreign key constraint 
fails (`sakila`.`film_actor`, CONSTRAINT `fk_film_actor_film` FOREIGN KEY (`film_id`) REFERENCES `film` (`film_id`) ON UPDATE CASCADE)

DELETE FROM film_actor 
WHERE film_id=5;

DELETE FROM film_category 
WHERE film_id=5;

DELETE FROM payment 
WHERE rental_id IN (SELECT 
	rental_id FROM rental
	JOIN inventory i USING (inventory_id)
	WHERE i.film_id = 5
)
;

DELETE FROM rental
WHERE inventory_id IN (SELECT 
	inventory_id FROM inventory 
	WHERE film_id = 5
);

DELETE FROM inventory 
WHERE film_id=5;

DELETE FROM film 
WHERE film_id=5;

--6--

SET @avaliable = (SELECT DISTINCT inventory_id 
	FROM inventory i 
	WHERE inventory_id not in (SELECT inventory_id 
			FROM rental r 
			WHERE return_date is not null)
	LIMIT 1)
;

INSERT INTO rental
(rental_id, inventory_id, customer_id, return_date, staff_id, last_update)
VALUES(555555,@avaliable, 5, NULL, 1, CURRENT_TIMESTAMP);
;
	
INSERT INTO payment
(customer_id, staff_id, rental_id, amount, last_update)
VALUES(5, 1, 555555, 50,  CURRENT_TIMESTAMP)
;
