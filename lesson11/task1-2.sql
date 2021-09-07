-- Создайте SQL-запрос, который помещает в таблицу users миллион записей.
-- INSERT INTO users SET name='Test user 2';
-- INSERT INTO users SET name='Test user 3';
DELETE FROM users WHERE id > 10;

INSERT INTO users
    SELECT null, u1.name, u1.birthday_at, u1.created_at, u1.updated_at FROM users u1, users u2, users u3, users u4, users u5, users u6;

SELECT count(id) FROM users;