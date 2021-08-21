-- ���������� ����� ���������� ������, ������� �������� 10 ����� ������� �������������
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
    '����������������',
    '������������������'
  ) AS status
FROM
  users;