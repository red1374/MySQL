-- Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); 
-- Отсортируйте записи в порядке, заданном в списке IN.
SELECT FIELD(id, 261, 205, 279) AS sorted, id FROM users WHERE id IN (261, 205, 279)
    ORDER BY sorted;