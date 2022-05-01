-- Создайте представление, которое выводит название name товарной позиции из таблицы products
-- и соответствующее название каталога name из таблицы catalogs.

CREATE VIEW products_full AS
    SELECT p.name name, c.name catalog_name
        FROM products p LEFT JOIN catalogs c ON p.catalog_id=c.id