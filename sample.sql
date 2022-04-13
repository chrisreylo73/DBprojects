CREATE DATABASE sample; 

\c sample 

\timing 

DROP TABLE Sample;

CREATE TABLE Sample ( 
  id INT PRIMARY KEY,
  rnd INT NOT NULL 
); 

\COPY Sample (id, rnd) FROM 'C:\Users\chris\Downloads\sample\sample4.csv' DELIMITER ',' CSV HEADER;

SELECT * FROM Sample WHERE rnd = 5000000;
CREATE INDEX rnd ON Sample(rnd);
DROP INDEX rnd;
