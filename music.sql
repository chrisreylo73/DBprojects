CREATE DATABASE music;
\c music 
CREATE TABLE Albums ( 
    id SERIAL PRIMARY KEY, 
    title VARCHAR NOT NULL, 
    artist VARCHAR NOT NULL, 
    year INT NOT NULL 
); 
CREATE TABLE Tracks ( 
    id INT NOT NULL, 
    num INT NOT NULL, 
    name VARCHAR(30) NOT NULL, 
    PRIMARY KEY (id, num), 
    FOREIGN KEY (id) REFERENCES Albums (id) 
);

CREATE FUNCTION check_year(year INT) RETURNS INT
    LANGUAGE plpgsql
    AS $$
        BEGIN 
            IF year  >= 1950 THEN 
                RETURN year;
            ELSE 
                RAISE EXCEPTION 'Hell nah % is less than 1950', year;
            END IF;
        END
    $$;

INSERT INTO Albums (title, artist, year) VALUES ('Roots', 'Sepultura', check_year(1925));
INSERT INTO Albums (title, artist, year) VALUES ('Roots', 'Sepultura', check_year(1996));
INSERT INTO Albums (title, artist, year) VALUES ('Morbid Visions', 'Sepultura', check_year(1986));

INSERT INTO Tracks VALUES (2, 1, 'Roots Bloody Roots'); 
INSERT INTO Tracks VALUES (2, 2, 'Attitude'); 
INSERT INTO Tracks VALUES (2, 3, 'Ratamahatta'); INSERT INTO Tracks VALUES (3, 1, 'Morbid Visions'); 
INSERT INTO Tracks VALUES (3, 2, 'Mayhem');
