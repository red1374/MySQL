-- ����������� ������ id = 1 �� ������� shop.users � ������� sample.users. ����������� ����������.
START TRANSACTION;
SELECT * FROM users u WHERE id=1;
INSERT INTO sample.users  
    SELECT * FROM users WHERE id=1;
COMMIT;