-- Создайте таблицу city с колонками city_id и city_name
CREATE TABLE IF NOT EXISTS city
(
    city_id   BIGSERIAL   NOT NULL PRIMARY KEY,
    city_name VARCHAR(50) NOT NULL
);

-- Добавьте в таблицу employee колонку city_id
ALTER TABLE employee
    ADD city_id BIGINT NULL;

-- Назначьте эту колонку внешним ключом. Свяжите таблицу employee с таблицей city
ALTER TABLE employee
    ADD FOREIGN KEY (city_id) REFERENCES city (city_id);

-- Заполните таблицу city
INSERT INTO city (city_name)
VALUES ('Moscow'),
       ('New-York'),
       ('London'),
       ('Canberra'),
       ('Paris');

-- Назначьте работникам соответствующие города
UPDATE employee
SET city_id = 1
WHERE id = 1;
UPDATE employee
SET city_id = 2
WHERE id = 2;
UPDATE employee
SET city_id = 3
WHERE id = 3;
UPDATE employee
SET city_id = 5
WHERE id = 4;
UPDATE employee
SET city_id = 2
WHERE id = 5;

-- 1. Получите имена и фамилии сотрудников, а также города, в которых они проживают
SELECT last_name || ' ' || first_name AS FIO, city_name
FROM employee
         INNER JOIN city ON employee.city_id = city.city_id;

-- 2. Получите города, а также имена и фамилии сотрудников, которые в них проживают.
-- Если в городе никто из сотрудников не живет, то вместо имени должен стоять null
SELECT city_name, last_name || ' ' || first_name AS FIO
FROM city
         LEFT JOIN employee on city.city_id = employee.city_id;

-- 3. Получите имена всех сотрудников и названия всех городов.
-- Если в городе не живет никто из сотрудников, то вместо имени должен стоять null.
-- Аналогично, если города для какого-то из сотрудников нет в списке, должен быть получен null
SELECT last_name || ' ' || first_name AS FIO, city_name
FROM employee
         FULL OUTER JOIN city c on employee.city_id = c.city_id;

-- 4. Получите таблицу, в которой каждому имени должен соответствовать каждый город
SELECT first_name, city_name
FROM employee
         CROSS JOIN city;

-- 5. Получите имена городов, в которых никто не живет
SELECT city_name
FROM city
         LEFT JOIN employee on city.city_id = employee.city_id
WHERE employee.first_name IS NULL
  AND employee.last_name IS NULL;