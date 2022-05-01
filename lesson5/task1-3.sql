-- ¬ таблице складских запасов storehouses_products в поле value могут встречатьс€ самые разные цифры:
-- 0, если товар закончилс€ и выше нул€, если на складе имеютс€ запасы. 
-- Ќеобходимо отсортировать записи таким образом, чтобы они выводились в пор€дке увеличени€ значени€ value.
-- ќднако нулевые запасы должны выводитьс€ в конце, после всех 
DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
    id serial,
    `value` INT(5) NOT NULL
);
INSERT INTO storehouses_products VALUES 
    (NULL, 0),
    (NULL, 2500),
    (NULL, 0),
    (NULL, 30),
    (NULL, 500),
    (NULL, 1);

SELECT `value`, IF(`value` = 0, 1, 0) AS on_storage FROM storehouses_products sp
    ORDER BY on_storage ASC, `value` ASC