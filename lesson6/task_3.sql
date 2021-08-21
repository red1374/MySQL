-- Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей
SELECT * FROM likes l 
WHERE user_id IN (
    SELECT user_id
    FROM profiles p
    ORDER BY birthday DESC
    LIMIT 10
)

SELECT
  firstname,
  IF(
    TIMESTAMPDIFF(YEAR, birthday_at, NOW()) >= 18,
    'совершеннолетний',
    'несовершеннолетний'
  ) AS status
FROM
  users;