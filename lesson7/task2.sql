-- Выведите список товаров products и разделов catalogs, который соответствует товару.
SELECT p.name product, price, c.name `section`
    FROM products p LEFT JOIN catalogs c ON p.catalog_id=c.id