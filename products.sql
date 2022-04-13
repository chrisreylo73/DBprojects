CREATE DATABASE products;

\c products

DROP TABLE IF EXISTS Products;
CREATE TABLE Products (
    id SERIAL PRIMARY KEY,
    descr VARCHAR(30) NOT NULL,
    price FLOAT NOT NULL,
    cond VARCHAR DEFAULT 'new'
);

DROP FUNCTION IF EXISTS condition_checker;
CREATE FUNCTION condition_checker() RETURNS TRIGGER
    LANGUAGE plpgsql
    AS $$
        BEGIN
            IF LOWER(NEW.cond) != 'used' THEN
                NEW.cond = 'new';
            END IF;
            RETURN NEW;
        END;
    $$;

DROP TRIGGER IF EXISTS product_condition_updater ON Products;
CREATE TRIGGER product_condition_updater
    BEFORE INSERT ON Products
    FOR EACH ROW
    EXECUTE PROCEDURE condition_checker();


