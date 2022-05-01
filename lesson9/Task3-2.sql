-- ������� ������� ��� ������� produts. ��� ���������� ����� �������� ����������� ������ ��� ����� ����� (name � description)
-- ��� ������� ��������� ����� NULL-�������� ���������� �������� ��������.

DELIMITER //

DROP TRIGGER IF EXISTS check_name_and_description_on_insert//
CREATE TRIGGER check_name_and_description_on_insert BEFORE INSERT ON products
FOR EACH ROW
BEGIN
    IF NEW.name IS NULL AND NEW.description IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EMPTY "name" and "description" fields';
    END IF;
END//

DROP TRIGGER IF EXISTS check_name_and_description_on_update//
CREATE TRIGGER check_name_and_description_on_update BEFORE UPDATE ON products
FOR EACH ROW
BEGIN
    IF (NEW.name IS NULL AND NEW.description IS NULL) OR
    (NEW.name IS NULL AND OLD.description IS NULL) OR
    (OLD.name IS NULL AND NEW.description IS NULL)
    THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EMPTY "name" and "description" fields';
    END IF;
END//

DELIMITER ;

-- ���������� ������ � ������� ������ name � description ������� ������ -----
-- INSERT INTO products VALUES
--  (NULL, NULL, NULL, 1500, 1, NOW(), NOW());

INSERT INTO products VALUES
    (NULL, '������� �����', NULL, 1800, 1, NOW(), NOW());

SET @product_id=last_insert_id();

UPDATE products SET description=NULL
    WHERE id=@product_id;

-- ���������� ����� ������ ������� ������ --
-- UPDATE products SET name=NULL
--     WHERE id=@product_id;

-- UPDATE products SET name=NULL, description=NULL
--     WHERE id=@product_id;
UPDATE products SET name=NULL, description=NULL
    WHERE id=@product_id;

