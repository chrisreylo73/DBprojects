-- Team Members: Juan Ruiz, Chris Lopez

-- TODOd: create the cms database
    CREATE DATABASE cms;

-- TODOd: "open" the database for use
    \c cms

-- TODO: (optional) drop all tables
    DROP TABLE IF EXISTS Providers, Drgs, Finances, ProviderStates, Ruca;
-- TODO: create all tables (with primary keys, NULL constraints, and foreign keys)
    
    CREATE TABLE Providers(
        Rndrng_CCN CHAR(6),
        Rndrng_Prvdr_Org_Name VARCHAR NOT NULL,
        Rndrng_Prvdr_St VARCHAR NOT NULL,  
        Rndrng_Prvdr_City VARCHAR NOT NULL,  
        PRIMARY KEY (Rndrng_CCN)
    );

    CREATE TABLE Drgs(
        DRG_Cd CHAR(3),
        DRG_Desc VARCHAR NOT NULL,
        PRIMARY KEY (DRG_Cd)
    );
    --(COME BACK TO THIS NOT SURE ABOUT DECIMAL DATATYPE)
    CREATE TABLE Finances(
        Rndrng_CCN CHAR(6), 
        DRG_Cd CHAR(3), 
        Tot_Dschrgs INT NOT NULL, 
        Avg_Submtd_Cvrd_Chrg DECIMAL NOT NULL,
        Avg_Tot_Pymt_Amt DECIMAL NOT NULL, 
        Avg_Mdcr_Pymt_Amt DECIMAL NOT NULL,
        PRIMARY KEY (Rndrng_CCN, DRG_Cd) 
    );

    CREATE TABLE ProviderStates(
        Rndrng_Prvdr_State_Abrvtn CHAR(2) NOT NULL, 
        Rndrng_Prvdr_State_FIPS CHAR (2) NOT NULL, 
        Rndrng_CCN CHAR(6),
        PRIMARY KEY (Rndrng_Prvdr_State_Abrvtn),
        FOREIGN KEY (Rndrng_CCN) REFERENCES Providers (Rndrng_CCN)
    );

    CREATE TABLE Ruca( 
        Rndrng_Prvdr_RUCA VARCHAR, 
        Rndrng_Prvdr_RUCA_Desc VARCHAR NOT NULL,
        Rndrng_Prvdr_Zip5 VARCHAR NOT NULL,
        Rndrng_CCN VARCHAR,
        PRIMARY KEY (Rndrng_Prvdr_RUCA),
        FOREIGN KEY (Rndrng_CCN) REFERENCES Providers (Rndrng_CCN)
    );

-- TODO: create users 
   -- CREATE USER "cms_admin" PASSWORD '024680';
   -- CREATE USER "cms" PASSWORD '135791';
-- TODO: grant access to users 
-- Not correct but this is the idea (come back to this)
   GRANT ALL ON TABLE Providers TO "cms_admin";
   GRANT ALL ON Table Drgs TO "cms_admin";
   GRANT ALL ON Table Finances TO "cms_admin";
   GRANT ALL ON Table ProviderStates TO "cms_admin";
   GRANT ALL ON Table Ruca TO "cms_admin";

   -- GRANT SELECT ON TABLE Employees TO "cms";
-- TODO: answer all queries

-- a) List all diagnostic names in alphabetical order.   
    
-- b) List the names and correspondent states (including Washington D.C.) of all of the providers in alphabetical order (state first, provider name next, no repetition).   
  
-- c) List the total number of providers.  
  
-- d) List the total number of providers per state (including Washington D.C.) in alphabetical order (also printing out the state). 
    SELECT DISTICT count(Rndrng_CCN), Rndrng_Prvdr_State_Abrvtn FROM ProviderStates a, Providers b WHERE a.Rndrng_Prvdr_State_Abrvtn = b.Rndrng_Prvdr_State_Abrvtn GROUP BY  Rndrng_Prvdr_State_Abrvtn;
-- e) List the providers names in Denver (CO) or in Lakewood (CO) in alphabetical order 

-- f) List the number of providers per RUCA code (showing the code and description)

-- g) Show the DRG description for code 308
  
-- h) List the top 10 providers (with their correspondent state) that charged (as described in Avg_Submtd_Cvrd_Chrg) the most for the DRG code 308. Output should display the provider name, their city, state, and the average charged amount in descending order.  

-- i) List the average charges (as described in Avg_Submtd_Cvrd_Chrg) of all providers per state for the DRG code 308. Output should display the state and the average charged amount per state in descending order (of the charged amount) using only two decimals.   
 
-- j) Which provider and clinical condition pair had the highest difference between the amount charged (as described in Avg_Submtd_Cvrd_Chrg) and the amount covered by Medicare only (as described in Avg_Mdcr_Pymt_Amt)?  

-- TODO (optional) - BONUS POINTS: prove that you didn't do the normalization only using your "guts" but also what you learned in class; show all 2NF or 3NF violations and normalization steps in detail and you will get up to +10 points.
