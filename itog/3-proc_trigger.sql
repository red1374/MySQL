DELIMITER // 
-- Set title field if it's empty ------------
DROP TRIGGER IF EXISTS check_meta//
CREATE TRIGGER check_meta BEFORE INSERT ON pages
FOR EACH ROW
BEGIN
    IF (NEW.title IS NULL OR NEW.title = '') THEN
        SET NEW.title = NEW.name;
    END IF;
    IF (NEW.keywords IS NULL OR NEW.keywords = '') THEN
        SET NEW.keywords = NEW.name;
    END IF;
    IF (NEW.description IS NULL OR NEW.description = '') THEN
        SET NEW.description = NEW.name;
    END IF;
END//

-- Set title field if it's empty ------------
DROP TRIGGER IF EXISTS check_product_id//
CREATE TRIGGER check_product_id BEFORE INSERT ON product_access
FOR EACH ROW
BEGIN
    IF (NEW.product_id IS NULL OR NEW.product_id = 0) THEN
        SET NEW.product_id = get_product_id();
    END IF;    
END//

-- Get random product_access id -------------
DROP FUNCTION IF EXISTS next_p_access//
CREATE FUNCTION next_p_access()
RETURNS BIGINT DETERMINISTIC
BEGIN
    DECLARE p_access BIGINT; 
    SELECT id INTO p_access FROM product_access
    ORDER BY rand()
    LIMIT 1;

    RETURN p_access;
END//

-- Get random company id --------------------
DROP FUNCTION IF EXISTS get_company_id//
CREATE FUNCTION get_company_id()
RETURNS BIGINT DETERMINISTIC
BEGIN
    DECLARE company_id BIGINT; 
    SELECT id INTO company_id FROM company
    ORDER BY rand()
    LIMIT 1;

    RETURN company_id;
END//

-- Get random product id --------------------
DROP FUNCTION IF EXISTS get_product_id//
CREATE FUNCTION get_product_id()
RETURNS BIGINT DETERMINISTIC
BEGIN
    DECLARE product_id BIGINT; 
    SELECT id INTO product_id FROM product
    ORDER BY rand()
    LIMIT 1;

    RETURN product_id;
END//

DELIMITER ;