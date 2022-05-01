-- Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели.
-- Следует учесть, что необходимы дни недели текущего года, а не года рождения.
SELECT DATE_FORMAT(birthday, '%m.%d') AS b_day, count(DATE_FORMAT(birthday, '%m.%d')) AS b_day_count
    FROM profiles p INNER JOIN users u ON u.id=p.user_id
    GROUP BY b_day
    ORDER BY b_day_count