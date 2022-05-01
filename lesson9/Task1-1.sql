-- Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.
START TRANSACTION;
SELECT * FROM users u WHERE id=1;
INSERT INTO sample.users  
    SELECT * FROM users WHERE id=1;
COMMIT;