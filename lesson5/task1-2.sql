-- Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR
-- и в них долгое время помещались значения в формате 20.10.2017 8:10.
-- Необходимо преобразовать поля к типу DATETIME, сохранив введённые ранее значения.
DROP TABLE IF EXISTS test_user;
CREATE TABLE test_user (
    id serial,
    name varchar(100) NOT NULL,
    created_at VARCHAR(50),
    updated_at VARCHAR(50)
);
INSERT INTO test_user VALUES 
    (NULL, 'user1', '20.10.2017 8:10', '12.04.2018 18:00'),
    (NULL, 'user2', '15.04.2010 2:10', '18.06.2018 17:01'),
    (NULL, 'user3', '08.07.2012 12:15', '14.08.2019 19:02');

UPDATE test_user SET created_at=STR_TO_DATE(created_at, '%d.%m.%Y %H:%i'), 
updated_at=STR_TO_DATE(updated_at, '%d.%m.%Y %H:%i');

ALTER TABLE test_user
    CHANGE created_at created_at DATETIME,
    CHANGE updated_at updated_at DATETIME