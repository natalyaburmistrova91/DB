-- 1. ����� � ������� users ���� created_at � updated_at ��������� ��������������. ��������� �� �������� ����� � ��������.

CREATE DATABASE HW5;
USE HW5;
CREATE TABLE users (id INT NOT NULL, name VARCHAR(20), created_at TIMESTAMP, updated_at TIMESTAMP, PRIMARY KEY(id));
SHOW TABLES;
DESC users;
INSERT INTO users (id, name) VALUES (1, '��������'), (2, '���������'), (3, '������'), (4, '�������');
SELECT * FROM users;
UPDATE users SET created_at = CURRENT_TIMESTAMP, updated_at = CURRENT_TIMESTAMP;

-- 2. ������� users ���� �������� ��������������. 
-- ������ created_at � updated_at ���� ������ ����� VARCHAR � � ��� ������ ����� ���������� �������� � ������� "20.10.2017 8:10". 
-- ���������� ������������� ���� � ���� DATETIME, �������� �������� ����� ��������.

DROP TABLE users;
CREATE TABLE users (id INT NOT NULL, name VARCHAR(20), created_at VARCHAR(20), updated_at VARCHAR(20), PRIMARY KEY(id));
INSERT INTO users (id, name, created_at, updated_at) VALUES 
(1, '��������', '21.10.2017 8:10', '22.10.2017 8:11'),
(2, '���������', '21.10.2017 8:10', '22.10.2017 8:11'),
(3, '������', '24.10.2017 8:10', '30.10.2017 8:11'),
(4, '�������', '20.11.2017 8:10', '25.10.2017 8:11');

UPDATE users SET created_at=STR_TO_DATE(created_at, '%d.%m.%Y %H:%i'), updated_at=STR_TO_DATE(updated_at, '%d.%m.%Y %H:%i');
SELECT * FROM users;
ALTER TABLE users MODIFY COLUMN created_at DATETIME, MODIFY updated_at DATETIME;
DESC users;

-- 3. � ������� ��������� ������� storehouses_products � ���� value ����� ����������� ����� ������ �����: 
-- 0, ���� ����� ���������� � ���� ����, ���� �� ������ ������� ������. 
-- ���������� ������������� ������ ����� �������, ����� ��� ���������� � ������� ���������� �������� value. 
-- ������, ������� ������ ������ ���������� � �����, ����� ���� �������.

CREATE TABLE storehouses_products (id INT NOT NULL, name VARCHAR(20), value INT UNSIGNED, PRIMARY KEY(id));
DESC storehouses_products;
INSERT INTO storehouses_products (id, name, value) VALUES 
(1, '��������', 3),
(2, '������', 0),
(3, '�����', 4),
(4, '������', 0),
(5, '�������', 2)
;

SELECT * FROM storehouses_products WHERE value > 0 ORDER BY value;
SELECT * FROM storehouses_products WHERE value = 0 ORDER BY name;
-- �� ������ ���������� ������� 

-- ������������ ������� ���� ���������� �������
-- 1. ����������� ������� ������� ������������� � ������� users

DROP TABLE users;
CREATE TABLE users (id INT NOT NULL, name VARCHAR(20), birthday_at DATETIME, PRIMARY KEY(id));
INSERT INTO users (id, name, birthday_at) VALUES 
(1, '��������', '1988-10-21 8:10:00'),
(2, '���������', '1991-04-16 8:10:00'),
(3, '������', '1999-03-10 8:10:00'),
(4, '�������', '2000-11-30 8:10:00'),
(5, '�������', '2000-11-30 8:10:00');

SELECT ROUND(AVG(TIMESTAMPDIFF(YEAR, birthday_at, NOW())), 2) AS aver_age FROM users;

-- 2. ����������� ���������� ���� ��������, ������� ���������� �� ������ �� ���� ������ (��� ���� ��������). 
SELECT DATE_FORMAT(birthday_at, '%W') as weekday, COUNT(*) FROM users GROUP BY weekday;

-- 3. ������� ������, ��� ���������� ��� ������ �������� ����, � �� ���� �������� (��� �������� ����).
SELECT id, name, STR_TO_DATE(CONCAT(DATE_FORMAT(NOW(), '%Y'), '-', DATE_FORMAT(birthday_at, '%m-%d')), '%Y-%m-%d') AS curr_date FROM users;
SELECT DATE_FORMAT(STR_TO_DATE(CONCAT(DATE_FORMAT(NOW(), '%Y'), '-', DATE_FORMAT(birthday_at, '%m-%d')), '%Y-%m-%d'), '%W') as weekday, COUNT(*) FROM users GROUP BY weekday;




