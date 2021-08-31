DROP DATABASE IF EXISTS crm;
CREATE DATABASE crm;
USE crm;

DROP TABLE IF EXISTS user_groups;
CREATE TABLE user_groups(
    id SERIAL,
    name VARCHAR(50) NOT NULL,
    created_at DATETIME DEFAULT now(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS users;
CREATE TABLE users(
    id SERIAL,  
    firstname VARCHAR(50) NOT NULL,
    lastname VARCHAR(50),
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(100) NOT NULL,
    phone INT(11) UNSIGNED UNIQUE,
    group_id BIGINT UNSIGNED,

    created_at DATETIME DEFAULT now(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
    
    PRIMARY KEY (id),
    FOREIGN KEY (group_id) REFERENCES user_groups(id),
    INDEX user_firstname_lastname_idx(firstname, lastname),
    INDEX user_email_idx(email)
);

DROP TABLE IF EXISTS sessions;
CREATE TABLE sessions(
    id SERIAL,  
    hash_string VARCHAR(255) NOT NULL UNIQUE,
    ip_address VARCHAR(50) NOT NULL,
    user_id BIGINT UNSIGNED,
    
    created_at DATETIME DEFAULT now(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS modules;
CREATE TABLE modules(
    id SERIAL,  
    name VARCHAR(50) NOT NULL,
    code VARCHAR(50) NOT NULL UNIQUE,
    created_at DATETIME DEFAULT now(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
    
    PRIMARY KEY (id),    
    INDEX modules_code_idx(code)
);

DROP TABLE IF EXISTS crm_options;
CREATE TABLE crm_options(
    id SERIAL,  
    name VARCHAR(50) NOT NULL,
    code VARCHAR(50) NOT NULL UNIQUE,
    value VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT now(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
    
    PRIMARY KEY (id),
    INDEX crm_options_code_idx(code)
);

DROP TABLE IF EXISTS pages;
CREATE TABLE pages(
    id SERIAL,
    name VARCHAR(50) NOT NULL,
    code VARCHAR(50) NOT NULL UNIQUE,
    `text` TEXT,
    module_id BIGINT UNSIGNED,
    keywords VARCHAR(50),
    description VARCHAR(100),
    title VARCHAR(100),
    created_at DATETIME DEFAULT now(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
    
    PRIMARY KEY (id),
    FOREIGN KEY (module_id) REFERENCES modules(id),
    INDEX pages_code_idx(code)
);

DROP TABLE IF EXISTS group_rules;
CREATE TABLE group_rules(
    id SERIAL,
    group_id BIGINT UNSIGNED,    
    name VARCHAR(50) NOT NULL,
    module_id BIGINT UNSIGNED NOT NULL,
    restriction_level ENUM('0', '1', '2') COMMENT '0 - access denied, 1 - read data, 2 - write data', 
    created_at DATETIME DEFAULT now(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    FOREIGN KEY (group_id) REFERENCES user_groups(id),
    FOREIGN KEY (module_id) REFERENCES modules(id)
);

DROP TABLE IF EXISTS region;
CREATE TABLE region(
    id SERIAL,  
    name VARCHAR(50) NOT NULL,
    parent_id BIGINT NOT NULL,
    created_at DATETIME DEFAULT now(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
    
    PRIMARY KEY (id),
    INDEX region_parent_idx(parent_id)
);

DROP TABLE IF EXISTS location;
CREATE TABLE location(
    id SERIAL,  
    name VARCHAR(50) NOT NULL,
    region_id BIGINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT now(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
    
    PRIMARY KEY (id),
    FOREIGN KEY (region_id) REFERENCES region(id)
);

DROP TABLE IF EXISTS company;
CREATE TABLE company(
    id SERIAL,  
    name VARCHAR(50) NOT NULL,
    location_id BIGINT UNSIGNED NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(100) NOT NULL UNIQUE,
    inn BIGINT NOT NULL UNIQUE,
    kpp BIGINT NOT NULL UNIQUE,
    address_office VARCHAR(255) NOT NULL,
    address_legal VARCHAR(255) NOT NULL,
    director VARCHAR(255) NOT NULL,
    bank_account_number BIGINT NOT NULL,
    bank_account_number_cor BIGINT NOT NULL,
    bank_name VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT now(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
    
    PRIMARY KEY (id),
    FOREIGN KEY (location_id) REFERENCES location(id),
    INDEX company_name_idx(name)
);

DROP TABLE IF EXISTS documents_type;
CREATE TABLE documents_type(
    id SERIAL,
    name VARCHAR(50) NOT NULL,    
    created_at DATETIME DEFAULT now(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
    
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS documents;
CREATE TABLE documents(
    id SERIAL,
    name VARCHAR(50) NOT NULL,
    document_type BIGINT UNSIGNED NOT NULL,
    company_id BIGINT UNSIGNED NOT NULL,
    file_path VARCHAR(50),
    created_at DATETIME DEFAULT now(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    FOREIGN KEY (document_type) REFERENCES documents_type(id),
    FOREIGN KEY (company_id) REFERENCES company(id)
);

DROP TABLE IF EXISTS product_access_type;
CREATE TABLE product_access_type(
    id SERIAL,
    name VARCHAR(50) NOT NULL UNIQUE,    
    created_at DATETIME DEFAULT now(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS product;
CREATE TABLE product(
    id SERIAL,
    name VARCHAR(50) NOT NULL UNIQUE,
    company_id BIGINT UNSIGNED NOT NULL,
    url VARCHAR(50) NOT NULL,
    description VARCHAR(255),
    
    created_at DATETIME DEFAULT now(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    FOREIGN KEY (company_id) REFERENCES company(id),
    INDEX product_company_idx(company_id)
);

DROP TABLE IF EXISTS product_access;
CREATE TABLE product_access(
    id SERIAL,
    name VARCHAR(50) NOT NULL,
    product_access_type BIGINT UNSIGNED NOT NULL,
    product_id BIGINT UNSIGNED NOT NULL,    
    login VARCHAR(50) NOT NULL,
    password_hash VARCHAR(50) NOT NULL,
    host VARCHAR(100) NOT NULL,
    `options` JSON,
    notes VARCHAR(255),    
    created_at DATETIME DEFAULT now(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    FOREIGN KEY (product_access_type) REFERENCES product_access_type(id),
    FOREIGN KEY (product_id) REFERENCES product(id)
);

DROP TABLE IF EXISTS service_type;
CREATE TABLE service_type(
    id SERIAL,
    name VARCHAR(50) NOT NULL UNIQUE,
    created_at DATETIME DEFAULT now(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS service;
CREATE TABLE service(
    id SERIAL,
    name VARCHAR(50) NOT NULL,
    service_type BIGINT UNSIGNED NOT NULL,
    company_id BIGINT UNSIGNED NOT NULL,
    prolongation_at DATETIME NOT NULL DEFAULT now(),
    product_access BIGINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT now(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    FOREIGN KEY (product_access) REFERENCES product_access(id),
    FOREIGN KEY (company_id) REFERENCES company(id),
    FOREIGN KEY (service_type) REFERENCES service_type(id)
);