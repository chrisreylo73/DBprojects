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
        Rndrng_Prvdr_State_Abrvtn CHAR(2), 
        Rndrng_Prvdr_State_FIPS CHAR (2) NOT NULL, 
        Rndrng_CCN CHAR(6),
        PRIMARY KEY (Rndrng_Prvdr_State_Abrvtn, Rndrng_CCN),
        FOREIGN KEY (Rndrng_CCN) REFERENCES Providers (Rndrng_CCN)
    );

    CREATE TABLE Ruca( 
        Rndrng_Prvdr_RUCA VARCHAR, 
        Rndrng_Prvdr_RUCA_Desc VARCHAR NOT NULL,
        Rndrng_Prvdr_Zip5 VARCHAR NOT NULL,
        Rndrng_CCN CHAR(6),
        PRIMARY KEY (Rndrng_Prvdr_RUCA, Rndrng_CCN),
        FOREIGN KEY (Rndrng_CCN) REFERENCES Providers (Rndrng_CCN)
    );

-- TODO: create users 
   DROP ROLE IF EXISTS "cms_admin", "cms";
   CREATE USER "cms_admin" PASSWORD '024680';
   CREATE USER "cms" PASSWORD '135791';
-- TODO: grant access to users 
-- Not correct but this is the idea (come back to this)
   GRANT ALL ON TABLE Providers TO "cms_admin";
   GRANT ALL ON Table Drgs TO "cms_admin";
   GRANT ALL ON Table Finances TO "cms_admin";
   GRANT ALL ON Table ProviderStates TO "cms_admin";
   GRANT ALL ON Table Ruca TO "cms_admin";

   GRANT SELECT ON TABLE Providers TO "cms"; 
   GRANT SELECT ON TABLE Drgs TO "cms";
   GRANT SELECT ON TABLE Finances TO "cms"; 
   GRANT SELECT ON TABLE ProviderStates TO "cms";
   GRANT SELECT ON TABLE Ruca TO "cms";
-- TODO: answer all queries

-- a) List all diagnostic names in alphabetical order.   
    SELECT DRG_Desc AS "Diagnostic Names" FROM Drgs ORDER BY 1;
-- b) List the names and correspondent states (including Washington D.C.) of all of the providers in alphabetical order (state first, provider name next, no repetition).   
    SELECT b.Rndrng_Prvdr_State_Abrvtn, a.Rndrng_Prvdr_Org_Name FROM Providers a, ProviderStates b WHERE a.Rndrng_CCN = b.Rndrng_CCN GROUP BY b.Rndrng_Prvdr_State_Abrvtn, a.Rndrng_Prvdr_Org_Name ORDER BY 1;
-- c) List the total number of providers.  
    SELECT COUNT(*) FROM Providers;  
-- d) List the total number of providers per state (including Washington D.C.) in alphabetical order (also printing out the state). 
    SELECT a.Rndrng_Prvdr_State_Abrvtn, count(b.Rndrng_CCN) FROM ProviderStates a, Providers b WHERE a.Rndrng_CCN = b.Rndrng_CCN GROUP BY a.Rndrng_Prvdr_State_Abrvtn ORDER BY 1;
-- e) List the providers names in Denver (CO) or in Lakewood (CO) in alphabetical order 
    SELECT Rndrng_Prvdr_Org_Name FROM Providers WHERE Rndrng_Prvdr_City = 'Denver' OR Rndrng_Prvdr_City = 'Lakewood' ORDER BY 1;
-- f) List the number of providers per RUCA code (showing the code and description)
    SELECT COUNT(a.Rndrng_CCN) AS "Number of Providers", Rndrng_Prvdr_RUCA, Rndrng_Prvdr_RUCA_Desc FROM Providers a, Ruca b WHERE a.Rndrng_CCN = b.Rndrng_CCN GROUP BY  Rndrng_Prvdr_RUCA, Rndrng_Prvdr_RUCA_Desc;
-- g) Show the DRG description for code 308
    SELECT DRG_Desc FROM Drgs WHERE DRG_Cd = '308';
-- h) List the top 10 providers (with their correspondent state) that charged (as described in Avg_Submtd_Cvrd_Chrg) the most for the DRG code 308. Output should display the provider name, their city, state, and the average charged amount in descending order.  
    SELECT a.Rndrng_Prvdr_Org_Name, a.Rndrng_Prvdr_City, b.Rndrng_Prvdr_State_Abrvtn, c.Avg_Submtd_Cvrd_Chrg FROM Providers a, ProviderStates b, Finances c WHERE a.Rndrng_CCN = b.Rndrng_CCN AND a.Rndrng_CCN = c.Rndrng_CCN AND c.DRG_Cd = '308' ORDER BY c.Avg_Submtd_Cvrd_Chrg DESC LIMIT 10;
-- i) List the average charges (as described in Avg_Submtd_Cvrd_Chrg) of all providers per state for the DRG code 308. Output should display the state and the average charged amount per state in descending order (of the charged amount) using only two decimals.   
    SELECT a.Rndrng_Prvdr_State_Abrvtn, ROUND(AVG(b.Avg_Submtd_Cvrd_Chrg),2) AS "Avg Charges" FROM ProviderStates a, Finances b WHERE b.Rndrng_CCN = a.Rndrng_CCN AND DRG_Cd = '308' GROUP BY Rndrng_Prvdr_State_Abrvtn ORDER BY "Avg Charges" DESC;
-- j) Which provider and clinical condition pair had the highest difference between the amount charged (as described in Avg_Submtd_Cvrd_Chrg) and the amount covered by Medicare only (as described in Avg_Mdcr_Pymt_Amt)?  
    SELECT a.Rndrng_Prvdr_Org_Name, b.DRG_Desc, c.Avg_Submtd_Cvrd_Chrg - c.Avg_Mdcr_Pymt_Amt AS "Difference" FROM Providers a, Drgs b, Finances c WHERE a.Rndrng_CCN = c.Rndrng_CCN AND b.DRG_Cd = c.DRG_Cd ORDER BY "Difference" DESC LIMIT 1;
-- TODO (optional) - BONUS POINTS: prove that you didn't do the normalization only using your "guts" but also what you learned in class; show all 2NF or 3NF violations and normalization steps in detail and you will get up to +10 points.

-- 2NF

-- Key is { Rndrng_CCN, DRG_Cd }

-- 2NF Violations:

-- Rndrng_CCN -> Rndrng_Prvdr_Org_Name, Rndrng_Prvdr_St, Rndrng_Prvdr_City,  Rndrng_Prvdr_State_Abrvtn, Rndrng_Prvdr_State_FIPS, Rndrng_Prvdr_Zip5, Rndrng_Prvdr_RUCA, Rndrng_Prvdr_RUCA_Desc

-- DRG_Cd -> DRG_Desc

-- Relational schema after 2NF Normalization:

-- Providers (Rndrng_CCN*, Rndrng_Prvdr_Org_Name, Rndrng_Prvdr_St, Rndrng_Prvdr_City,  Rndrng_Prvdr_State_Abrvtn, Rndrng_Prvdr_State_FIPS, Rndrng_Prvdr_Zip5, Rndrng_Prvdr_RUCA, Rndrng_Prvdr_RUCA_Desc)

-- Drgs(DRG_Cd*, DRG_Desc)

-- Finances(Rndrng_CCN*, DRG_Cd*, Tot_Dschrgs, Avg_Submtd_Cvrd_Chrg, Avg_Tot_Pymt_Amt, Avg_Mdcr_Pymt_Amt)


-- 3NF

-- 3NF Violations:

-- Rndrng_Prvdr_State_Abrvtn -> Rndrng_Prvdr_State_FIPS, Rndrng_CCN

-- Rndrng_Prvdr_RUCA -> Rndrng_Prvdr_RUCA_Desc, Rndrng_Prvdr_Zip5, Rndrng_CCN


-- Relational schema after 3NF Normalization:

-- Providers(Rndrng_CCN*, Rndrng_Prvdr_Org_Name, Rndrng_Prvdr_St, Rndrng_Prvdr_City)

-- Drgs(DRG_Cd*, DRG_Desc)

-- Finances(Rndrng_CCN*, DRG_Cd*, Tot_Dschrgs, Avg_Submtd_Cvrd_Chrg, Avg_Tot_Pymt_Amt, Avg_Mdcr_Pymt_Amt)

-- ProviderState(Rndrng_Prvdr_State_Abrvtn*, Rndrng_CCN*, Rndrng_Prvdr_State_FIPS)

-- Ruca(Rndrng_Prvdr_RUCA*,  Rndrng_CCN*, Rndrng_Prvdr_RUCA_Desc, Rndrng_Prvdr_Zip5)
