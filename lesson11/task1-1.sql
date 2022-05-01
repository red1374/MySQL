-- —оздайте таблицу logs типа Archive. ѕри каждом создании записи в 
-- таблицах users, catalogs и products в таблицу logs
-- помещаетс€ врем€ и дата создани€ записи, название таблицы,
-- идентификатор первичного ключа и содержимое пол€ name.

DROP TABLE IF EXISTS logs;
CREATE TABLE logs(
    created_at DATETIME NOT NULL DEFAULT NOW(),
    table_name VARCHAR(50) NOT NULL,
    record_id BIGINT NOT NULL,
    name VARCHAR(100) NOT NULL
) ENGINE=Archive;

DELIMITER //

-- Create triggers for tables: users, catalogs and products
DROP TRIGGER IF EXISTS log_new_user//
CREATE TRIGGER log_new_user AFTER INSERT ON users
FOR EACH ROW
BEGIN
    INSERT INTO logs SET 
        table_name='users',
        record_id=NEW.id,
        name=NEW.name;
END //

DROP TRIGGER IF EXISTS log_new_catalog//
CREATE TRIGGER log_new_catalog AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
    INSERT INTO logs SET 
        table_name='catalogs',
        record_id=NEW.id,
        name=NEW.name;
END //

DROP TRIGGER IF EXISTS log_new_products//
CREATE TRIGGER log_new_products AFTER INSERT ON products
FOR EACH ROW
BEGIN
    INSERT INTO logs SET 
        table_name='products',
        record_id=NEW.id,
        name=NEW.name;
END //
DELIMITER ;

-- Insert test data
INSERT INTO users SET name='Test User';
INSERT INTO catalogs SET name='Test catalog section';
INSERT INTO products SET name='Test product';

SELECT * FROM logs l;
