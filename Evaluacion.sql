Muestre la cantidad de películas que tienen los clientes alquiladas (es decir que todavía no se 
han devuelto) agrupadas por rating (G, PG, etc...)

SELECT c.name,COUNT(r.rental_id)
	FROM rental r
	JOIN inventory i USING (inventory_id)
	JOIN film f USING (film_id)
	JOIN film_category fc USING (film_id)
	JOIN category c USING (category_id)
	WHERE r.return_date is null
	GROUP BY c.name
;


Mostrar todas las direcciones (address) almacenadas en la DB sakila de los países que terminen 
con la letra 'a' (minúscula) y cuya cuidad empiece con la letra 'E' (mayúscula)
Las columnas a mostrar son: nombre del país, nombre de la ciudad y dirección completa - es decir, calle y número 
(columna address), distrito y código postal. Ordenadas primero por país y luego por ciudad alfabéticamente. Tenga en cuenta que 
su base de datos puede no distinguir mayúscula y minúsculas (case insensitive)


SELECT co.country, ci.city, CONCAT(a.address," ",a.address2) as 'Direction', a.district, a.postal_code 
	FROM address a 
	JOIN city ci USING (city_id)
	JOIN country co USING (country_id)
	WHERE co.country LIKE BINARY '%a'
	AND ci.city LIKE BINARY 'E%'
	ORDER BY co.country,ci.city
;

Genere un reporte mostrando el nombre y apellido de cada cliente con la cantidad de películas que alquiló 
y la cantidad de dinero que ha gastado. Mostrar solo los clientes que hayan gastado entre 10 y 100 dolares.


SELECT 
    first_name, c.last_name,
    (SELECT count(*) 
    	FROM rental r 
    	WHERE r.customer_id = c.customer_id
    ) as 'rented_movies',
    (SELECT sum(p.amount) 
    FROM payment p
    WHERE p.customer_id = c.customer_id 
    ) as 'total_money'
	FROM customer c
	HAVING total_money < 100
	AND total_money  > 10	
;
