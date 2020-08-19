DROP DATABASE IF EXISTS imbd;

CREATE DATABASE imbd;

USE imbd;

CREATE TABLE film
(
	film_id INT AUTO_INCREMENT,
	title VARCHAR(50),
	description VARCHAR(200),
	relase_year INT,
	CONSTRAINT film_pk PRIMARY KEY (film_id)
);

CREATE TABLE actor
(
	actor_id INT AUTO_INCREMENT,
	first_name VARCHAR(30),
	last_name VARCHAR(50),
	CONSTRAINT film_pk PRIMARY KEY (actor_id)
);

CREATE TABLE actor_film
(
	actor_id INT NOT NULL,
	film_id INT NOT NULL,
	CONSTRAINT actor_film_pk PRIMARY KEY (actor_id, film_id) 
);

ALTER TABLE film ADD
	COLUMN last_update DATETIME DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE actor ADD
	COLUMN last_update DATETIME DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE actor_film ADD
	CONSTRAINT fk_film FOREIGN KEY (film_id) REFERENCES film (film_id);

ALTER TABLE actor_film ADD
	CONSTRAINT fk_actor FOREIGN KEY (actor_id) REFERENCES actor (actor_id);

INSERT INTO actor (first_name, last_name)
	VALUES ("Tony", "Starck");
	
INSERT INTO actor (first_name, last_name)
	VALUES ("Peter", "Parker");
	
INSERT INTO actor (first_name, last_name)
	VALUES ("Thor", "Odison");
	
INSERT INTO film (title, description, relase_year )
	VALUES ("IronMan", "A men of iron", "2002");

INSERT INTO film (title, description, relase_year )
	VALUES ("Avenger", "The real team", "2010");
	
INSERT INTO actor_film (actor_id, film_id )
	VALUES (1, 1);

INSERT INTO actor_film (actor_id, film_id )
	VALUES (2, 1);

INSERT INTO actor_film (actor_id, film_id )
	VALUES (2, 2);

INSERT INTO actor_film (actor_id, film_id )
	VALUES (1, 2);

INSERT INTO actor_film (actor_id, film_id )
	VALUES (3, 2)

	




	