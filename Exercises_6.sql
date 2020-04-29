SELECT * FROM actor a WHERE EXISTS (
    SELECT * FROM actor a2 
    WHERE a.last_name = a2.last_name
    AND a.actor_id  <> a2.actor_id 
) ORDER  BY a.last_name
;

SELECT * FROM actor a WHERE NOT EXISTS (
    SELECT * FROM film_actor fa, film f2, actor a2 WHERE a2.actor_id = fa.actor_id
            AND f2.film_id = fa.film_id
            )
;

SELECT * FROM customer c 
	WHERE COUNT(rental_id IN (SELECT r2.rental_id FROM rental r2 WHERE r2.customer_id = c.customer_id) = 1
;

SELECT * FROM customer c 
	WHERE (SELECT COUNT(*) FROM rental r2 WHERE r2.customer_id = c.customer_id) > 1
;

SELECT * FROM actor a, film_actor fa, film f 
	WHERE a.actor_id = fa.actor_id 
	AND f.film_id = fa.film_id 
	AND (f.title = 'BETRAYED REAR' OR f.title = 'CATCH AMISTAD')
;

SELECT * FROM actor a, film_actor fa , film f WHERE a.actor_id=fa.actor_id
    AND f.film_id=fa.film_id AND f.title="BETRAYED REAR" AND a.actor_id NOT IN (
        SELECT a2.actor_id from actor a2, film_actor fa2, film f2 WHERE a2.actor_id = fa2.actor_id 
            AND f2.film_id=fa2.film_id AND f2.title="CATCH AMISTAD")
;

SELECT * FROM actor a, film_actor fa , film f WHERE a.actor_id=fa.actor_id
    AND f.film_id=fa.film_id AND f.title="BETRAYED REAR" AND a.actor_id IN (
        SELECT a2.actor_id from actor a2, film_actor fa2, film f2 WHERE a2.actor_id = fa2.actor_id 
            AND f2.film_id=fa2.film_id AND f2.title="CATCH AMISTAD")
;

SELECT * FROM actor a, film_actor fa, film f 
	WHERE a.actor_id = fa.actor_id 
	AND f.film_id = fa.film_id 
	AND (f.title != 'BETRAYED REAR' OR f.title != 'CATCH AMISTAD')
;