-- Список пользователей users, у которых есть хотя бы один заказ в orders.
INSERT INTO orders VALUES
(NULL, 5, now(), now()),
(NULL, 2, now(), now()),
(NULL, 3, now(), now()),
(NULL, 5, now(), now());

SELECT id, name FROM users u
WHERE id IN (SELECT DISTINCT user_id FROM orders o)