CREATE DATABASE tester;

\c tester;

CREATE TYPE year_title_tracks AS (
    year INT,
    title VARCHAR,
    tracks INT
);

CREATE TABLE test (
    ytt year_title_tracks,
    blah VArCHAr
)

INSERT INTO test VALUES ((2022, 'a title', 20), 'a blah value');

CREATE TABLE Employees (
    ssn TEST PRIMARY KEY,
    name TEXT NOT NULL,
    sal FLOAT NOT NULL
);

CREATE TABLE H1BEmployees (
    number TEXT NOT NULL,
    country TEXT NOT NULL
) INHERITS (Employees);

INSERT INTO Employees VALUES
    ('1234','John',45000),
    ('2345','Mary',48000);

INSERT INTO H1BEmployees VALUES
    ('3456','Manuel',47000,'0101','Portugal');