-- �������� �������� ������� hello(), ������� ����� ���������� �����������, � ����������� �� �������� ������� �����.
-- � 6:00 �� 12:00 ������� ������ ���������� ����� "������ ����", � 12:00 �� 18:00 ������� ������ ���������� ����� "������ ����",
-- � 18:00 �� 00:00 � "������ �����", � 00:00 �� 6:00 � "������ ����".

DELIMITER //

DROP FUNCTION IF EXISTS hello//
CREATE FUNCTION hello()
RETURNS VARCHAR(50) DETERMINISTIC
BEGIN    
    DECLARE huoers, minutes VARCHAR(2);

    SELECT DATE_FORMAT(NOW(), "%H") INTO huoers;

    IF (huoers >= 6 AND huoers < 12) THEN
        RETURN '������ ����';
    ELSEIF (huoers >= 12 AND huoers < 18) THEN 
        RETURN '������ ����';
    ELSEIF (huoers >= 18 AND huoers <= 23) THEN
        RETURN '������ �����';
    ELSE
        RETURN '������ ����';
    END IF;
END//

DELIMITER ;

SELECT hello();