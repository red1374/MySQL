-- Пусть имеется любая таблица с календарным полем created_at.
-- Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей

DROP TABLE IF EXISTS test_dates_sorted;
CREATE TABLE test_dates_sorted (
    id serial,
    created_at DATE NOT NULL
);
INSERT INTO test_dates_sorted VALUES
    (NULL, '2018-08-01'),
    (NULL, '2016-08-04'),
    (NULL, '2011-02-04'),
    (NULL, '2018-08-16'),
    (NULL, '2015-01-15'),
    (NULL, '2020-11-11'),
    (NULL, '2018-08-17');

DROP TABLE IF EXISTS top_5;
CREATE TEMPORARY TABLE top_5 AS SELECT id FROM test_dates_sorted
    ORDER BY created_at DESC
    LIMIT 5;
    
DELETE FROM test_dates_sorted WHERE id NOT IN (SELECT * FROM top_5);

