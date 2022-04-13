CREATE DATABASE orders;

\c orders;

DROP TABLE IF EXISTS Orders;

DROP TABLE IF EXISTS Items;

DROP TABLE IF EXISTS Products;


CREATE TABLE Orders (

    number INT NOT NULL PRIMARY KEY,

    date DATE NOT NULL

);


CREATE TABLE Products (

    id SERIAL PRIMARY KEY,

    "desc" VARCHAR NOT NULL,

    price FLOAT NOT NULL,

    CHECK (price >= 0)

);


CREATE TABLE Items (

    "order" INT NOT NULL,

    item INT NOT NULL,

    qtt INT NOT NULL,

    PRIMARY KEY ("order"),

    FOREIGN KEY ("order") REFERENCES Orders (number),

    FOREIGN KEY (item) REFERENCES Products (id)

);


CREATE FUNCTION check_qtt_before_insert() RETURNS TRIGGER

    LANGUAGE plpgsql

    AS $$

        BEGIN

            IF NEW.qtt < 1 THEN

                NEW.qtt = 1;

            END IF;

            RETURN NEW;

        END;

    $$;

    CREATE TRIGGER items_qtt_at_least_1

    BEFORE INSERT ON Items

    FOR EACH ROW

    EXECUTE PROCEDURE check_qtt_before_insert();

    INSERT INTO Products ("desc", price) VALUES ('Ninja Sword', 250.00);

    INSERT INTO Products VALUES ('Dummy', 50.00);

INSERT INTO Products VALUES ('Fake Blood', 5.00);

INSERT INTO Products VALUES ('Rubber Ducky', 1.00);

INSERT INTO Products VALUES ('Bathtub Soap', 3.00);

INSERT INTO Products VALUES ('Brazilian Coffee', 5.00);

INSERT INTO Products VALUES ('Running Shoes', 50.00);



INSERT INTO Orders VALUES (101, '2020-09-12');

INSERT INTO Orders VALUES (202, '2021-09-27');

INSERT INTO Orders VALUES (303, '2021-09-30');

INSERT INTO Orders VALUES (404, '2021-10-12');


INSERT INTO Items VALUES (101, 1, -1);

INSERT INTO Items VALUES (101, 2, 10);

INSERT INTO Items VALUES (101, 3, 5);

INSERT INTO Items VALUES (202, 4, 200);

INSERT INTO Items VALUES (202, 6, 10);

INSERT INTO Items VALUES (303, 7, 0);

INSERT INTO Items VALUES (303, 1, 10);

INSERT INTO Items VALUES (404, 4, 1);

INSERT INTO Items VALUES (404, 7, 3);