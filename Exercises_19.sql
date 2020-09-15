-- cuidado docker run --name db-usuarios -e MYSQL_ROOT_PASSWORD=password -p 3308:3306 mysql:8   
	
create user data_analyst@'%' IDENTIFIED by "data_analyst"; 

DROP USER 'data_analyst'@;

use mysql

use sakila

select * from user

GRANT SELECT, UPDATE, DELETE ON sakila.* TO data_analyst@'%' IDENTIFIED BY '123456789' WITH GRANT OPTION;	

-- 4 --

CREATE TABLE MyGuests (
id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
firstname VARCHAR(30) NOT NULL,
lastname VARCHAR(30) NOT NULL,
email VARCHAR(50),
reg_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
)
;

-- SQL Error [1142] [42000]: CREATE command denied to user 'data_analyst'@'172.17.0.1' for table 'MyGuests'

UPDATE sakila.film 
SET title = "MOLINATOR"
WHERE film_id = 13

REVOKE  UPDATE ON sakila.*  FROM data_analyst@'%';

-- SQL Error [1142] [42000]: UPDATE command denied to user 'data_analyst'@'172.17.0.1' for table 'film'