-- »з таблицы users необходимо извлечь пользователей, родившихс€ в августе и мае.
-- ћес€цы заданы в виде списка английских названий (may, august)
SELECT CONCAT(firstname, ' ', lastname) AS FIO, date_format(birthday, '%d %M')
    FROM users u INNER JOIN profiles p ON u.id=p.user_id
    WHERE lower(date_format(birthday, '%M')) IN ('may', 'august') 