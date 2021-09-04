-- ѕодсчитать общее количество лайков, которые получили 10 самых молодых пользователей
SELECT count(id) total_likes FROM likes l 
WHERE user_id IN (
    SELECT id FROM (
        SELECT u.id AS id, TIMESTAMPDIFF(YEAR, birthday, NOW()) years
        FROM users u INNER JOIN profiles p ON u.id=p.user_id
        ORDER BY years ASC
        LIMIT 10
    ) years
);