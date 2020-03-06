-- 1. Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.

CREATE DATABASE HW5;
USE HW5;
CREATE TABLE users (id INT NOT NULL, name VARCHAR(20), created_at TIMESTAMP, updated_at TIMESTAMP, PRIMARY KEY(id));
SHOW TABLES;
DESC users;
INSERT INTO users (id, name) VALUES (1, 'Геннадий'), (2, 'Анастасия'), (3, 'Михаил'), (4, 'Надежда');
SELECT * FROM users;
UPDATE users SET created_at = CURRENT_TIMESTAMP, updated_at = CURRENT_TIMESTAMP;

-- 2. Таблица users была неудачно спроектирована. 
-- Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в формате "20.10.2017 8:10". 
-- Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.

DROP TABLE users;
CREATE TABLE users (id INT NOT NULL, name VARCHAR(20), created_at VARCHAR(20), updated_at VARCHAR(20), PRIMARY KEY(id));
INSERT INTO users (id, name, created_at, updated_at) VALUES 
(1, 'Геннадий', '21.10.2017 8:10', '22.10.2017 8:11'),
(2, 'Анастасия', '21.10.2017 8:10', '22.10.2017 8:11'),
(3, 'Михаил', '24.10.2017 8:10', '30.10.2017 8:11'),
(4, 'Надежда', '20.11.2017 8:10', '25.10.2017 8:11');

UPDATE users SET created_at=STR_TO_DATE(created_at, '%d.%m.%Y %H:%i'), updated_at=STR_TO_DATE(updated_at, '%d.%m.%Y %H:%i');
SELECT * FROM users;
ALTER TABLE users MODIFY COLUMN created_at DATETIME, MODIFY updated_at DATETIME;
DESC users;

-- 3. В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 
-- 0, если товар закончился и выше нуля, если на складе имеются запасы. 
-- Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. 
-- Однако, нулевые запасы должны выводиться в конце, после всех записей.

CREATE TABLE storehouses_products (id INT NOT NULL, name VARCHAR(20), value INT UNSIGNED, PRIMARY KEY(id));
DESC storehouses_products;
INSERT INTO storehouses_products (id, name, value) VALUES 
(1, 'Карандаш', 3),
(2, 'Ластик', 0),
(3, 'Ручка', 4),
(4, 'Маркер', 0),
(5, 'Линейка', 2)
;

SELECT * FROM storehouses_products WHERE value > 0 ORDER BY value;
SELECT * FROM storehouses_products WHERE value = 0 ORDER BY name;
-- не смогла объединить запросы 

-- Практическое задание теме “Агрегация данных”
-- 1. Подсчитайте средний возраст пользователей в таблице users

DROP TABLE users;
CREATE TABLE users (id INT NOT NULL, name VARCHAR(20), birthday_at DATETIME, PRIMARY KEY(id));
INSERT INTO users (id, name, birthday_at) VALUES 
(1, 'Геннадий', '1988-10-21 8:10:00'),
(2, 'Анастасия', '1991-04-16 8:10:00'),
(3, 'Михаил', '1999-03-10 8:10:00'),
(4, 'Надежда', '2000-11-30 8:10:00'),
(5, 'Алексей', '2000-11-30 8:10:00');

SELECT ROUND(AVG(TIMESTAMPDIFF(YEAR, birthday_at, NOW())), 2) AS aver_age FROM users;

-- 2. Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели (для года рождения). 
SELECT DATE_FORMAT(birthday_at, '%W') as weekday, COUNT(*) FROM users GROUP BY weekday;

-- 3. Следует учесть, что необходимы дни недели текущего года, а не года рождения (для текущего года).
SELECT id, name, STR_TO_DATE(CONCAT(DATE_FORMAT(NOW(), '%Y'), '-', DATE_FORMAT(birthday_at, '%m-%d')), '%Y-%m-%d') AS curr_date FROM users;
SELECT DATE_FORMAT(STR_TO_DATE(CONCAT(DATE_FORMAT(NOW(), '%Y'), '-', DATE_FORMAT(birthday_at, '%m-%d')), '%Y-%m-%d'), '%W') as weekday, COUNT(*) FROM users GROUP BY weekday;




