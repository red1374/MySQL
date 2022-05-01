-- Выведите список рейсов flights с русскими названиями городов.
DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
    id serial,
    `from` varchar(50) NOT NULL,
    `to` varchar(50) NOT NULL
);

INSERT INTO flights VALUES
    (NULL, 'moscow', 'omsk'),
    (NULL, 'novgorod', 'kazan'),
    (NULL, 'irkutsk', 'moscow'),
    (NULL, 'omsk', 'irkutsk'),
    (NULL, 'moscow', 'kazan');


DROP TABLE IF EXISTS cities;
CREATE TABLE cities(
    `label` varchar(50) NOT NULL,
    `name` varchar(50) NOT NULL
);

INSERT INTO cities VALUES
    ('moscow', 'Москва'),
    ('novgorod', 'Новгород'),
    ('irkutsk', 'Иркутск'),
    ('omsk', 'Омск'),
    ('kazan', 'Казань');


SELECT id, c1.name `from`, c2.name `to`
    FROM flights f
        INNER JOIN cities c1 ON f.`from`=c1.label
        INNER JOIN cities c2 ON f.`to`=c2.label
ORDER BY id;