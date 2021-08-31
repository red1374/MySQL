-- VIEWS -------------------------------------------------------------
-- Create view with users list who has read access level to news module
CREATE OR REPLACE VIEW users_news_read_access AS
    SELECT u.id user_id,
        concat(u.lastname, ' ', u.firstname) user_name,
        GROUP_CONCAT(gr.restriction_level SEPARATOR ',') access_levels,
        GROUP_CONCAT(gr.name SEPARATOR ',') access_names
--         CASE gr.restriction_level
--             WHEN '0' THEN 'access denied'
--             WHEN '1' THEN 'read data'
--             WHEN '2' THEN 'write data'
--         END AS access_text
        FROM users u
            INNER JOIN user_groups ug ON u.group_id=ug.id
            INNER JOIN group_rules gr ON ug.id=gr.group_id
            LEFT JOIN modules m ON m.id=gr.module_id
        WHERE gr.restriction_level IN ('1', '2') AND m.code='news'
        GROUP BY user_id
        ORDER BY user_id;

-- Create company table view for Moscow manager ---------------------
    CREATE OR REPLACE VIEW company_moscow AS
    SELECT *
        FROM company c
        WHERE location_id=20;
    

-- QUERIES ----------------------------------------------------------
-- Check trigger pages.check_meta -----------------
INSERT INTO pages(name, code, text) VALUES
    ('Test page', 'test_page', 'Text Text Text Text');

-- Get company products ---------------------------
SET @company_id=2;
SELECT * FROM product p WHERE company_id=@company_id;

-- Get top 5 companies products count -------------
SELECT c.name company, count(p.id) products
    FROM product p LEFT JOIN company c ON p.company_id=c.id
    GROUP BY company_id
    ORDER BY products DESC
    LIMIT 5;

-- Get domains for prolongation on the next month -
-- Insert test data
INSERT INTO service(name, service_type,prolongation_at,product_access, company_id) VALUES
    ('domain.com', 2, DATE_ADD(NOW(), INTERVAL 15 DAY), next_p_access(), get_company_id());
INSERT INTO service(name, service_type,prolongation_at,product_access, company_id) VALUES
    ('domain1.com', 2, DATE_ADD(NOW(), INTERVAL 10 DAY), next_p_access(), get_company_id());
INSERT INTO service(name, service_type,prolongation_at,product_access, company_id) VALUES
    ('old_domain.com', 2, DATE_ADD(NOW(), INTERVAL -1 DAY), next_p_access(), get_company_id());
INSERT INTO service(name, service_type,prolongation_at,product_access, company_id) VALUES
    ('domain-5.com', 2, DATE_ADD(NOW(), INTERVAL 20 DAY), next_p_access(), get_company_id());

-- Get domains list for prolongation
SELECT s.name domain_name, c.name company, datediff(prolongation_at, NOW()) AS days
    FROM service s LEFT JOIN company c ON s.company_id=c.id
    WHERE service_type=2 AND prolongation_at BETWEEN now() AND DATE_ADD(NOW(), INTERVAL 1 MONTH)
    ORDER BY days ASC;

-- Get all product access list for given product_id
SET @product_id=1;
SELECT pa.name _name, pat.name `type`, login, host, `options`, notes
    FROM product_access pa LEFT JOIN product_access_type pat ON pa.product_access_type=pat.id
    WHERE product_id=@product_id;

-- Get users list ---------------------------------
SELECT concat(u.lastname, ' ', u.firstname) fio, ug.name `group`
    FROM users u 
        INNER JOIN user_groups ug ON u.group_id=ug.id
    



-- FIX. Fix bugs ----------------------------------
-- ALTER TABLE service ADD company_id BIGINT UNSIGNED NOT NULL AFTER service_type;

-- UPDATE service SET company_id=get_company_id()
--     WHERE company_id IS NULL OR !company_id
--     LIMIT 10;

-- ALTER TABLE service ADD CONSTRAINT fk_service_type FOREIGN KEY (service_type) REFERENCES service_type(id);

-- ALTER TABLE product_access ADD product_id BIGINT UNSIGNED NOT NULL AFTER product_access_type;
-- UPDATE product_access SET product_id=get_product_id()
--      WHERE product_id IS NULL OR !product_id;

-- ALTER TABLE product_access ADD CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES product(id);

-- ALTER TABLE product_access DROP CONSTRAINT product_access_ibfk_2;
-- ALTER TABLE product_access DROP COLUMN company_id;