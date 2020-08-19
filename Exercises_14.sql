-- 1 --

SELECT CONCAT(first_name, " ",last_name), address, city
	FROM customer c
	JOIN address using(address_id)
	JOIN city using(city_id)
	JOIN country using(country_id)
	WHERE country LIKE BINARY "%Argentina%"
;

-- 2 -- 

SELECT title, l.name, release_year,
	CASE
		WHEN rating LIKE "G" THEN "General Public"
		WHEN rating LIKE "PG" THEN "Parental Guidance Suggested"
		WHEN rating LIKE "PG-13" THEN "Parents Strongly Cautioned"
		WHEN rating LIKE "R" THEN "Restricted"
		WHEN rating LIKE "NC-17" THEN "Adults Only"
		ELSE rating 
		end as rating 
	FROM film f
	INNER JOIN `language` l using(language_id)
;
	
-- 3 --

SELECT title
	FROM film f
	JOIN film_actor USING(film_id)
	JOIN actor USING(actor_id)
	WHERE MATCH( actor.first_name, actor.last_name ) against('penelope' in natural language mode)
;

SELECT title, actor.first_name 
	FROM film f
	JOIN film_actor USING(film_id)
	JOIN actor USING(actor_id)
	WHERE UPPER(CONCAT(actor.first_name," ", actor.last_name)) = UPPER(TRIM(' Penelope Guiness'))
;

-- 4 --

SELECT title, concat(first_name, " ", last_name) as "Cliente", r.rental_date,
	CASE 
		WHEN rental_date is null then "No"
		ELSE "Yes"
		END as "Devuelto"
	FROM customer 
	JOIN rental r	using(customer_id)
	JOIN inventory using(inventory_id)
	JOIN film using(film_id)
	WHERE month(return_date) IN (5, 6) 
;
	
-- 5 --

-- The CAST function is ANSI standard and is compatible to use in other databases while the CONVERT function is a specific function of the SQL server.
-- CAST is part of the ANSI-SQL specification; whereas, CONVERT is not. In fact, CONVERT is SQL implementation-specific. CONVERT differences lie in that it accepts an optional style parameter that is used for formatting.

SELECT * 
	FROM payment 
	WHERE cast(amount as CHARACTER ) = "2.99";

SELECT * 
	FROM payment 
	WHERE convert(amount, CHARACTER ) = "2.99";

SELECT CAST("2017-08-29" AS DATE);
SELECT convert("2017-08-29", DATE);

-- 6 -- 

-- The MySQL IFNULL() function lets you return an alternative value if an expression is NULL
-- The COALESCE() function returns the first non-null value in a list.
-- The ISNULL() function returns a specified value if the expression is NULL.
		-- If the expression is NOT NULL, this function returns the expression.
-- all are the same 

-- NVL function is specific to Oracle server , it replaces null value with other value
-- Ifnull/coaleasce function does the same but it is supported only in MySQL server
-- Isnull function does the same in sql server.

-- ifnull/coalesce
-- ifnull can only replace a null value of the first parameter. 
-- Whereas coalesce can replace any value with another value. With coalesce in standard SQL you can have many parameters transforming many values.

SELECT rental_id, NVL(return_date , 0)
FROM rental r ;

