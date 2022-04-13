DROP TABLE IF EXISTS Interests;
DROP TABLE IF EXISTS Students;
DROP TABLE IF EXISTS Employers;
DROP TABLE IF EXISTS StudentInterests;
DROP TABLE IF EXISTS EmployerInterests;

CREATE TABLE IF NOT EXISTS Interests (
    abbrv VARCHAR PRIMARY KEY,
    descr VARCHAR 
);

CREATE TABLE IF NOT EXISTS Students (
    email VARCHAR PRIMARY KEY,
    name VARCHAR NOT NULL,
    major VARCHAR, -- NULL???
    graduation VARCHAR --NULL???
);

CREATE TABLE IF NOT EXISTS Employers (
    id INT PRIMARY KEY,
    name VARCHAR NOT NULL,
    size INT NOT NULL, 
    location VARCHAR NOT NULL,
    forProfit BOOLEAN NOT NULL, 
    govern BOOLEAN NOT NULL
);

CREATE TABLE IF NOT EXISTS StudentInterests (
    email VARCHAR,
    abbrv VARCHAR,
    PRIMARY KEY (email, abbrv),
    FOREIGN KEY (abbrv) REFERENCES Interests(abbrv),
    FOREIGN KEY (email) REFERENCES Students(email)
);

CREATE TABLE IF NOT EXISTS EmployerInterests (
    id INT,
    abbrv VARCHAR,
    PRIMARY KEY (id, abbrv),
    FOREIGN KEY (abbrv) REFERENCES Interests(abbrv),
    FOREIGN KEY (id) REFERENCES Employers(id)
);
 
INSERT INTO Interests VALUES
    ('android', 'Android Development'),
    ('app', 'Mobile App Development'),
    ('aws', 'Amazon Web Services'), 
    ('cloud', 'Cloud Computing'),
    ('cyber', 'Cyber Security'),
    ('db', 'Databases'),
    ('dba', 'Database Administrator'),
    ('edu', 'Education'),
    ('java', 'Java'),
    ('kotlin', 'Kotlin'), 
    ('mysql', 'MySQL'),
    ('postgres', 'Postgresql'), 
    ('python', 'Python'), 
    ('software', 'Software Development'),
    ('sql', 'SQL'),
    ('web', 'Web Development');


INSERT INTO Students VALUES 
    ('eastmanv@msudenver.edu', 'Virginia Eastman', 'cs', 'Spring 2022'),
    ('gilbertb@msudenver.edu', 'Barbara Gilbert', 'cs', 'Fall 2023'),
    ('zachariasr@msudenver.edu', 'Robert Zacharias', 'cs', 'Spring 2023');

INSERT INTO Employers VALUES 
    (101, 'Wonka Industries', 350, 'Lakewood, CO', true, false), 
    (202, 'Cheers Agency', 1000, 'Denver, CO', false, true),
    (303, 'Dominate the World', 5, 'Golden, CO', true, false), 
    (404, 'Stingers Org', 212, 'Denver, CO', false, false),
    (505, 'Easy Peasy', 1, 'Littleton, CO', true, false);

INSERT INTO StudentInterests VALUES 
    ('eastmanv@msudenver.edu', 'cloud'),
    ('eastmanv@msudenver.edu', 'db'),
    ('eastmanv@msudenver.edu', 'java'),
    ('eastmanv@msudenver.edu', 'mysql'),
    ('eastmanv@msudenver.edu', 'sql'),
    ('gilbertb@msudenver.edu', 'db'),
    ('gilbertb@msudenver.edu', 'python'),
    ('gilbertb@msudenver.edu', 'sql'),
    ('zachariasr@msudenver.edu', 'cloud'),
    ('zachariasr@msudenver.edu', 'edu'),
    ('zachariasr@msudenver.edu', 'web');

INSERT INTO EmployerInterests VALUES
    (101, 'db'),
    (101, 'dba'), 
    (101, 'java'), 
    (101, 'mysql'), 
    (101, 'postgres'), 
    (101, 'sql'),
    (202, 'aws'), 
    (202, 'cloud'), 
    (202, 'python'),
    (202, 'sql'),
    (303, 'cloud'),
    (303, 'cyber'),
    (303, 'java'),
    (303, 'web'),
    (404, 'postgres'),
    (404, 'python'),
    (404, 'sql'),
    (505, 'java');