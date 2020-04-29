-- Find customers who paid between $3 and $4

SELECT first_name,last_name 
  FROM customer,payment 
 WHERE customer.customer_id = payment.customer_id 
   AND payment.amount BETWEEN 3 AND 4; 
;  
  
SELECT first_name,last_name 
  FROM customer 
 WHERE customer_id IN (SELECT customer_id 
                         FROM payment 
                        WHERE amount BETWEEN 3 AND 4)
; 
                        
SELECT first_name,last_name 
  FROM customer c1 
 WHERE EXISTS (SELECT * 
                 FROM customer c2 
                WHERE c1.first_name = c2.first_name 
                  AND c1.customer_id <> c2.customer_id) 
;

-- Find films with the max duration
SELECT title,`length` 
  FROM film f1 
 WHERE NOT EXISTS (SELECT * 
                     FROM film f2 
                    WHERE f2.`length` > f1.`length`)
; 

SELECT title , length
	FROM film
	where `length` > ALL (SELECT `length` FROM film) 
;

UPDATE film SET length = 200 WHERE film_id = 182;

SELECT title,length 
  FROM film f1 
 WHERE length > ALL (SELECT length 
                       FROM film f2
                      WHERE f2.film_id <> f1.film_id)
;

SELECT title,replacement_cost 
  FROM film 
 WHERE replacement_cost > ANY (SELECT replacement_cost 
                                 FROM film)
;
                    