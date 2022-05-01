-- Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток.
-- С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день",
-- с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".

DELIMITER //

DROP FUNCTION IF EXISTS hello//
CREATE FUNCTION hello()
RETURNS VARCHAR(50) DETERMINISTIC
BEGIN    
    DECLARE huoers, minutes VARCHAR(2);

    SELECT DATE_FORMAT(NOW(), "%H") INTO huoers;

    IF (huoers >= 6 AND huoers < 12) THEN
        RETURN 'Доброе утро';
    ELSEIF (huoers >= 12 AND huoers < 18) THEN 
        RETURN 'Добрый день';
    ELSEIF (huoers >= 18 AND huoers <= 23) THEN
        RETURN 'Добрый вечер';
    ELSE
        RETURN 'Доброй ночи';
    END IF;
END//

DELIMITER ;

SELECT hello();