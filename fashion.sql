CREATE DATABASE fashion;

\c fashion

DROP TABLE Casting;
DROP Table Models;
DROP TABLE FashionShow;
DROP TABLE Models;

CREATE TABLE FashionShow (
 number SERIAL PRIMARY KEY, 
 title VARCHAR NOT NULL, 
 venue VARCHAR NOT NULL, 
 start DATE NOT NULL, 
 "end" DATE NOT NULL, 
 time TIME NOT NULL
);

INSERT INTO FashionShow (title, venue, start, "end", time) VALUES
 ( 'Colorado Fashion Week', 'The Commons on Champa', '2022-06-01', '2022-06-05', '18:30:00' );

CREATE TABLE Designers (
 code CHAR(5) PRIMARY KEY, 
 name VARCHAR NOT NULL, 
 rank INT NOT NULL
);

INSERT INTO Designers VALUES
 ( 'RL', 'Ralph Lauren', 1 ), 
 ( 'GA', 'Giorgio Armani', 1 ), 
 ( 'DG', 'Dolce & Gabbana', 3 );

CREATE TABLE Participants (
 fashionShow INT, 
 designerCode CHAR(5), 
 PRIMARY KEY (fashionShow, designerCode), 
 FOREIGN KEY (fashionShow) REFERENCES FashionShow (number), 
 FOREIGN KEY (designerCode) REFERENCES Designers (code)
);

-- TODO #1 (2 points): add 'Ralph Lauren' and 'Dolce & Gabbana' as participants in the 'Colorado Fashion Week'
INSERT INTO Participants VALUES
(1,'RL'),
(1,'DG');


CREATE TABLE Models (
 id SERIAL PRIMARY KEY, 
 name VARCHAR NOT NULL, 
 gender CHAR(1) NOT NULL,
 heightFt INT NOT NULL, 
 heightIn INT NOT NULL, 
 weightLbs INT
);

INSERT INTO Models (name, gender, heightFt, heightIn, weightLbs ) VALUES
 ( 'Gisele Bunchen', 'F', 5, 11, 121 ), 
 ( 'Armando Cabral', 'M', 6, 2, NULL), 
 ( 'Anna Hickmann', 'F', 6, 1, 141);

-- TODO #2 (3 points): create a table called "Casting" that allocates models to fashion show events (make sure to identify primary key and foreign key constraints)
CREATE TABLE Casting (
    fashionShow Int,
    modelsId Int,
    PRIMARY KEY (modelsId, fashionShow), 
    FOREIGN KEY (fashionShow) REFERENCES FashionShow (number),
    FOREIGN KEY (modelsId) REFERENCES Models (id)
);

INSERT INTO Casting VALUES
 ( 1, 1 ), 
 ( 1, 2 ), 
 ( 1, 3 );

-- TODO #3 (3 points): create a list of fashion show title and designer (names) that are participating in the fashion show, sorted alphabetically by fashion show title, followed by designer's name
SELECT B.name, A.title FROM FashionShow A, Designers B, Participants C WHERE A.number = C.fashionShow 
AND B.code = C.designerCode GROUP BY B.name, A.title ORDER BY A.title, B.name;
-- TODO #4 (2 points): show the number of models casting per fashion show 
SELECT COUNT(C.modelsID) AS "Number of Models", A.title AS "Fashion Show Title" FROM FashionShow A, Models B, Casting C WHERE A.number = C.fashionShow 
AND B.id = C.modelsId GROUP BY A.title;
-- TODO #5 (2 points): show the name of the models that are at least 6ft tall
SELECT name FROM Models WHERE heightFt = 6 GROUP BY name ORDER BY 1;
-- TODO #6 (1 point): show the name of all male models
SELECT name FROM Models WHERE gender = 'M' GROUP BY name ORDER BY 1;
-- TODO #7 (2 points): show the name of the fashion designers that are not presenting at any fashion show
SELECT B.name FROM FashionShow A, Designers B, Participants C WHERE B.code NOT IN (SELECT designerCode FROM Participants) GROUP BY B.name ORDER BY 1;
-- TODO #8 (2 points): show the name of the designer currently ranked the lowest
SELECT name FROM Designers  WHERE rank = (SELECT MAX(rank) FROM Designers);
-- TODO #9 (3 points): create a new fashion show, adding at least 1 designer, and casting 'Armando Cabral'
INSERT INTO FashionShow (title, venue, start, "end", time) VALUES
('The Fashion Show','MSU Denver', '2022-07-01', '2022-07-05', '18:30:00');
INSERT INTO Participants VALUES
(2,'RL');
INSERT INTO Casting VALUES
(2,2);
