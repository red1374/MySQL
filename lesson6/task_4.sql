-- Определить кто больше поставил лайков (всего) - мужчины или женщины?
SELECT IF(male_likes > feamale_likes, 'Men!', 'Woman!') the_winners_are FROM (
    (
        SELECT count(id) male_likes FROM likes l 
        WHERE user_id IN (   
            SELECT u.id AS id
            FROM users u INNER JOIN profiles p ON u.id=p.user_id
            WHERE gender='m'
        )
    ) male_likes JOIN
    (
        SELECT count(id) feamale_likes FROM likes l 
        WHERE user_id IN (   
            SELECT u.id AS id
            FROM users u INNER JOIN profiles p ON u.id=p.user_id
            WHERE gender='f'
        )
    ) feamale_likes
);