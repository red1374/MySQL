-- Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.
-- SELECT count(id) total_likes, u.id user_id FROM ()
-- 1 Вариант: пользователи с меньшим количеством лайков
SELECT concat(lastname, ' ', firstname) fio, total_likes
    FROM users u INNER JOIN (
        SELECT count(id) total_likes, user_id FROM likes
            GROUP BY user_id
            ORDER BY total_likes
            LIMIT 10
        ) user_likes ON u.id=user_likes.user_id;

-- 2 Вариант: пользователи с наименьшим количеством запросов на дружбу
SELECT concat(lastname, ' ', firstname) fio, total_requests
    FROM users u INNER JOIN (
        SELECT count(*) total_requests, initiator_user_id user_id FROM friends_request fr
        GROUP BY initiator_user_id
        ORDER BY total_requests
        LIMIT 10
    ) user_requests ON u.id=user_requests.user_id;

-- 3 Вариант: пользователи с меньшим числом отправленных сообщений
SELECT concat(lastname, ' ', firstname) fio, total_msges
    FROM users u INNER JOIN (
        SELECT count(*) total_msges, from_user_id user_id FROM mesasages m 
        GROUP BY from_user_id
        ORDER BY total_msges
        LIMIT 10
    ) user_msges ON u.id=user_msges.user_id;

-- 4 Вариант: с меньшим количеством групп
SELECT concat(lastname, ' ', firstname) fio, total_comunities
    FROM users u INNER JOIN (
        SELECT count(*) total_comunities, user_id FROM users_comunities uc 
        GROUP BY user_id
        ORDER BY total_comunities
        LIMIT 10
    ) user_comunities ON u.id=user_comunities.user_id;