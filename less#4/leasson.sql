-- Таблица была готовая, поэтому создал как пример свою базу
-- dz#1 and dz#2

DROP DATABASE IF EXISTS leasson;
CREATE DATABASE leasson;
USE leasson;

DROP TABLE IF EXISTS users;
CREATE TABLE users(
	id SERIAL,
    created_at VARCHAR(50),
    updated_at VARCHAR(50)
);

INSERT INTO users VALUES (1, '20.10.2017 8:10', '21.10.2018 10:30'),
	(2, '20.10.2017 8:10', '21.10.2018 10:30'),
    (3, '20.10.2017 8:10', '21.10.2018 10:30');

ALTER TABLE users ADD (created_at_dt DATETIME, updated_at_dt DATETIME);

UPDATE users
SET created_at_dt = STR_TO_DATE(created_at, '%d.%m.%Y %h:%i'),
    updated_at_dt = STR_TO_DATE(updated_at, '%d.%m.%Y %h:%i');

ALTER TABLE users 
    DROP created_at, DROP updated_at, 
    RENAME COLUMN created_at_dt TO created_at, RENAME COLUMN updated_at_dt TO updated_at;


-- dz#3 Таблица была пуста

INSERT INTO `storehouses_products` VALUES (1,1,1,0,'1989-04-04 04:45:37','2015-06-29 20:52:37'),(2,2,2,250,'2005-03-17 02:16:33','2002-04-04 01:14:15'),(3,3,3,5,'1998-03-19 15:23:19','2004-03-19 14:19:28'),(4,4,4,400,'2018-09-21 11:26:30','1980-02-24 01:37:42'),(5,5,5,0,'1988-03-12 18:58:51','1970-10-09 14:53:53');
-- Заполнил таблицу
SELECT * FROM storehouses_products ORDER BY CASE WHEN value = 0 THEN 2147483647 ELSE value END;

-- dz#4
select name, birthday_at from users where monthname(birthday_at) in ('may', 'august');

-- dz#5
select * from catalogs where id in (5,1,2) order by case when id = 5 then 0 when id = 1 then 1 when id = 2 then 2 end;
-- Агрегация данных dz#1
select round(avg(timestampdiff(year, birthday_at, now())), 0) as avg_age from users;

-- dz#2
SELECT
    DAYNAME(CONCAT(YEAR(NOW()), '-', SUBSTRING(birthday_at, 6, 10))) AS week_day_of_birthday_in_this_Year,
    COUNT(*) AS amount_of_birthday
	FROM users GROUP BY week_day_of_birthday_in_this_Year ORDER BY amount_of_birthday DESC;

-- 2 вариант

SELECT DATE_FORMAT(DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))), '%W') AS day,
	COUNT(*) AS total FROM users GROUP BY day ORDER BY total DESC;


-- dz#3
mysql> create table integ(value serial primary key);
Query OK, 0 rows affected (0,04 sec)

mysql> insert into integ values (null), (null), (null), (null), (null);
select round(exp(sum(ln(value))), 0) as factorial from integ;


