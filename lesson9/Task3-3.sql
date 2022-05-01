-- Число Фибоначи
DELIMITER //
DROP FUNCTION IF EXISTS FIBONACCI//
CREATE FUNCTION FIBONACCI(num INT)
RETURNS BIGINT DETERMINISTIC
BEGIN
    DECLARE counter, one, two INT;
    
    SET @two = 1;
    
    IF (num > 2) THEN
        SET @counter = 3;
        SET @one = 1;

        WHILE (num >= @counter) DO
            SET @two = @one + @two;
            SET @one = @two - @one;
            SET @counter = @counter + 1;
        END WHILE;
    END IF;
 
    RETURN @two;
END//

DELIMITER ;

SELECT FIBONACCI(11);