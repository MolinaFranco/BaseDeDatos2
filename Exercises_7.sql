
set @v1 = 120;
SELECT title, description , rental_rate  * @v1 AS 'pesos'
FROM film f 
where rental_rate * @v1 > 300
anda rental_rate  * @v1 < 400
;

SELECT g.title, g.in_pesos, g.description,
  FROM (SELECT film_id,
               title,
               description, 
               rental_rate,
               rental_rate * 120 AS in_pesos 
          FROM film) g, film_actor fa, actor a 
 WHERE g.film_id = fa.film_id 
  AND fa.actor_id  = a.actor_id 
  AND  g.in_pesos > 300 
   AND g.in_pesos < 400
;

SELECT p.amount, c.last_name FROM payment p, customer c 
	WHERE c.customer_id = p.customer_id 
	AND c.first_name  = 'ALMA'
;

--1--

SELECT f.title, f.rating FROM film f
	WHERE f.`length` <= ALL (SELECT f2.`length` FROM film f2)
;

--2--

SELECT f.title, f.rating FROM film f
	WHERE f.`length` < ALL (SELECT f2.`length` FROM film f2
								WHERE f.film_id <> f2.film_id 
								)
;

--3--

SELECT DISTINCT c.customer_id, c.first_name, c.last_name, a.address, p.amount AS 'min_amount'
	FROM customer c, address a, payment p
	WHERE c.address_id = a.address_id 
	AND p.customer_id = c.customer_id
	AND p.amount IN (SELECT MIN(p2.amount) FROM payment p2
							WHERE p2.customer_id = c.customer_id 
							)
	ORDER BY customer_id  
;

SELECT DISTINCT c.customer_id, c.first_name, c.last_name, a.address, p.amount AS 'min_amount'
	FROM customer c, address a, payment p
	WHERE c.address_id = a.address_id 
	AND p.customer_id = c.customer_id
	AND p.amount <= ALL (SELECT p2.amount FROM payment p2
							WHERE p2.customer_id = c.customer_id 
							)
	ORDER BY customer_id  
;

--3 pero en forma guishe--
SELECT first_name, address, (SELECT MIN(p2.amount) FROM payment p2 WHERE p2.customer_id = c.customer_id ) as minimo_pago 
    FROM customer c, address a 
    WHERE c.address_id = a.address_id
    order by minimo_pago
;

--reparar mas tarde cuando tenga tiempo al pedo ya que ya lo resolvi de otra forma--
--ta re mal esto pero lo voy a dejar por que me da gracia--

SELECT first_name, address, (SELECT p2.amount FROM payment p2 WHERE p2.customer_id = c.customer_id AND p2.amount <= ALL (SELECT p3.amount FROM payment p3 WHERE p3.customer_id = c.customer_id ) ) as minimo_pago 
    FROM customer c, address a 
    WHERE c.address_id = a.address_id
    order by minimo_pago
;

--4 forma guishe hecha por mi--
 
SELECT c.first_name, c.last_name, (SELECT MIN(p2.amount) FROM payment p2 WHERE p2.customer_id = c.customer_id ) as min_amount, (SELECT MAX(p3.amount) FROM payment p3 WHERE p3.customer_id = c.customer_id ) as max_amount
    FROM customer c
;

--4 mi forma hecho por guishe--
SELECT DISTINCT c.customer_id, c.first_name, c.last_name, a.address, p.amount AS 'min_amount', p2.amount AS "max_amount"
    FROM customer c, payment p, payment p2 
    WHERE p.customer_id = c.customer_id
    AND p2.customer_id = c.customer_id 
    AND p.amount <= ALL (SELECT p3.amount FROM payment p3 WHERE p3.customer_id = c.customer_id)
    AND p2.amount >= ALL (SELECT p3.amount FROM payment p3 WHERE p3.customer_id = c.customer_id)
    ORDER BY min_amount
;








