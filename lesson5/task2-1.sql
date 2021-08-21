-- Подсчитайте средний возраст пользователей в таблице users.
SELECT AVG(ROUND(DATEDIFF(NOW(), birthday) / 365.25))
    FROM profiles p INNER JOIN users u ON u.id=p.user_id 